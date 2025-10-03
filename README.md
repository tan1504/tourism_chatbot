# 🤖 Tourism Chatbot

A rule-based mini chatbot for tourism assistance, providing users with help in trip planning and travel information, with bilingual support in Vietnamese and English, and integrated with SQL Server for efficient data management and retrieval.

## ✨ Features

- 🌐 Hỗ trợ song ngữ Việt - Anh (tự động nhận diện ngôn ngữ)
- 🤖 Tích hợp Google Gemini AI để tạo câu trả lời tự nhiên
- 🗄️ Kết nối SQL Server để lưu trữ và truy xuất dữ liệu
- 🔍 Tìm kiếm thông minh theo chủ đề
- 💬 Giao diện web đơn giản, thân thiện

## 🛠️ Công nghệ sử dụng

- **Backend**: Python, Flask
- **AI**: Google Gemini API
- **Database**: SQL Server
- **Frontend**: HTML, CSS, JavaScript
- **Libraries**: pyodbc, google-generativeai, python-dotenv

## 📋 Yêu cầu hệ thống

- Python 3.8+
- SQL Server (Express hoặc phiên bản cao hơn)
- ODBC Driver 17 for SQL Server
- Google Gemini API Key (miễn phí)

## 🚀 Cài đặt

### 1. Clone repository

```bash
git clone <repository-url>
cd tourism-chatbot
```

### 2. Tạo virtual environment

```bash
python -m venv venv

# Windows
venv\Scripts\activate

# Mac/Linux
source venv/bin/activate
```

### 3. Cài đặt dependencies

```bash
pip install -r requirements.txt
```

### 4. Thiết lập SQL Server

- Cài đặt SQL Server
- Mở SQL Server Management Studio (SSMS)
- Chạy script `database_setup.sql` để tạo database và tables
- Script sẽ tự động tạo dữ liệu mẫu

### 5. Cấu hình môi trường

Tạo file `.env` trong thư mục gốc:

```env
# Database Configuration
DB_SERVER=localhost
DB_NAME=TourismChatbot
DB_USERNAME=
DB_PASSWORD=
DB_TRUSTED_CONNECTION=true

# Gemini API Configuration
GEMINI_API_KEY=your_gemini_api_key_here
```

**Lấy Gemini API Key:**
1. Truy cập: https://makersuite.google.com/app/apikey
2. Đăng nhập Google
3. Tạo API key mới
4. Copy và paste vào file `.env`

### 6. Chạy ứng dụng

```bash
python app.py
```

Truy cập: `http://localhost:5000`

## 📁 Cấu trúc dự án

```
tourism_chatbot/
├── app.py              # Flask web server
├── chatbot.py          # Rule-based chat logic
├── database.py         # SQL Server integration
├── TourismDB.sql       # Database schema + data
├── templates/
│   └── index.html      # Chat interface
└── static/
    ├── css/
    │   └── style.css   # Styles for the web interface
    └── js/
        └── script.js   # JavaScript for chat interactions
```

## 🔧 API Endpoints

| Endpoint | Method | Mô tả |
|----------|--------|-------|
| `/` | GET | Trang chủ |
| `/api/chat` | POST | Chat với bot |
| `/api/destinations` | GET | Lấy danh sách điểm đến |
| `/api/search/<topic>` | GET | Tìm kiếm theo chủ đề |
| `/api/health` | GET | Kiểm tra trạng thái hệ thống |

### Ví dụ request:

```bash
# Chat API
curl -X POST http://localhost:5000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Giới thiệu về Vịnh Hạ Long"}'

# Search API
curl http://localhost:5000/api/search/destinations?q=sapa&lang=vi
```

## 🐛 Troubleshooting

**Lỗi kết nối SQL Server:**
```
- Kiểm tra SQL Server đã chạy chưa
- Xác nhận thông tin trong file .env
- Kiểm tra ODBC Driver đã cài đặt chưa
```

**Lỗi Gemini API:**
```
- Kiểm tra API key trong file .env
- Xác nhận đã kích hoạt Gemini API
- Kiểm tra quota API (free tier có giới hạn)
```

**Lỗi import module:**
```bash
pip install --upgrade -r requirements.txt
```