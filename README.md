# 🤖 Tourism Chatbot

A rule-based mini chatbot for tourism assistance, providing users with help in trip planning and travel information, with bilingual support in Vietnamese and English, and integrated with SQL Server for efficient data management and retrieval.

## ✨ Features

- **Bilingual Support**: Vietnamese & English with auto-detection
- **Rule-based NLP**: Pattern matching for natural conversations  
- **Database Integration**: SQL Server with tourism data
- **Web Interface**: Modern responsive chat UI
- **REST API**: JSON-based endpoints

## 🚀 Quick Start

1. **Install dependencies**
```bash
pip install flask flask-cors pyodbc
```

2. **Setup SQL Server**
   - Run `TourismDB.sql` to create database
   - Update connection string in `database.py`

3. **Run application**
```bash
python app.py
```

4. **Open browser**: `http://localhost:5000`

## 💬 Usage Examples

```
User: "I want to visit Ha Long"
Bot: Shows Ha Long Bay info with attractions, restaurants, hotels

User: "Nhà hàng ở Đà Lạt"  
Bot: Lists recommended restaurants in Da Lat with details
```

## 🗂️ Project Structure

```
tourism_chatbot/
├── app.py              # Flask web server
├── chatbot.py          # Rule-based chat logic
├── database.py         # SQL Server integration
├── TourismDB.sql       # Database schema + data
└── templates/
    └── index.html      # Chat interface
```

## 🔌 API Endpoints

- `POST /api/chat` - Send message to chatbot
- `GET /api/destinations` - List all destinations
- `GET /api/destination/{id}` - Get destination details
- `GET /api/search?q=keyword` - Search destinations

## 🛠️ Tech Stack

- **Backend**: Python Flask
- **Database**: SQL Server
- **Frontend**: HTML/CSS/JavaScript
- **NLP**: Rule-based pattern matching

## 📊 Database

5 destinations (Ha Long, Da Lat, Vung Tau, Phu Quoc, Sapa) with 20+ attractions, 15+ restaurants, 10+ hotels.

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Submit pull request