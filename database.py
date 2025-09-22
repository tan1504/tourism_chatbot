import pyodbc
import json

class TourismDatabase:
    def __init__(self):
        # Cấu hình kết nối SQL Server (thay đổi theo môi trường của bạn)
        self.connection_string = """
        DRIVER={ODBC Driver 17 for SQL Server};
        SERVER=localhost;
        DATABASE=TourismDB;
        UID=sa;
        PWD=123;
        Trusted_Connection=yes;
        """
        
    def get_connection(self):
        """Tạo kết nối đến database"""
        try:
            return pyodbc.connect(self.connection_string)
        except Exception as e:
            print(f"Lỗi kết nối database: {e}")
            return None
    
    def search_destinations(self, keyword="", language="vi"):
        """Tìm kiếm điểm đến"""
        conn = self.get_connection()
        if not conn:
            return []
            
        try:
            cursor = conn.cursor()
            cursor.execute("EXEC sp_SearchDestination ?, ?", (keyword, language))
            
            results = []
            for row in cursor.fetchall():
                results.append({
                    'id': row[0],
                    'name': row[1],
                    'description': row[2],
                    'region': row[3]
                })
            return results
            
        except Exception as e:
            print(f"Lỗi tìm kiếm: {e}")
            return []
        finally:
            conn.close()
    
    def get_restaurants(self, destination_id, language="vi"):
        """Lấy danh sách nhà hàng"""
        conn = self.get_connection()
        if not conn:
            return []
            
        try:
            cursor = conn.cursor()
            if language == 'en':
                query = """
                SELECT name_en as name, address, cuisine_type, price_range, 
                       specialties_en as specialties 
                FROM Restaurants WHERE destination_id = ?
                """
            else:
                query = """
                SELECT name, address, cuisine_type, price_range, specialties 
                FROM Restaurants WHERE destination_id = ?
                """
                
            cursor.execute(query, (destination_id,))
            
            results = []
            for row in cursor.fetchall():
                results.append({
                    'name': row[0],
                    'address': row[1],
                    'cuisine_type': row[2],
                    'price_range': row[3],
                    'specialties': row[4]
                })
            return results
            
        except Exception as e:
            print(f"Lỗi lấy nhà hàng: {e}")
            return []
        finally:
            conn.close()
    
    def get_hotels(self, destination_id, language="vi"):
        """Lấy danh sách khách sạn"""
        conn = self.get_connection()
        if not conn:
            return []
            
        try:
            cursor = conn.cursor()
            if language == 'en':
                query = """
                SELECT name_en as name, address, star_rating, price_range, 
                       amenities_en as amenities 
                FROM Hotels WHERE destination_id = ?
                """
            else:
                query = """
                SELECT name, address, star_rating, price_range, amenities 
                FROM Hotels WHERE destination_id = ?
                """
                
            cursor.execute(query, (destination_id,))
            
            results = []
            for row in cursor.fetchall():
                results.append({
                    'name': row[0],
                    'address': row[1],
                    'star_rating': row[2],
                    'price_range': row[3],
                    'amenities': row[4]
                })
            return results
            
        except Exception as e:
            print(f"Lỗi lấy khách sạn: {e}")
            return []
        finally:
            conn.close()
    
    def get_destination_details(self, destination_id, language="vi"):
        """Lấy thông tin chi tiết về điểm đến"""
        destination = self.get_destination_by_id(destination_id, language)
        if not destination:
            return None
            
        return {
            'destination': destination,
            'attractions': self.get_attractions(destination_id, language),
            'restaurants': self.get_restaurants(destination_id, language),
            'hotels': self.get_hotels(destination_id, language)
        }
    
    def search_by_name(self, name, language="vi"):
        """Tìm kiếm điểm đến gần đúng, không phân biệt hoa/thường"""
        conn = self.get_connection()
        if not conn:
            return None

        try:
            cursor = conn.cursor()
            if language == 'en':
                query = "SELECT id FROM Destinations WHERE LOWER(name_en) LIKE LOWER(?)"
            else:
                query = "SELECT id FROM Destinations WHERE LOWER(name) LIKE LOWER(?)"

            cursor.execute(query, (f"%{name}%",))
            row = cursor.fetchone()

            if row:
                return row[0]  # Trả về id của điểm đến
            return None
        except Exception as e:
            print(f"Lỗi tìm kiếm theo tên: {e}")
            return None
        finally:
            conn.close()

    def get_all_destinations(self, language="vi"):
        """Lấy tất cả điểm đến"""
        conn = self.get_connection()
        if not conn:
            return []
            
        try:
            cursor = conn.cursor()
            if language == 'en':
                query = "SELECT id, name_en as name, description_en as description, region FROM Destinations"
            else:
                query = "SELECT id, name, description, region FROM Destinations"
                
            cursor.execute(query)
            
            results = []
            for row in cursor.fetchall():
                results.append({
                    'id': row[0],
                    'name': row[1],
                    'description': row[2],
                    'region': row[3]
                })
            return results
            
        except Exception as e:
            print(f"Lỗi lấy dữ liệu: {e}")
            return []
        finally:
            conn.close()
    
    def get_destination_by_id(self, dest_id, language="vi"):
        """Lấy thông tin điểm đến theo ID"""
        conn = self.get_connection()
        if not conn:
            return None
            
        try:
            cursor = conn.cursor()
            if language == 'en':
                query = "SELECT id, name_en as name, description_en as description, region FROM Destinations WHERE id = ?"
            else:
                query = "SELECT id, name, description, region FROM Destinations WHERE id = ?"
                
            cursor.execute(query, (dest_id,))
            row = cursor.fetchone()
            
            if row:
                return {
                    'id': row[0],
                    'name': row[1],
                    'description': row[2],
                    'region': row[3]
                }
            return None
            
        except Exception as e:
            print(f"Lỗi lấy thông tin điểm đến: {e}")
            return None
        finally:
            conn.close()
    
    def get_attractions(self, destination_id, language="vi"):
        """Lấy danh sách điểm tham quan"""
        conn = self.get_connection()
        if not conn:
            return []
            
        try:
            cursor = conn.cursor()
            if language == 'en':
                query = """
                SELECT name_en as name, address, description_en as description, 
                       ticket_price, opening_hours 
                FROM Attractions WHERE destination_id = ?
                """
            else:
                query = """
                SELECT name, address, description, ticket_price, opening_hours 
                FROM Attractions WHERE destination_id = ?
                """
                
            cursor.execute(query, (destination_id,))
            
            results = []
            for row in cursor.fetchall():
                results.append({
                    'name': row[0],
                    'address': row[1],
                    'description': row[2],
                    'ticket_price': row[3],
                    'opening_hours': row[4]
                })
            return results
            
        except Exception as e:
            print(f"Lỗi lấy điểm tham quan: {e}")
            return []
        finally:
            conn.close()