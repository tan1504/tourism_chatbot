import pyodbc
import json
from typing import List, Dict, Any

class DatabaseManager:
    def __init__(self, server, database, username=None, password=None, trusted_connection=True):
        self.server = server
        self.database = database
        self.username = username
        self.password = password
        self.trusted_connection = trusted_connection
        
    def get_connection(self):
        """Tạo kết nối đến SQL Server"""
        if self.trusted_connection:
            connection_string = f"""
            DRIVER={{ODBC Driver 17 for SQL Server}};
            SERVER={self.server};
            DATABASE={self.database};
            Trusted_Connection=yes;
            """
        else:
            connection_string = f"""
            DRIVER={{ODBC Driver 17 for SQL Server}};
            SERVER={self.server};
            DATABASE={self.database};
            UID={self.username};
            PWD={self.password};
            """
        
        return pyodbc.connect(connection_string)
    
    def execute_query(self, query: str, params: tuple = None) -> List[Dict[str, Any]]:
        """Thực thi query và trả về kết quả"""
        try:
            conn = self.get_connection()
            cursor = conn.cursor()
            
            if params:
                cursor.execute(query, params)
            else:
                cursor.execute(query)
            
            # Lấy tên cột
            columns = [column[0] for column in cursor.description]
            
            # Lấy dữ liệu và chuyển thành dictionary
            rows = cursor.fetchall()
            result = []
            for row in rows:
                result.append(dict(zip(columns, row)))
            
            conn.close()
            return result
            
        except Exception as e:
            print(f"Database error: {e}")
            return []
    
    def search_destinations(self, keyword: str, language: str = 'vi') -> List[Dict[str, Any]]:
        """Tìm kiếm điểm đến"""
        if language == 'vi':
            query = """
            SELECT * FROM Destinations 
            WHERE name_vi LIKE ? OR description_vi LIKE ? OR location LIKE ? OR category LIKE ?
            ORDER BY rating DESC
            """
        else:
            query = """
            SELECT * FROM Destinations 
            WHERE name_en LIKE ? OR description_en LIKE ? OR location LIKE ? OR category LIKE ?
            ORDER BY rating DESC
            """
        
        search_term = f"%{keyword}%"
        return self.execute_query(query, (search_term, search_term, search_term, search_term))
    
    def search_culture(self, keyword: str, language: str = 'vi') -> List[Dict[str, Any]]:
        """Tìm kiếm văn hóa"""
        if language == 'vi':
            query = """
            SELECT * FROM Culture 
            WHERE name_vi LIKE ? OR description_vi LIKE ? OR type LIKE ? OR location LIKE ?
            """
        else:
            query = """
            SELECT * FROM Culture 
            WHERE name_en LIKE ? OR description_en LIKE ? OR type LIKE ? OR location LIKE ?
            """
        
        search_term = f"%{keyword}%"
        return self.execute_query(query, (search_term, search_term, search_term, search_term))
    
    def search_cuisine(self, keyword: str, language: str = 'vi') -> List[Dict[str, Any]]:
        """Tìm kiếm ẩm thực"""
        if language == 'vi':
            query = """
            SELECT * FROM Cuisine 
            WHERE dish_name_vi LIKE ? OR description_vi LIKE ? OR ingredients_vi LIKE ? 
            OR type LIKE ? OR origin_location LIKE ?
            """
        else:
            query = """
            SELECT * FROM Cuisine 
            WHERE dish_name_en LIKE ? OR description_en LIKE ? OR ingredients_en LIKE ? 
            OR type LIKE ? OR origin_location LIKE ?
            """
        
        search_term = f"%{keyword}%"
        return self.execute_query(query, (search_term, search_term, search_term, search_term, search_term))
    
    def search_activities(self, keyword: str, language: str = 'vi') -> List[Dict[str, Any]]:
        """Tìm kiếm hoạt động"""
        if language == 'vi':
            query = """
            SELECT a.*, d.name_vi as destination_name_vi, d.name_en as destination_name_en, d.location
            FROM Activities a
            LEFT JOIN Destinations d ON a.destination_id = d.id
            WHERE a.activity_name_vi LIKE ? OR a.description_vi LIKE ? OR a.type LIKE ? 
            OR a.difficulty_level LIKE ? OR d.name_vi LIKE ? OR d.location LIKE ?
            """
        else:
            query = """
            SELECT a.*, d.name_vi as destination_name_vi, d.name_en as destination_name_en, d.location
            FROM Activities a
            LEFT JOIN Destinations d ON a.destination_id = d.id
            WHERE a.activity_name_en LIKE ? OR a.description_en LIKE ? OR a.type LIKE ? 
            OR a.difficulty_level LIKE ? OR d.name_en LIKE ? OR d.location LIKE ?
            """
        
        search_term = f"%{keyword}%"
        return self.execute_query(query, (search_term, search_term, search_term, search_term, search_term, search_term))
    
    def search_hotels(self, destination, language):
        if language == "vi":
            query = """
                SELECT id, name_vi AS name, location, description_vi AS description, 
                    category, star_rating, price_range, amenities
                FROM Hotels
                WHERE location LIKE N'%' + ? + '%'
            """
        else:
            query = """
                SELECT id, name_en AS name, location, description_en AS description, 
                    category, star_rating, price_range, amenities
                FROM Hotels
                WHERE location LIKE '%' + ? + '%'
            """
        return self.execute_query(query, (destination,))
    
    def search_restaurants(self, destination, language):
        if language == "vi":
            query = """
                SELECT id, name_vi AS name, location, description_vi AS description, 
                    cuisine_type, price_range, rating, opening_hours
                FROM Restaurants
                WHERE location LIKE N'%' + ? + '%'
            """
        else:
            query = """
                SELECT id, name_en AS name, location, description_en AS description, 
                    cuisine_type, price_range, rating, opening_hours
                FROM Restaurants
                WHERE location LIKE '%' + ? + '%'
            """
        return self.execute_query(query, (destination,))

    def search_transportation(self, origin: str, destination_keyword: str, language: str = 'vi') -> List[Dict[str, Any]]:
        """Tìm phương tiện di chuyển từ origin đến destination"""
        if language == 'vi':
            query = """
            SELECT t.*, d.name_vi as destination_name, d.location
            FROM Transportation t
            JOIN Destinations d ON t.destination_id = d.id
            WHERE t.origin LIKE ? AND d.name_vi LIKE ?
            """
        else:
            query = """
            SELECT t.*, d.name_en as destination_name, d.location
            FROM Transportation t
            JOIN Destinations d ON t.destination_id = d.id
            WHERE t.origin LIKE ? AND d.name_en LIKE ?
            """
        
        return self.execute_query(query, (f"%{origin}%", f"%{destination_keyword}%"))

    def get_all_destinations(self) -> List[Dict[str, Any]]:
        """Lấy tất cả điểm đến"""
        query = "SELECT * FROM Destinations ORDER BY rating DESC"
        return self.execute_query(query)
    
    def get_destination_activities(self, destination_id: int) -> List[Dict[str, Any]]:
        """Lấy hoạt động theo điểm đến"""
        query = """
        SELECT a.*, d.name_vi as destination_name_vi, d.name_en as destination_name_en
        FROM Activities a
        JOIN Destinations d ON a.destination_id = d.id
        WHERE a.destination_id = ?
        """
        return self.execute_query(query, (destination_id,))


import datetime

def json_serial(obj):
    """Convert datetime objects to ISO 8601 string"""
    if isinstance(obj, (datetime.datetime, datetime.date)):
        return obj.isoformat()
    raise TypeError(f"Type {type(obj)} not serializable")
