from flask import Flask, request, jsonify, render_template
import os
from dotenv import load_dotenv
from database import DatabaseManager
from gemini_handler import GeminiChatbot
import json

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Khởi tạo database manager
db = DatabaseManager(
    server=os.getenv('DB_SERVER', 'localhost'),
    database=os.getenv('DB_NAME', 'TourismChatbot'),
    username=os.getenv('DB_USERNAME'),
    password=os.getenv('DB_PASSWORD'),
    trusted_connection=os.getenv('DB_TRUSTED_CONNECTION', 'true').lower() == 'true'
)

# Khởi tạo Gemini chatbot
gemini_api_key = os.getenv('GEMINI_API_KEY')
if not gemini_api_key:
    raise ValueError("GEMINI_API_KEY environment variable is required")

chatbot = GeminiChatbot(gemini_api_key)

@app.route('/')
def home():
    """Trang chủ"""
    return render_template('index.html')

@app.route('/api/chat', methods=['POST'])
def chat():
    """API endpoint cho chatbot"""
    try:
        data = request.get_json()
        user_message = data.get('message', '').strip()
        
        if not user_message:
            return jsonify({
                'success': False,
                'message': 'Vui lòng nhập tin nhắn'
            })
        
        # Phát hiện ngôn ngữ
        language = chatbot.detect_language(user_message)
        
        # Trích xuất từ khóa và ý định
        extracted_info = chatbot.extract_keywords(user_message, language)
        
        # Tìm kiếm dữ liệu dựa trên chủ đề
        search_results = []
        topic = extracted_info.get('topic', 'general')
        keywords = extracted_info.get('keywords', [])
        
        if topic == 'destinations' and keywords:
            for keyword in keywords:
                results = db.search_destinations(keyword, language)
                search_results.extend(results)
        elif topic == 'culture' and keywords:
            for keyword in keywords:
                results = db.search_culture(keyword, language)
                search_results.extend(results)
        elif topic == 'cuisine' and keywords:
            for keyword in keywords:
                results = db.search_cuisine(keyword, language)
                search_results.extend(results)
        elif topic == 'activities' and keywords:
            for keyword in keywords:
                results = db.search_activities(keyword, language)
                search_results.extend(results)
        elif topic == 'hotels' and keywords:
            for keyword in keywords:
                results = db.search_hotels(keyword, language)
                search_results.extend(results)
        elif topic == 'transportation' and keywords:
            if len(keywords) >= 2:
                origin = keywords[0]
                destination = keywords[1]
            else:
                origin = "TP.Hồ Chí Minh" if language == "vi" else "Ho Chi Minh City"
                destination = keywords[0]
            results = db.search_transportation(origin, destination, language)
            search_results.extend(results)
        elif topic == 'restaurants' and keywords:
            for keyword in keywords:
                results = db.search_restaurants(keyword, language)
                search_results.extend(results)
        elif topic == "trip_cost_estimation":
            destination = extracted_info.get("destination", "")
            people = int(extracted_info.get("people", 1))  # nếu user không nói rõ thì mặc định = 1
            days = int(extracted_info.get("days", 1))

            # --- Query dữ liệu từ SQL ---
            transport = db.search_transportation("TP.Hồ Chí Minh", destination, language)
            hotels = db.search_hotels(destination, language)
            restaurants = db.search_restaurants(destination, language)
            activities = db.search_activities(destination, language)

            # Gom data context
            data_context = {
                "transportation": transport[:3],   # lấy tối đa 3 gợi ý
                "hotels": hotels[:3],
                "restaurants": restaurants[:3],
                "activities": activities[:3],
                "people": people,
                "days": days
            }

            # --- Prompt cho Gemini ---
            prompt = f"""
        Người dùng hỏi về chi phí chuyến đi: {destination}, {days} ngày, {people} người.

        Dữ liệu từ SQL database:
        {json.dumps(data_context, ensure_ascii=False, indent=2)}

        Yêu cầu bạn phải:
        1. 🚍 Di chuyển: 
        - Nếu có dữ liệu trong "transportation" thì chọn 1 phương án phù hợp.
        - Tính chi phí trung bình = (cost_min + cost_max)/2 × số người.
        - Nếu không có dữ liệu thì fallback: 400k/người/chiều × 2 chiều.
        2. 🏨 Lưu trú:
        - Nếu có "hotels" thì chọn 1 khách sạn, lấy price_range (chọn giá trung bình) × số đêm.
        - Nếu không có dữ liệu thì fallback: 500k/đêm × {days} đêm.
        3. 🍽️ Ăn uống:
        - Fallback mặc định: 300k/người/ngày × {people} × {days}.
        4. 🗺️ Hoạt động / tham quan:
        - Nếu có "activities" có price_range thì tính giá trung bình.
        - Nếu không có dữ liệu thì fallback: 200k/người/ngày × {people} × {days}.
        5. 👉 Cuối cùng: cộng tất cả và hiển thị **Tổng chi phí dự kiến (VND)**.

        ⚠️ Bắt buộc:
        - Phải in số tiền rõ ràng, có dấu phẩy phân cách (vd: 2,400,000 VND).
        - Không được trả lời kiểu "không có dữ liệu".
        - Trả lời bằng tiếng {"Việt" if language == "vi" else "Anh"}.
        """

            response = chatbot.model.generate_content(prompt)
            response_text = response.text.strip()

            return jsonify({
                "success": True,
                "message": response_text,
                "topic": topic,
                "language": language
            })

        elif topic == 'general':
            # Tìm kiếm tổng hợp nếu không xác định được chủ đề cụ thể
            for keyword in keywords:
                search_results.extend(db.search_destinations(keyword, language))
                search_results.extend(db.search_culture(keyword, language))
                search_results.extend(db.search_cuisine(keyword, language))
                search_results.extend(db.search_hotels(keyword, language))
                search_results.extend(db.search_restaurants(keyword, language))
                search_results.extend(db.search_transportation(keyword, language))
                search_results.extend(db.search_activities(keyword, language))
        
        # Loại bỏ kết quả trùng lặp
        unique_results = []
        seen_ids = set()
        for result in search_results:
            # Tạo unique key dựa trên table và id
            if 'dish_name_vi' in result:
                unique_key = f"cuisine_{result.get('id')}"
            elif 'activity_name_vi' in result:
                unique_key = f"activity_{result.get('id')}"
            elif 'hotel_name_vi' in result:
                unique_key = f"hotel_{result.get('id')}"
            elif 'restaurant_name_vi' in result:
                unique_key = f"restaurant_{result.get('id')}"
            elif 'transport_type' in result:
                unique_key = f"transportation_{result.get('id')}"
            elif 'name_vi' in result and 'rating' in result:
                unique_key = f"destination_{result.get('id')}"
            else:
                unique_key = f"culture_{result.get('id')}"
            
            if unique_key not in seen_ids:
                seen_ids.add(unique_key)
                unique_results.append(result)
        
        # Giới hạn số lượng kết quả
        search_results = unique_results[:5]
        
        # Tạo phản hồi bằng Gemini
        if search_results:
            response_text = chatbot.generate_response(user_message, search_results, language)
        else:
            response_text = chatbot.generate_recommendations(topic, language)
        
        return jsonify({
            'success': True,
            'message': response_text,
            'topic': topic,
            'results_count': len(search_results),
            'language': language
        })
        
    except Exception as e:
        print(f"Chat API error: {e}")
        return jsonify({
            'success': False,
            'message': 'Đã xảy ra lỗi. Vui lòng thử lại sau.' if 'vi' in str(e).lower() else 'An error occurred. Please try again later.'
        })

