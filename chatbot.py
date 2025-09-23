import re
import random
import json
from database import TourismDatabase

class TourismChatbot:
    def __init__(self):
        self.db = TourismDatabase()
        self.context = {
            'current_destination': None,
            'language': 'vi',
            'conversation_state': 'greeting'
        }
        
        # Định nghĩa các pattern và từ khóa
        self.patterns = {
            'vi': {
                'trip_cost_request': [
                    r'chi phí (?:cho )?(?:chuyến )?(?:đi du lịch|du lịch|đi) (.*?) (?:cho )?(\d+) người (?:trong|cho) (\d+) ngày',
                    r'giá (?:cho )?(?:chuyến )?(?:đi du lịch|du lịch|đi) (.*?) (?:cho )?(\d+) người (?:trong|cho) (\d+) ngày',
                    r'ước tính chi phí (.*?) (?:cho )?(\d+) người (?:trong|cho) (\d+) ngày'
                ],
                'greeting': [
                    r'(xin chào|chào|hello|hi)',
                    r'(bạn|em) có thể (giúp|hỗ trợ)',
                    r'tôi (muốn|cần) (tư vấn|hỗ trợ|giúp đỡ)'
                ],
                'destination_search': [
                    r'(muốn đi|đi du lịch|du lịch) (.*)',
                    r'(gợi ý|tư vấn) (.*) (du lịch|điểm đến)',
                    r'(địa điểm|điểm đến|nơi) (du lịch|tham quan)',
                    r'có những nơi nào (.*)',
                    r'(.*) có gì (hay|thú vị|nổi tiếng)',
                    r'.*muốn đi (.*)',
                    r'.*du lịch (.*)',
                    r'đi (.*)'
                ],
                'attraction_request': [
                    r'(điểm tham quan|địa điểm tham quan|điểm du lịch) (.*)?',
                    r'(.*) có (điểm|địa điểm) nào (hay|đẹp|nổi tiếng)',
                    r'(tham quan|đi chơi) ở (.*) thì nên đi đâu',
                    r'(.*) có gì để tham quan',
                    r'(điểm tham quan|chơi gì|tham quan gì) ở (.*)',
                    r'(có gì|địa điểm) ở (.*)'
                ],
                'restaurant_request': [
                    r'(món ăn|đặc sản) ở (.*)',
                    r'(nhà hàng|quán ăn|địa điểm ăn uống) (.*)?',
                    r'ăn gì ở (.*)',
                    r'(món ăn|đặc sản|ẩm thực) (.*)?',
                    r'(.*) có (món|đặc sản) gì (ngon|nổi tiếng)',
                    r'địa điểm ăn uống ở (.*)'
                ],
                'hotel_request': [
                    r'(khách sạn|nơi ở|chỗ ở|lưu trú) (.*)?',
                    r'ở đâu khi đi (.*)',
                    r'(.*)? có khách sạn nào (tốt|đẹp|nổi tiếng)',
                    r'nơi ở ở (.*)'
                ],
                'price_request': [
                    r'giá cả (.*)',
                    r'(.*) giá (bao nhiêu|thế nào)',
                    r'chi phí (.*)'
                ],
                'language_switch': [
                    r'(english|tiếng anh|speak english)',
                    r'(tiếng việt|vietnamese|việt nam)'
                ]
            },
            'en': {
                'greeting': [
                    r'(hello|hi|hey)',
                    r'can you (help|assist)',
                    r'i (want|need) (help|assistance)'
                ],
                'destination_search': [
                    r'(want to|going to) (travel|visit) (.*)',
                    r'(suggest|recommend) (.*) (travel|destination)',
                    r'(places|destinations) to (visit|travel)',
                    r'what are some places (.*)',
                    r'what does (.*) have',
                    r'i want to go to (.*)',
                    r'i want to travel to (.*)',
                    r'go to (.*)'
                ],
                'attraction_request': [
                    r'(attractions|tourist sites|places to visit) (.*)?',
                    r'what to (see|visit) in (.*)',
                    r'(.*) attractions',
                    r'sightseeing in (.*)',
                    r'(.*) has (attractions|places to visit|sightseeing)'
                ],
                'restaurant_request': [
                    r'(restaurants|food|dining) (.*)?',
                    r'where to eat in (.*)',
                    r'(food|cuisine|specialties) (.*)?',
                    r'what to eat in (.*)',
                    r'(.*) has (food|cuisine|specialties)'
                ],
                'hotel_request': [
                    r'(hotels|accommodation|where to stay) (.*)?',
                    r'places to stay in (.*)',
                    r'(.*) hotels',
                    r'hotels in (.*)',
                    r'accommodation in (.*)'
                ],
                'price_request': [
                    r'(price|cost|how much) (.*)',
                    r'(.*) (price|cost)',
                    r'budget for (.*)'
                ],
                'trip_cost_request': [
                    r'cost to (travel|visit) (.*)? for (\d+) people in (\d+) days',
                    r'price to (travel|visit) (.*)? for (\d+) people in (\d+) days',
                    r'estimate cost for (.*)? for (\d+) people in (\d+) days'
                ],
                'language_switch': [
                    r'(vietnamese|tiếng việt)',
                    r'(english|tiếng anh)'
                ]
            }
        }
        
        # Responses templates
        self.responses = {
            'vi': {
                'greeting': "Xin chào! Tôi là trợ lý du lịch ảo. Tôi có thể giúp bạn tìm hiểu về các điểm đến du lịch, địa điểm tham quan, nhà hàng và khách sạn. Bạn muốn đi du lịch ở đâu?",
                'destinations_list': "Đây là một số điểm đến du lịch nổi tiếng:",
                'no_destination': "Xin lỗi, tôi không tìm thấy thông tin về điểm đến này.",
                'attractions_intro': "Các điểm tham quan nổi bật tại",
                'restaurants_intro': "Các nhà hàng được đề xuất tại",
                'hotels_intro': "Các khách sạn tại",
                'help': "Bạn có thể hỏi tôi về:\n- Điểm đến du lịch\n- Địa điểm tham quan\n- Nhà hàng và ẩm thực\n- Khách sạn và nơi lưu trú\n- Giá cả và chi phí",
                'language_switched': "Tôi đã chuyển sang tiếng Việt.",
                'error': "Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại."
            },
            'en': {
                'greeting': "Hello! I'm a virtual tourism assistant. I can help you learn about tourist destinations, attractions, restaurants and hotels. Where would you like to travel?",
                'destinations_list': "Here are some popular tourist destinations:",
                'no_destination': "Sorry, I couldn't find information about this destination.",
                'attractions_intro': "Popular attractions in",
                'restaurants_intro': "Recommended restaurants in",
                'hotels_intro': "Hotels in",
                'help': "You can ask me about:\n- Tourist destinations\n- Attractions and sightseeing\n- Restaurants and cuisine\n- Hotels and accommodation\n- Prices and costs",
                'language_switched': "I've switched to English.",
                'error': "Sorry, an error occurred. Please try again."
            }
        }
    
    def detect_language(self, text):
        """Phát hiện ngôn ngữ từ văn bản"""
        vietnamese_chars = re.search(r'[àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ]', text.lower())
        english_keywords = re.search(r'\b(hello|hi|english|help|travel|visit|restaurant|hotel)\b', text.lower())
        
        if vietnamese_chars or 'việt' in text.lower():
            return 'vi'
        elif english_keywords:
            return 'en'
        else:
            return self.context['language']  # Giữ nguyên ngôn ngữ hiện tại
    
    def extract_destination_name(self, text, language):
        """Trích xuất tên điểm đến từ câu"""
        if language == 'vi':
            stop_words = [
                'tôi', 'muốn', 'đi', 'du', 'lịch', 'tham', 'quan',
                'ở', 'tại', 'về', 'gì', 'có', 'nào',
                'nổi', 'tiếng', 'hay', 'đẹp',
                'món', 'ăn', 'thực',
                'nhà', 'hàng', 'quán',
                'khách', 'sạn',
                'điểm'
            ]
        else:
            stop_words = [
                'i', 'want', 'to', 'go', 'travel', 'visit', 'in', 'at',
                'about', 'what', 'where', 'some', 'famous', 'popular', 'beautiful',
                'restaurant', 'restaurants', 'hotel', 'hotels', 'attraction', 'attractions'
            ]

        words = text.lower().split()
        filtered_words = [w for w in words if w not in stop_words and len(w) > 1]

        if filtered_words:
            return ' '.join(filtered_words).strip().title()
        return None
    
    def match_pattern(self, text, language):
        """Khớp pattern với văn bản đầu vào"""
        text_lower = text.lower()
        
        for intent, patterns in self.patterns[language].items():
            for pattern in patterns:
                if re.search(pattern, text_lower):
                    return intent
        
        return 'unknown'
    
    def format_destination_info(self, destinations, language):
        """Định dạng thông tin điểm đến"""
        if not destinations:
            return self.responses[language]['no_destination']
        
        response = self.responses[language]['destinations_list'] + "\n\n"
        for dest in destinations:
            response += f"🏖️ **{dest['name']}** ({dest['region']})\n"
            response += f"   {dest['description']}\n\n"
        
        response += f"Bạn muốn tìm hiểu chi tiết về điểm đến nào?" if language == 'vi' else "Which destination would you like to know more about?"
        return response

    def format_attractions(self, attractions, destination_name, language="vi"):
        """Định dạng thông tin điểm tham quan"""
        if not attractions:
            return "Xin lỗi, tôi chưa có thông tin về điểm tham quan ở đây 😔." if language == "vi" else "Sorry, I don't have attraction information for this place yet."

        if language == "vi":
            intro_templates = [
                f"🏞️ Nếu bạn đến {destination_name}, đừng bỏ lỡ những điểm tham quan nổi bật sau:",
                f"Ở {destination_name}, có rất nhiều điểm tham quan thú vị, bạn có thể tham khảo những gợi ý dưới đây:",
                f"Bạn đang tìm các địa điểm tham quan ở {destination_name}? Dưới đây là những nơi bạn không thể bỏ qua:"
            ]
        else:
            intro_templates = [
                f"🏞️ If you're visiting {destination_name}, don’t miss these popular attractions:",
                f"There are many great attractions in {destination_name}, here are some top picks:",
                f"Looking for things to do in {destination_name}? Here are some must-see spots:"
            ]

        response = random.choice(intro_templates) + "\n\n"

        for a in attractions:
            if language == "vi":
                response += f"• **{a['name']}**\n"
                response += f"   📍 Địa chỉ: {a['address']}\n"
                response += f"   ℹ️ {a['description']}\n"
                response += f"   🎫 Giá vé: {a['ticket_price']}\n"
                response += f"   ⏰ Giờ mở cửa: {a['opening_hours']}\n\n"
            else:
                response += f"• **{a['name']}**\n"
                response += f"   📍 Address: {a['address']}\n"
                response += f"   ℹ️ {a['description']}\n"
                response += f"   🎫 Ticket: {a['ticket_price']}\n"
                response += f"   ⏰ Hours: {a['opening_hours']}\n\n"

        return response.strip()

    def format_restaurants(self, restaurants, destination_name, language="vi"):
        """Định dạng thông tin nhà hàng"""
        if not restaurants:
            return "Xin lỗi, tôi chưa có thông tin về nhà hàng ở đây 😔." if language == "vi" else "Sorry, I don't have restaurant information for this place yet."

        if language == "vi":
            intro_templates = [
                f"🍽️ Nếu bạn ghé {destination_name}, đừng quên thử những nhà hàng nổi bật sau:",
                f"Ở {destination_name} có rất nhiều món ngon, bạn có thể tham khảo những nhà hàng này:",
                f"Bạn đang tìm chỗ ăn ở {destination_name}? Đây là vài gợi ý cho bạn:"
            ]
        else:
            intro_templates = [
                f"🍽️ If you visit {destination_name}, don’t miss these popular restaurants:",
                f"There are many great dishes in {destination_name}, here are some restaurant suggestions:",
                f"Looking for a place to eat in {destination_name}? Check out these spots:"
            ]

        response = random.choice(intro_templates) + "\n\n"

        for r in restaurants:
            if language == "vi":
                response += f"• **{r['name']}** ({r['cuisine_type']}, {r['price_range']})\n"
                response += f"   📍 Địa chỉ: {r['address']}\n"
                response += f"   👉 Đặc sản: {r['specialties']}\n\n"
            else:
                response += f"• **{r['name']}** ({r['cuisine_type']}, {r['price_range']})\n"
                response += f"   📍 Address: {r['address']}\n"
                response += f"   👉 Specialties: {r['specialties']}\n\n"

        return response.strip()

    def format_hotels(self, hotels, destination_name, language="vi"):
        """Định dạng thông tin khách sạn"""
        if not hotels:
            return "Xin lỗi, tôi chưa có thông tin về khách sạn ở đây 😔." if language == "vi" else "Sorry, I don't have hotel information for this place yet."

        if language == "vi":
            intro_templates = [
                f"🏨 Nếu bạn đang tìm khách sạn tại {destination_name}, đây là những nơi bạn không nên bỏ qua:",
                f"Ở {destination_name} có rất nhiều khách sạn tuyệt vời, đây là một số gợi ý cho bạn:",
                f"Bạn đang muốn nghỉ ngơi tại {destination_name}? Dưới đây là một số khách sạn nổi bật:"
            ]
        else:
            intro_templates = [
                f"🏨 If you're looking for a hotel in {destination_name}, here are some top picks:",
                f"There are many great hotels in {destination_name}, check out these suggestions:",
                f"Looking for a place to stay in {destination_name}? Here are some popular hotels:"
            ]

        # Mở đầu câu trả lời
        response = random.choice(intro_templates) + "\n\n"

        for h in hotels:
            if language == "vi":
                response += f"• **{h['name']}** ({h['star_rating']} sao)\n"
                response += f"   📍 Địa chỉ: {h['address']}\n"
                response += f"   💰 Giá: {h['price_range']}\n"
                response += f"   🏨 Tiện ích: {h['amenities']}\n\n"
            else:
                response += f"• **{h['name']}** ({h['star_rating']} stars)\n"
                response += f"   📍 Address: {h['address']}\n"
                response += f"   💰 Price: {h['price_range']}\n"
                response += f"   🏨 Amenities: {h['amenities']}\n\n"

        return response.strip()
    
    def process_message(self, message):
        """Xử lý tin nhắn từ người dùng"""
        try:
            # Phát hiện ngôn ngữ
            detected_lang = self.detect_language(message)
            self.context['language'] = detected_lang
            
            # Khớp pattern intent
            intent = self.match_pattern(message, detected_lang)
            
            # ==== Greeting ====
            if intent == 'greeting':
                return self.responses[detected_lang]['greeting']
            
            # Nếu không match intent nào → thử check xem có phải tên điểm đến không
            if not intent:
                possible_name = self.extract_destination_name(message, detected_lang)
                if possible_name:
                    dest_id = self.db.search_by_name(possible_name, detected_lang)
                    if dest_id:
                        # Nếu câu có từ “đặc sản / ăn / món ăn” → restaurant
                        if any(word in message.lower() for word in ['ăn', 'món', 'đặc sản', 'ẩm thực']):
                            intent = 'restaurant_request'
                        # Nếu câu có “khách sạn / resort / ở lại” → hotel
                        elif any(word in message.lower() for word in ['khách sạn', 'resort', 'ngủ', 'ở lại']):
                            intent = 'hotel_request'
                        # Nếu câu có “tham quan / điểm đến / chơi” → attraction
                        elif any(word in message.lower() for word in ['tham quan', 'điểm', 'chơi']):
                            intent = 'attraction_request'
                        # Nếu không có keyword cụ thể → coi là destination search
                        else:
                            intent = 'destination_search'

            # ==== Switch Language ====
            elif intent == 'language_switch':
                if 'english' in message.lower() or 'tiếng anh' in message.lower():
                    self.context['language'] = 'en'
                    return self.responses['en']['language_switched']
                else:
                    self.context['language'] = 'vi'
                    return self.responses['vi']['language_switched']
            
            # ==== Destination Search ====
            elif intent == 'destination_search':
                destination_name = self.extract_destination_name(message, detected_lang)
                if destination_name:
                    dest_id = self.db.search_by_name(destination_name, detected_lang)
                    if dest_id:
                        # Lưu context
                        self.context['current_destination'] = dest_id
                        destination_info = self.db.get_destination_details(dest_id, detected_lang)
                        if destination_info:
                            dest = destination_info['destination']
                            response = f"🎯 Bạn muốn đi **{dest['name']}** - {dest['region']}.\n"
                            response += f"ℹ️ {dest['description']}\n\n"
                            response += "Bạn muốn biết thêm về:\n" if detected_lang == 'vi' else "What would you like to know more about?\n"
                            response += "🏖️ Điểm tham quan\n" if detected_lang == 'vi' else "🏖️ Attractions\n"
                            response += "🍽️ Nhà hàng\n" if detected_lang == 'vi' else "🍽️ Restaurants\n"
                            response += "🏨 Khách sạn" if detected_lang == 'vi' else "🏨 Hotels"
                            return response
                    else:
                        return "Hiện tôi chưa được cập nhật địa điểm này." if detected_lang == 'vi' else "This destination has not been updated yet."
                
                # Không nhập tên cụ thể → liệt kê tất cả
                destinations = self.db.get_all_destinations(detected_lang)
                return self.format_destination_info(destinations, detected_lang)
            
            # ==== Attractions ====
            elif intent == 'attraction_request':
                destination_name = self.extract_destination_name(message, detected_lang)
                dest_id = None
                
                if destination_name:
                    dest_id = self.db.search_by_name(destination_name, detected_lang)
                if not dest_id and self.context['current_destination']:
                    dest_id = self.context['current_destination']
                    destination_name = self.db.get_destination_by_id(dest_id, detected_lang)['name']
                
                if dest_id:
                    attractions = self.db.get_attractions(dest_id, detected_lang)
                    return self.format_attractions(attractions, destination_name, detected_lang)
                
                return "Hiện tôi chưa được cập nhật địa điểm này." if detected_lang == 'vi' else "This destination has not been updated yet."
            
            # ==== Restaurants ====
            elif intent == 'restaurant_request':
                destination_name = self.extract_destination_name(message, detected_lang)
                dest_id = None
                
                if destination_name:
                    dest_id = self.db.search_by_name(destination_name, detected_lang)
                if not dest_id and self.context['current_destination']:
                    dest_id = self.context['current_destination']
                    destination_name = self.db.get_destination_by_id(dest_id, detected_lang)['name']
                
                if dest_id:
                    restaurants = self.db.get_restaurants(dest_id, detected_lang)
                    return self.format_restaurants(restaurants, destination_name, detected_lang)
                
                return "Hiện tôi chưa được cập nhật địa điểm này." if detected_lang == 'vi' else "This destination has not been updated yet."
            
            # ==== Hotels ====
            elif intent == 'hotel_request':
                destination_name = self.extract_destination_name(message, detected_lang)
                dest_id = None
                
                if destination_name:
                    dest_id = self.db.search_by_name(destination_name, detected_lang)
                if not dest_id and self.context['current_destination']:
                    dest_id = self.context['current_destination']
                    destination_name = self.db.get_destination_by_id(dest_id, detected_lang)['name']
                
                if dest_id:
                    hotels = self.db.get_hotels(dest_id, detected_lang)
                    return self.format_hotels(hotels, destination_name, detected_lang)
                
                return "Hiện tôi chưa được cập nhật địa điểm này." if detected_lang == 'vi' else "This destination has not been updated yet."
            
            # ==== Trip Cost ====
            elif intent == "trip_cost_request":
                def format_price(min_p, max_p):
                    if min_p == max_p:
                        if min_p == 0:
                            return "Miễn phí"
                        return f"{min_p:,} VNĐ"
                    return f"{min_p:,} - {max_p:,} VNĐ"

                match = re.search(
                    r'(?:chi phí|giá|ước tính chi phí)(?: cho)?(?: chuyến)? (?:đi du lịch|du lịch|đi) (.*?)(?= (?:cho|trong) \d+ người)',
                    message, re.IGNORECASE
                )
                if match:
                    dest_name = match.group(1).strip()
                    dest_name = re.sub(r'\b(cho|trong)\b.*', '', dest_name, flags=re.IGNORECASE).strip()

                    m2 = re.search(r'(\d+) người.*?(\d+) ngày', message)
                    if m2:
                        people, days = int(m2.group(1)), int(m2.group(2))

                        dest_id = self.db.search_by_name(dest_name, detected_lang)
                        if dest_id:
                            costs = self.db.estimate_trip_cost(dest_id, days, people, detected_lang)
                            if costs:
                                response = f"Chi phí dự kiến cho chuyến đi {dest_name} {people} người {days} ngày:\n\n"

                                # 🚗 Phương tiện
                                response += "1. 🚗 Phương tiện:\n"
                                for t in costs["transports"]:
                                    response += f"   - {t['name']}: {format_price(*t['range'])} / người\n"

                                # 🏨 Khách sạn
                                response += "2. 🏨 Khách sạn (giá 1 đêm):\n"
                                for h in costs["hotels"]:
                                    response += f"   - {h['name']}: {format_price(*h['range'])} / đêm\n"
                                response += f"   👉 Chi phí trung bình cho {days} đêm: {format_price(*costs['hotel_cost'])}\n"

                                # 🍽️ Ăn uống
                                response += "3. 🍽️ Ăn uống (giá 1 bữa/người):\n"
                                for r in costs["restaurants"]:
                                    response += f"   - {r['name']}: {format_price(*r['range'])} / bữa\n"
                                response += f"   👉 Tổng chi phí ăn uống ({days} ngày, {people} người, 2 bữa/ngày): {format_price(*costs['food_cost'])}\n"

                                # 🎡 Tham quan
                                response += "4. 🎡 Tham quan:\n"
                                for a in costs["attractions"]:
                                    response += f"   - {a['name']}: {format_price(*a['range'])}\n"
                                response += f"   👉 Tổng chi phí vé tham quan: {format_price(*costs['attraction_cost'])}\n"

                                # 💰 Phát sinh
                                response += f"5. 💰 Chi phí phát sinh: {format_price(*costs['extra'])}\n\n"

                                # Tổng
                                response += f"=> Tổng chi phí ước tính: **{format_price(*costs['total'])}**"

                                return response

                return ("Xin lỗi, tôi chưa tìm thấy thông tin chi phí cho điểm đến này."
                        if detected_lang == 'vi'
                        else "Sorry, I couldn't find cost information for this destination.")


            # ==== Fallback ====
            else:
                return self.responses[detected_lang]['help']
        
        except Exception as e:
            print(f"Lỗi xử lý tin nhắn: {e}")
            return self.responses[self.context['language']]['error']