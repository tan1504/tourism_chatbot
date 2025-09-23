import pyodbc
import json
import random
import re

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

    def estimate_trip_cost(self, destination_id, days=2, people=2, language="vi"):
        conn = self.get_connection()
        if not conn:
            return {}

        try:
            cursor = conn.cursor()

            # 🚗 Phương tiện: liệt kê tất cả
            cursor.execute("SELECT name, price_range FROM Transportation WHERE destination_id = ?", (destination_id,))
            transports = []
            for name, price_range in cursor.fetchall():
                min_p, max_p = _parse_price_range(price_range)
                transports.append({"name": name, "range": (min_p, max_p)})

            # 🏨 Khách sạn: lấy 2 cái
            cursor.execute("SELECT name, price_range FROM Hotels WHERE destination_id = ?", (destination_id,))
            hotel_rows = cursor.fetchall()
            hotels = []
            if hotel_rows:
                chosen = random.sample(hotel_rows, min(2, len(hotel_rows)))
                for name, price_range in chosen:
                    min_p, max_p = _parse_price_range(price_range)
                    hotels.append({"name": name, "range": (min_p, max_p)})
            if hotels:
                avg_min = sum(h["range"][0] for h in hotels) / len(hotels)
                avg_max = sum(h["range"][1] for h in hotels) / len(hotels)
                hotel_cost = (int(round(avg_min * days)), int(round(avg_max * days)))
            else:
                hotel_cost = (0, 0)

            # 🍽️ Ăn uống: chỉ lấy 3 quán
            cursor.execute("SELECT name, price_range FROM Restaurants WHERE destination_id = ?", (destination_id,))
            restaurant_rows = cursor.fetchall()
            restaurants = []
            if restaurant_rows:
                chosen = random.sample(restaurant_rows, min(3, len(restaurant_rows)))
                for name, price_range in chosen:
                    min_p, max_p = _parse_price_range(price_range)
                    restaurants.append({"name": name, "range": (min_p, max_p)})
            if restaurants:
                avg_min = sum(r["range"][0] for r in restaurants) / len(restaurants)
                avg_max = sum(r["range"][1] for r in restaurants) / len(restaurants)
                food_cost = (int(round(avg_min * days * people * 2)),
                            int(round(avg_max * days * people * 2)))
            else:
                food_cost = (0, 0)

            # 🎡 Tham quan: chọn 3–4 điểm
            cursor.execute("SELECT name, ticket_price FROM Attractions WHERE destination_id = ?", (destination_id,))
            attraction_rows = cursor.fetchall()
            attractions = []
            att_min = att_max = 0
            if attraction_rows:
                num = min(len(attraction_rows), max(3, min(4, days*2)))
                chosen = random.sample(attraction_rows, num)
                for name, ticket in chosen:
                    min_p, max_p = _parse_price_range(ticket)
                    attractions.append({"name": name, "range": (min_p, max_p)})
                    att_min += min_p
                    att_max += max_p

            # 💰 Chi phí phát sinh
            extra = (500000, 1000000)

            # Tổng
            tr_min = sum(t["range"][0] for t in transports) * people
            tr_max = sum(t["range"][1] for t in transports) * people
            total_min = tr_min + hotel_cost[0] + food_cost[0] + att_min + extra[0]
            total_max = tr_max + hotel_cost[1] + food_cost[1] + att_max + extra[1]

            return {
                "transports": transports,
                "hotels": hotels,
                "restaurants": restaurants,
                "attractions": attractions,
                "hotel_cost": hotel_cost,
                "food_cost": food_cost,
                "attraction_cost": (att_min, att_max),
                "extra": extra,
                "total": (total_min, total_max)
            }

        except Exception as e:
            print(f"Lỗi tính chi phí: {e}")
            return {}
        finally:
            conn.close()

# Hàm chuyển giá text → số
def parse_price(price_str):
    if not price_str:
        return 0
    price_str = price_str.lower().replace("vnđ", "").replace(",", "").strip()
    if "miễn phí" in price_str:
        return 0

    nums = re.findall(r'\d+', price_str)
    if not nums:
        return 0
    nums = [int(n) for n in nums]

    if len(nums) == 1:
        value = nums[0]
    elif len(nums) >= 2:
        # Lấy trung bình khoảng giá
        value = (nums[0] + nums[1]) / 2
    else:
        value = 0

    # Làm tròn xuống số chẵn gần nhất
    if value % 2 != 0:
        value = value - 1

    return int(value)

# Hàm chuyển khoảng giá text → (min, max)
def _parse_price_range(price_str):
    """Trả về (min_price, max_price) từ chuỗi giá"""
    if not price_str:
        return (0, 0)
    s = price_str.lower().replace("vnđ", "").replace(",", "").strip()
    if "miễn phí" in s:
        return (0, 0)
    nums = re.findall(r'\d+', s)
    if not nums:
        return (0, 0)
    nums = [int(n) for n in nums]
    if len(nums) == 1:
        return (nums[0], nums[0])
    return (nums[0], nums[1])  # giữ nguyên khoảng

def format_price(min_p, max_p):
    if min_p == max_p:
        if min_p == 0:
            return "Miễn phí"
        return f"{min_p:,} VNĐ"
    return f"{min_p:,} - {max_p:,} VNĐ"
