from database import DatabaseManager

db = DatabaseManager(
    server="localhost\\SQLEXPRESS", 
    database="TourismChatbot"
)

print("TRANSPORT:", db.search_transportation("TP.Hồ Chí Minh", "Phú Quốc", "vi"))
print("HOTELS:", db.search_hotels("Phú Quốc", "vi"))
print("RESTAURANTS:", db.search_restaurants("Phú Quốc", "vi"))
print("ACTIVITIES:", db.search_activities("Phú Quốc", "vi"))
