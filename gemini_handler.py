import google.generativeai as genai
import json
import re
from typing import Dict, List, Any

class GeminiChatbot:
    def __init__(self, api_key: str):
        genai.configure(api_key=api_key)
        self.model = genai.GenerativeModel('gemini-2.5-flash')
        
    def detect_language(self, text: str) -> str:
        """Phát hiện ngôn ngữ của văn bản"""
        vietnamese_chars = re.findall(r'[àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ]', text.lower())
        if len(vietnamese_chars) > 0:
            return 'vi'
        return 'en'
    
    def extract_keywords(self, user_message: str, language: str = 'vi') -> Dict[str, Any]:
        """Trích xuất từ khóa, origin và destination từ tin nhắn người dùng"""
        if language == 'vi':
            prompt = f"""
            Phân tích câu hỏi sau và trích xuất thông tin:
            "{user_message}"

            Hãy xác định:
            1. Chủ đề chính (destinations/culture/cuisine/activities/hotels/restaurants/transportation/general)
            2. Điểm xuất phát (origin) nếu có trong câu hỏi. Nếu không có thì để "TP.Hồ Chí Minh".
            3. Điểm đến (destination) nếu có trong câu hỏi.
            4. Từ khóa tìm kiếm (các địa danh, món ăn, lễ hội, v.v.)
            5. Loại thông tin cần tìm (mô tả/giá cả/thời gian/địa điểm)

            Trả về JSON format:
            {{
                "topic": "destinations|culture|cuisine|activities|hotels|restaurants|transportation|general",
                "origin": "TP.Hồ Chí Minh",
                "destination": "Đà Lạt",
                "keywords": ["keyword1", "keyword2"],
                "info_type": "description|price|time|location|recommendation",
                "language": "vi"
            }}
            """
        else:
            prompt = f"""
            Analyze the following question and extract information:
            "{user_message}"

            Please identify:
            1. Main topic (destinations/culture/cuisine/activities/hotels/restaurants/transportation/general)
            2. Origin (if mentioned). If not, default to "Ho Chi Minh City".
            3. Destination (if mentioned).
            4. Search keywords (places, food, festivals, etc.)
            5. Type of information needed (description/price/time/location)

            Return in JSON format:
            {{
                "topic": "destinations|culture|cuisine|activities|hotels|restaurants|transportation|general",
                "origin": "Ho Chi Minh City",
                "destination": "Da Lat",
                "keywords": ["keyword1", "keyword2"],
                "info_type": "description|price|time|location|recommendation",
                "language": "en"
            }}
            """

        try:
            response = self.model.generate_content(prompt)
            # Parse JSON từ response
            json_match = re.search(r'\{.*\}', response.text, re.DOTALL)
            if json_match:
                return json.loads(json_match.group())
            else:
                # Fallback parsing
                return self.fallback_keyword_extraction(user_message, language)
        except Exception as e:
            print(f"Gemini keyword extraction error: {e}")
            return self.fallback_keyword_extraction(user_message, language)
    
    def fallback_keyword_extraction(self, user_message: str, language: str) -> Dict[str, Any]:
        """Phương pháp fallback để trích xuất từ khóa"""
        message_lower = user_message.lower()
        
        # Các nhóm từ khóa
        destination_keywords = ['du lịch', 'điểm đến', 'thăm', 'đi', 'travel', 'visit', 'destination', 'place']
        culture_keywords = ['văn hóa', 'lễ hội', 'truyền thống', 'culture', 'festival', 'tradition']
        cuisine_keywords = ['ăn', 'món', 'ẩm thực', 'food', 'dish', 'cuisine', 'eat']
        hotel_keywords = ['khách sạn', 'nghỉ dưỡng', 'hotel', 'resort', 'stay', 'accommodation']
        restaurant_keywords = ['nhà hàng', 'quán ăn', 'restaurant', 'dining', 'food place']
        activity_keywords = ['hoạt động', 'làm gì', 'chơi gì', 'trải nghiệm', 'activity', 'activities', 'experience', 'do', 'things to do']
        transportation_keywords = [
            'đi đến', 'di chuyển', 'chi phí đi', 'vé xe', 'vé máy bay',
            'cách đi', 'đường đi', 'bằng phương tiện', 'phương tiện nào',
            'how to go', 'cost to travel', 'transport', 'transportation'
        ]
        price_keywords = ['rẻ nhất', 'giá rẻ nhất', 'cheap', 'lowest price', 'budget']
        
        # Xác định topic
        topic = 'general'
        info_type = 'description'

        if any(keyword in message_lower for keyword in destination_keywords):
            topic = 'destinations'
        elif any(keyword in message_lower for keyword in culture_keywords):
            topic = 'culture'
        elif any(keyword in message_lower for keyword in cuisine_keywords):
            topic = 'cuisine'
        elif any(keyword in message_lower for keyword in hotel_keywords):
            topic = 'hotels'
            if any(pk in message_lower for pk in price_keywords):
                info_type = 'lowest_price'
        elif any(keyword in message_lower for keyword in restaurant_keywords):
            topic = 'restaurants'
        elif any(keyword in message_lower for keyword in activity_keywords):
            topic = 'activities'
        elif any(keyword in message_lower for keyword in transportation_keywords):
            topic = 'transportation'

        # Trích xuất từ khóa đơn giản
        words = message_lower.split()
        keywords = [word for word in words if len(word) > 2 and word not in ['the', 'and', 'or', 'but', 'với', 'của', 'trong', 'nào', 'gì']]

        return {
            "topic": topic,
            "origin": "TP.Hồ Chí Minh" if language == "vi" else "Ho Chi Minh City",
            "destination": keywords[-1] if keywords else "",
            "keywords": keywords[:3],
            "info_type": info_type,
            "language": language
        }


    def generate_response(self, user_message: str, search_results: List[Dict[str, Any]], language: str = 'vi') -> str:
        """Tạo phản hồi dựa trên kết quả tìm kiếm"""
        if not search_results:
            if language == 'vi':
                return "Xin lỗi, tôi không tìm thấy thông tin phù hợp với câu hỏi của bạn. Bạn có thể hỏi về các điểm du lịch, văn hóa, hoặc ẩm thực Việt Nam khác không?"
            else:
                return "Sorry, I couldn't find relevant information for your question. Could you ask about other Vietnamese tourist destinations, culture, or cuisine?"
        
        # Chuẩn bị dữ liệu cho prompt
        data_context = json.dumps(search_results, ensure_ascii=False, indent=2, default=str)
        
        if language == 'vi':
            prompt = f"""
            Dựa trên câu hỏi: "{user_message}"
            Và dữ liệu tìm được: {data_context}
            
            Hãy tạo một câu trả lời tự nhiên, thân thiện và hữu ích bằng tiếng Việt. 
            Yêu cầu format:
            - Dùng emoji phù hợp (🗺️ cho điểm đến, 🍜 cho món ăn, 🎉 cho lễ hội, 🏨 cho khách sạn, 🍽️ cho nhà hàng, 🚌 cho phương tiện 🏞️ cho hoạt động).
            - Trình bày rõ ràng với tiêu đề in đậm, gạch đầu dòng hoặc xuống dòng dễ đọc.
            - Bao gồm:
            • Thông tin chính từ dữ liệu
            • Chi tiết hữu ích (giá cả, thời gian, địa điểm nếu có)
            • Gợi ý hoặc lời khuyên nếu phù hợp
            - Giữ câu trả lời ngắn gọn nhưng đầy đủ thông tin
            
            Chỉ sử dụng thông tin trong dữ liệu đã cung cấp.
            """
        else:
            prompt = f"""
            Based on the question: "{user_message}"
            And the found data: {data_context}
            
            Please create a natural, friendly and helpful response in English.
            Formatting requirements:
            - Use suitable emojis (🗺️ for destinations, 🍜 for food, 🎉 for festivals, 🏨 for hotels, 🍽️ for restaurants, 🚌 for transportation 🏞️ for activities).
            - Structure clearly with bold headings, bullet points or line breaks.
            - Include:
            • Main information from the data
            • Useful details (price, time, location if available)
            • Suggestions or advice if appropriate
            - Keep the response concise but informative
            
            Only use information from the provided data.
            """
            
        try:
            response = self.model.generate_content(prompt)
            return response.text.strip()
        except Exception as e:
            print(f"Gemini response generation error: {e}")
            if language == 'vi':
                return "Xin lỗi, tôi gặp sự cố khi tạo phản hồi. Vui lòng thử lại sau."
            else:
                return "Sorry, I encountered an issue generating a response. Please try again later."
    
    def generate_recommendations(self, topic: str, language: str = 'vi') -> str:
        """Tạo gợi ý chung"""
        if language == 'vi':
            suggestions = {
                'destinations': "Bạn có thể hỏi về: Vịnh Hạ Long, Phố cổ Hội An, Sapa, hoặc các điểm du lịch khác.",
                'culture': "Bạn có thể tìm hiểu về: Tết Nguyên Đán, múa rối nước, hoặc các lễ hội truyền thống.",
                'cuisine': "Hãy khám phá: Phở, bánh mì, chả cá Lã Vọng, hoặc các món ăn đặc sản khác.",
                'hotels': "Bạn có thể hỏi về: các khách sạn nổi tiếng, khu nghỉ dưỡng, hoặc chỗ ở phù hợp với ngân sách của bạn.",
                'restaurants': "Bạn có thể hỏi về: các nhà hàng nổi tiếng, quán ăn địa phương, hoặc nơi thưởng thức ẩm thực đặc sắc.",
                'transportation': "Bạn có thể hỏi: Chi phí đi từ TP.HCM đến Đà Lạt, Phú Quốc, Nha Trang…",
                'activities': "Bạn có thể hỏi về: du thuyền ngắm cảnh, trekking, chèo kayak, hoặc các hoạt động khác."
            }
        else:
            suggestions = {
                'destinations': "You can ask about: Ha Long Bay, Hoi An Ancient Town, Sapa, or other tourist destinations.",
                'culture': "You can learn about: Lunar New Year, water puppetry, or traditional festivals.",
                'cuisine': "Explore: Pho, Vietnamese sandwich, Cha Ca La Vong, or other specialty dishes.",
                'hotels': "You can ask about: popular hotels, resorts, or accommodations that fit your budget.",
                'restaurants': "You can ask about: famous restaurants, local eateries, or places to enjoy unique cuisine.",
                'transportation': "You can ask: Cost to travel from Ho Chi Minh City to Da Lat, Phu Quoc, Nha Trang…",
                'activities': "You can ask about: scenic cruises, trekking, kayaking, or other activities."
            }
        
        return suggestions.get(topic, suggestions['destinations'])