@app.route('/api/destinations')
def get_destinations():
    """Lấy danh sách điểm đến"""
    try:
        destinations = db.get_all_destinations()
        return jsonify({
            'success': True,
            'data': destinations
        })
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        })

@app.route('/api/search/<topic>')
def search_by_topic(topic):
    """Tìm kiếm theo chủ đề"""
    try:
        keyword = request.args.get('q', '')
        language = request.args.get('lang', 'vi')
        
        if not keyword:
            return jsonify({
                'success': False,
                'message': 'Keyword is required'
            })
        
        results = []
        if topic == 'destinations':
            results = db.search_destinations(keyword, language)
        elif topic == 'culture':
            results = db.search_culture(keyword, language)
        elif topic == 'cuisine':
            results = db.search_cuisine(keyword, language)
        elif topic == 'hotels':
            results = db.search_hotels(keyword, language)
        elif topic == 'restaurants':
            results = db.search_restaurants(keyword, language)
        elif topic == 'transportation':
            origin = request.args.get('origin', '')
            destination = request.args.get('destination', '')
            results = db.search_transportation(origin, destination, language)
        elif topic == 'activities':
            results = db.search_activities(keyword, language)
        
        return jsonify({
            'success': True,
            'data': results,
            'topic': topic,
            'keyword': keyword
        })
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        })

@app.route('/api/health')
def health_check():
    """Health check endpoint"""
    try:
        # Test database connection
        test_query = "SELECT 1 as test"
        db.execute_query(test_query)
        
        return jsonify({
            'success': True,
            'message': 'System is healthy',
            'database': 'connected',
            'gemini': 'configured'
        })
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Health check failed: {str(e)}'
        })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
