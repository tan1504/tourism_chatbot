from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
from chatbot import TourismChatbot
import json

app = Flask(__name__)
CORS(app)

# Khởi tạo chatbot
chatbot = TourismChatbot()

@app.route('/')
def index():
    """Trang chính của web demo"""
    return render_template('index.html')

@app.route('/api/chat', methods=['POST'])
def chat():
    """API endpoint xử lý tin nhắn chat"""
    try:
        data = request.get_json()
        message = data.get('message', '')
        
        if not message:
            return jsonify({
                'error': 'Message is required'
            }), 400
        
        # Xử lý tin nhắn qua chatbot
        response = chatbot.process_message(message)
        
        return jsonify({
            'response': response,
            'language': chatbot.context['language'],
            'current_destination': chatbot.context.get('current_destination')
        })
    
    except Exception as e:
        return jsonify({
            'error': f'Server error: {str(e)}'
        }), 500

@app.route('/api/destinations', methods=['GET'])
def get_destinations():
    """API lấy danh sách tất cả điểm đến"""
    try:
        language = request.args.get('lang', 'vi')
        destinations = chatbot.db.get_all_destinations(language)
        
        return jsonify({
            'destinations': destinations
        })
    
    except Exception as e:
        return jsonify({
            'error': f'Server error: {str(e)}'
        }), 500

@app.route('/api/destination/<int:dest_id>', methods=['GET'])
def get_destination_details(dest_id):
    """API lấy chi tiết điểm đến"""
    try:
        language = request.args.get('lang', 'vi')
        details = chatbot.db.get_destination_details(dest_id, language)
        
        if not details:
            return jsonify({
                'error': 'Destination not found'
            }), 404
        
        return jsonify(details)
    
    except Exception as e:
        return jsonify({
            'error': f'Server error: {str(e)}'
        }), 500

@app.route('/api/search', methods=['GET'])
def search_destinations():
    """API tìm kiếm điểm đến"""
    try:
        keyword = request.args.get('q', '')
        language = request.args.get('lang', 'vi')
        
        if not keyword:
            destinations = chatbot.db.get_all_destinations(language)
        else:
            destinations = chatbot.db.search_destinations(keyword, language)
        
        return jsonify({
            'destinations': destinations
        })
    
    except Exception as e:
        return jsonify({
            'error': f'Server error: {str(e)}'
        }), 500

@app.route('/api/reset', methods=['POST'])
def reset_context():
    """API reset context của chatbot"""
    try:
        chatbot.context = {
            'current_destination': None,
            'language': 'vi',
            'conversation_state': 'greeting'
        }
        
        return jsonify({
            'message': 'Context reset successfully'
        })
    
    except Exception as e:
        return jsonify({
            'error': f'Server error: {str(e)}'
        }), 500

# Test database connection route
@app.route('/api/test-db', methods=['GET'])
def test_db():
    """Test kết nối database"""
    try:
        conn = chatbot.db.get_connection()
        if conn:
            conn.close()
            return jsonify({
                'status': 'success',
                'message': 'Database connection successful'
            })
        else:
            return jsonify({
                'status': 'error',
                'message': 'Database connection failed'
            }), 500
    
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': f'Database error: {str(e)}'
        }), 500

if __name__ == '__main__':
    print("🚀 Starting Tourism Chatbot Server...")
    print("📊 Testing database connection...")
    
    # Test database connection at startup
    try:
        conn = chatbot.db.get_connection()
        if conn:
            conn.close()
            print("✅ Database connection successful!")
        else:
            print("❌ Database connection failed!")
    except Exception as e:
        print(f"❌ Database error: {e}")
    
    print("🌐 Server running at http://localhost:5000")
    app.run(debug=True, host='0.0.0.0', port=5000)