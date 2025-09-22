-- Tạo database TourismDB
CREATE DATABASE TourismDB;
GO

USE TourismDB;
GO

-- Tạo bảng Destinations (Điểm đến)
CREATE TABLE Destinations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    name_en NVARCHAR(100),
    description NVARCHAR(500),
    description_en NVARCHAR(500),
    region NVARCHAR(100)
);

-- Tạo bảng Attractions (Điểm tham quan)
CREATE TABLE Attractions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    destination_id INT,
    name NVARCHAR(100) NOT NULL,
    name_en NVARCHAR(100),
    address NVARCHAR(200),
    description NVARCHAR(500),
    description_en NVARCHAR(500),
    ticket_price NVARCHAR(100),
    opening_hours NVARCHAR(100),
    FOREIGN KEY (destination_id) REFERENCES Destinations(id)
);

-- Tạo bảng Restaurants (Nhà hàng)
CREATE TABLE Restaurants (
    id INT IDENTITY(1,1) PRIMARY KEY,
    destination_id INT,
    name NVARCHAR(100) NOT NULL,
    name_en NVARCHAR(100),
    address NVARCHAR(200),
    cuisine_type NVARCHAR(50),
    price_range NVARCHAR(50),
    specialties NVARCHAR(300),
    specialties_en NVARCHAR(300),
    FOREIGN KEY (destination_id) REFERENCES Destinations(id)
);

-- Tạo bảng Hotels (Khách sạn)
CREATE TABLE Hotels (
    id INT IDENTITY(1,1) PRIMARY KEY,
    destination_id INT,
    name NVARCHAR(100) NOT NULL,
    name_en NVARCHAR(100),
    address NVARCHAR(200),
    star_rating INT,
    price_range NVARCHAR(100),
    amenities NVARCHAR(300),
    amenities_en NVARCHAR(300),
    FOREIGN KEY (destination_id) REFERENCES Destinations(id)
);

-- Thêm dữ liệu điểm đến
INSERT INTO Destinations (name, name_en, description, description_en, region) VALUES
(N'Hạ Long', 'Ha Long', N'Vịnh Hạ Long nổi tiếng với cảnh quan thiên nhiên tuyệt đẹp, có hơn 1600 hòn đảo lớn nhỏ', 'Ha Long Bay famous for its stunning natural scenery with over 1600 islands', N'Miền Bắc'),
(N'Đà Lạt', 'Da Lat', N'Thành phố ngàn hoa với khí hậu mát mẻ quanh năm, nổi tiếng với đồi chè và thác nước', 'City of flowers with cool climate year-round, famous for tea hills and waterfalls', N'Miền Nam'),
(N'Vũng Tàu', 'Vung Tau', N'Thành phố biển gần TP.HCM với nhiều bãi biển đẹp và điểm tham quan hấp dẫn', 'Coastal city near Ho Chi Minh City with beautiful beaches and attractive sights', N'Miền Nam'),
(N'Phú Quốc', 'Phu Quoc', N'Đảo ngọc với bãi biển trong xanh, rừng nguyên sinh và đặc sản nước mắm', 'Pearl island with crystal clear beaches, pristine forests and famous fish sauce', N'Miền Nam'),
(N'Sapa', 'Sapa', N'Thị trấn miền núi với ruộng bậc thang tuyệt đẹp và văn hóa dân tộc thiểu số', 'Mountain town with stunning terraced fields and ethnic minority culture', N'Miền Bắc');

-- Thêm dữ liệu điểm tham quan
INSERT INTO Attractions (destination_id, name, name_en, address, description, description_en, ticket_price, opening_hours) VALUES
-- Hạ Long
(1, N'Đảo Ti Tốp', 'Ti Top Island', N'Đảo Ti Tốp, Vịnh Hạ Long', N'Đảo nổi tiếng với bãi biển đẹp và đỉnh núi để ngắm toàn cảnh vịnh Hạ Long', 'Famous island with beautiful beach and mountain peak for panoramic bay views', N'Miễn phí', '6:00-18:00'),
(1, N'Hang Sửng Sốt', 'Surprising Cave', N'Đảo Bo Hòn, Vịnh Hạ Long', N'Hang động lớn nhất và đẹp nhất vịnh Hạ Long với nhiều nhũ đá kỳ thú', 'Largest and most beautiful cave in Ha Long Bay with fascinating stalactites', '25,000 VNĐ', '8:00-17:00'),
(1, N'Đảo Cát Bà', 'Cat Ba Island', N'Đảo Cát Bà, Hải Phòng', N'Đảo lớn nhất vịnh Hạ Long với vườn quốc gia và bãi biển đẹp', 'Largest island in Ha Long Bay with national park and beautiful beaches', '40,000 VNĐ', '7:00-17:00'),

-- Đà Lạt
(2, N'Hồ Xuân Hương', 'Xuan Huong Lake', N'Trung tâm thành phố Đà Lạt', N'Hồ nước ngọt ở trung tâm thành phố, nơi lý tưởng để đi bộ và ngắm cảnh', 'Freshwater lake in city center, ideal for walking and sightseeing', N'Miễn phí', '24/7'),
(2, N'Thác Elephant', 'Elephant Falls', N'Cách trung tâm Đà Lạt 30km', N'Thác nước hùng vĩ với chiều cao 30m, được bao quanh bởi rừng thông', 'Majestic waterfall with 30m height, surrounded by pine forests', '20,000 VNĐ', '7:00-17:00'),
(2, N'Đồi Chè Cầu Đất', 'Cau Dat Tea Hill', N'Cầu Đất, Đà Lạt', N'Đồi chè xanh mướt với cảnh quan thơ mộng và không khí trong lành', 'Lush green tea hills with poetic scenery and fresh air', '30,000 VNĐ', '6:00-18:00'),

-- Vũng Tàu
(3, N'Khu du lịch Hồ Mây', 'Ho May Park', N'Núi Lớn, Vũng Tàu', N'Khu du lịch sinh thái với cáp treo và nhiều trò chơi giải trí', 'Eco-tourism area with cable car and various entertainment activities', '150,000 VNĐ', '8:00-17:00'),
(3, N'Tượng Chúa Kitô Vua', 'Christ the King Statue', N'Núi Nhỏ, Vũng Tàu', N'Tượng Chúa cao 32m trên đỉnh núi Nhỏ với tầm nhìn toàn cảnh thành phố', '32m high Christ statue on Small Mountain with city panoramic view', '10,000 VNĐ', '7:00-17:00'),
(3, N'Bãi biển Bãi Sau', 'Back Beach', N'Thùy Vân, Vũng Tàu', N'Bãi biển dài và đẹp với sóng lớn, thích hợp cho lướt sóng', 'Long and beautiful beach with big waves, suitable for surfing', N'Miễn phí', '24/7'),

-- Phú Quốc
(4, N'Cáp treo Hòn Thơm', 'Hon Thom Cable Car', N'An Thới, Phú Quốc', N'Cáp treo dài nhất thế giới vượt biển đến đảo Hòn Thơm', 'World longest sea-crossing cable car to Hon Thom Island', '300,000 VNĐ', '7:30-18:00'),
(4, N'Chợ đêm Dinh Cậu', 'Dinh Cau Night Market', N'Dương Đông, Phú Quốc', N'Chợ đêm nổi tiếng với hải sản tươi sống và đặc sản địa phương', 'Famous night market with fresh seafood and local specialties', N'Miễn phí', '17:00-24:00'),

-- Sapa
(5, N'Ruộng bậc thang Mường Hoa', 'Muong Hoa Terraced Fields', N'Thung lũng Mường Hoa, Sapa', N'Hệ thống ruộng bậc thang đẹp nhất Việt Nam của người H''Mông', 'Most beautiful terraced fields system in Vietnam by H''Mong people', N'Miễn phí', '24/7'),
(5, N'Đỉnh Fansipan', 'Fansipan Peak', N'Sapa, Lào Cai', N'Đỉnh núi cao nhất Việt Nam với độ cao 3,143m', 'Highest mountain peak in Vietnam at 3,143m altitude', '700,000 VNĐ', '7:00-17:00');

-- Thêm dữ liệu nhà hàng
INSERT INTO Restaurants (destination_id, name, name_en, address, cuisine_type, price_range, specialties, specialties_en) VALUES
-- Hạ Long
(1, N'Nhà Hàng Hạ Long Seafood', 'Ha Long Seafood Restaurant', N'Bãi Cháy, Hạ Long', N'Hải sản', '200,000-500,000 VNĐ', N'Cua Hạ Long, tôm hùm nướng, cá thu nướng, chả mực', 'Ha Long crab, grilled lobster, grilled tuna, squid cake'),
(1, N'Quán Cơm Niêu Hạ Long', 'Ha Long Clay Pot Rice', N'Hồng Gai, Hạ Long', N'Việt Nam', '100,000-200,000 VNĐ', N'Cơm niêu, canh chua cá, nem nướng', 'Clay pot rice, sour fish soup, grilled spring rolls'),
(1, N'Nhà hàng Emeralda', 'Emeralda Restaurant', N'Bãi Cháy, Hạ Long', N'Âu-Á', '300,000-800,000 VNĐ', N'Buffet hải sản, steak, pasta', 'Seafood buffet, steak, pasta'),

-- Đà Lạt
(2, N'Bánh ướt Chồng Đà Lạt', 'Da Lat Wet Rice Paper Rolls', N'Nguyễn Thị Minh Khai, Đà Lạt', N'Việt Nam', '50,000-100,000 VNĐ', N'Bánh ướt lòng heo, bánh căn, chè Đà Lạt', 'Wet rice paper rolls with pork, mini pancakes, Da Lat sweet soup'),
(2, N'Nhà hàng Le Rabelais', 'Le Rabelais Restaurant', N'Trần Phú, Đà Lạt', N'Pháp', '400,000-800,000 VNĐ', N'Foie gras, bít tết, rượu vang Đà Lạt', 'Foie gras, steak, Da Lat wine'),
(2, N'Quán Nem Nướng Ninh Hòa', 'Ninh Hoa Grilled Spring Rolls', N'Bùi Thị Xuân, Đà Lạt', N'Việt Nam', '80,000-150,000 VNĐ', N'Nem nướng, bánh hỏi, nước chấm đặc biệt', 'Grilled spring rolls, vermicelli, special dipping sauce'),

-- Vũng Tàu
(3, N'Aloha Hotel Restaurant', 'Aloha Hotel Restaurant', N'Thùy Vân, Vũng Tàu', N'Hải sản', '150,000-400,000 VNĐ', N'Bánh khọt Vũng Tàu, lẩu cá song, tôm rang me', 'Vung Tau mini pancakes, grouper hotpot, tamarind prawns'),
(3, N'Nhà hàng Ganh Hao', 'Ganh Hao Restaurant', N'Hạ Long, Vũng Tàu', N'Hải sản', '200,000-600,000 VNĐ', N'Cua rang me, ốc hương nướng mỡ hành, cháo hến', 'Tamarind crab, grilled sea snails with scallion oil, clam porridge'),
(3, N'Quán Bánh Mì Má Ti', 'Ma Ti Sandwich', N'Lê Lợi, Vũng Tàu', N'Việt Nam', '15,000-50,000 VNĐ', N'Bánh mì thịt nướng, bánh mì pate, cà phê', 'Grilled meat sandwich, pate sandwich, coffee'),

-- Phú Quốc
(4, N'Nhà hàng Crab House', 'Crab House Restaurant', N'Ông Lang, Phú Quốc', N'Hải sản', '300,000-800,000 VNĐ', N'Cua Phú Quốc, ghẹ rang me, cá mú nướng', 'Phu Quoc crab, tamarind blue crab, grilled grouper'),
(4, N'Pepper Farm Restaurant', 'Pepper Farm Restaurant', N'Khu Tượng, Phú Quốc', N'Âu-Á', '250,000-600,000 VNĐ', N'Tôm hùm tiêu đen, cà ri dê, salad hải sản', 'Black pepper lobster, goat curry, seafood salad'),

-- Sapa
(5, N'Nhà hàng Hill Station', 'Hill Station Restaurant', N'Cầu Mây, Sapa', N'Âu-Á', '200,000-500,000 VNĐ', N'Thịt trâu nướng, cá tầm nướng, rau rừng', 'Grilled buffalo meat, grilled sturgeon, wild vegetables'),
(5, N'Quán Thắng Cố', 'Thang Co Restaurant', N'Fansipan, Sapa', N'Dân tộc', '100,000-250,000 VNĐ', N'Thắng cố, thịt lợn cắp nách, rượu cần', 'Thang co soup, armpit pork, ruou can wine');

-- Thêm dữ liệu khách sạn
INSERT INTO Hotels (destination_id, name, name_en, address, star_rating, price_range, amenities, amenities_en) VALUES
-- Hạ Long
(1, N'Khách sạn Mường Thanh Grand Hạ Long', 'Muong Thanh Grand Ha Long Hotel', N'Bãi Cháy, Hạ Long', 5, '2,000,000-4,000,000 VNĐ', N'Spa, hồ bơi, phòng gym, nhà hàng, bar', 'Spa, swimming pool, gym, restaurant, bar'),
(1, N'Novotel Ha Long Bay', 'Novotel Ha Long Bay', N'Hạ Long, Quảng Ninh', 4, '1,800,000-3,500,000 VNĐ', N'Hồ bơi vô cực, spa, tennis, kids club', 'Infinity pool, spa, tennis, kids club'),
(1, N'Khách sạn Royal Lotus Hạ Long', 'Royal Lotus Ha Long Hotel', N'Bãi Cháy, Hạ Long', 4, '1,200,000-2,500,000 VNĐ', N'Hồ bơi, massage, karaoke, tour du thuyền', 'Swimming pool, massage, karaoke, cruise tours'),

-- Đà Lạt  
(2, N'Ana Mandara Villas Dalat Resort & Spa', 'Ana Mandara Villas Dalat Resort & Spa', N'Lê Lai, Đà Lạt', 5, '3,500,000-8,000,000 VNĐ', N'Villa riêng biệt, spa cao cấp, sân golf, nhà hàng 5 sao', 'Private villas, luxury spa, golf course, 5-star restaurant'),
(2, N'Dalat Palace Luxury Hotel', 'Dalat Palace Luxury Hotel', N'Trần Phú, Đà Lạt', 5, '3,000,000-6,000,000 VNĐ', N'Sân golf 18 lỗ, spa, hồ bơi, casino', '18-hole golf course, spa, swimming pool, casino'),
(2, N'Khách sạn Sammy Dalat', 'Sammy Dalat Hotel', N'Bùi Thị Xuân, Đà Lạt', 4, '800,000-1,500,000 VNĐ', N'Hồ bơi, nhà hàng, tour tham quan', 'Swimming pool, restaurant, sightseeing tours'),

-- Vũng Tàu
(3, N'Aloha Hotel Vũng Tàu', 'Aloha Hotel Vung Tau', N'Thùy Vân, Vũng Tàu', 4, '1,200,000-2,500,000 VNĐ', N'Hồ bơi, spa, gym, nhà hàng view biển', 'Swimming pool, spa, gym, sea view restaurant'),
(3, N'Pullman Vung Tau', 'Pullman Vung Tau', N'Thi Sách, Vũng Tàu', 5, '2,500,000-5,000,000 VNĐ', N'Hồ bơi vô cực, spa, club trẻ em, 3 nhà hàng', 'Infinity pool, spa, kids club, 3 restaurants'),
(3, N'Khách sạn Petro House', 'Petro House Hotel', N'Lê Lợi, Vũng Tàu', 4, '900,000-1,800,000 VNĐ', N'Hồ bơi, karaoke, massage, gần biển', 'Swimming pool, karaoke, massage, near beach'),

-- Phú Quốc
(4, N'JW Marriott Phu Quoc Emerald Bay Resort & Spa', 'JW Marriott Phu Quoc Emerald Bay', N'Bãi Khem, Phú Quốc', 5, '8,000,000-20,000,000 VNĐ', N'Spa cao cấp, 6 nhà hàng, hồ bơi vô cực, bãi biển riêng', 'Luxury spa, 6 restaurants, infinity pools, private beach'),
(4, N'Salinda Resort Phu Quoc Island', 'Salinda Resort Phu Quoc', N'Cửa Lấp, Phú Quốc', 5, '4,000,000-12,000,000 VNĐ', N'Villa biển, spa, 3 hồ bơi, kids club', 'Beachfront villas, spa, 3 swimming pools, kids club'),

-- Sapa
(5, N'Hotel de la Coupole MGallery', 'Hotel de la Coupole MGallery', N'Mường Hoa, Sapa', 5, '3,000,000-7,000,000 VNĐ', N'Spa, hồ bơi trong nhà, nhà hàng Pháp, bar thưởng trà', 'Spa, indoor pool, French restaurant, tea lounge'),
(5, N'Victoria Sapa Resort & Spa', 'Victoria Sapa Resort & Spa', N'Xuân Viên, Sapa', 4, '2,200,000-4,500,000 VNĐ', N'Spa truyền thống, nhà hàng cao cấp, tour trekking', 'Traditional spa, fine dining, trekking tours');

-- Tạo view để truy vấn dễ dàng hơn
CREATE VIEW vw_DestinationInfo AS
SELECT 
    d.id as destination_id,
    d.name as destination_name,
    d.name_en as destination_name_en,
    d.description as destination_desc,
    d.description_en as destination_desc_en,
    d.region,
    COUNT(a.id) as attraction_count,
    COUNT(r.id) as restaurant_count,
    COUNT(h.id) as hotel_count
FROM Destinations d
LEFT JOIN Attractions a ON d.id = a.destination_id
LEFT JOIN Restaurants r ON d.id = r.destination_id  
LEFT JOIN Hotels h ON d.id = h.destination_id
GROUP BY d.id, d.name, d.name_en, d.description, d.description_en, d.region;

-- Tạo stored procedure để tìm kiếm điểm đến
CREATE PROCEDURE sp_SearchDestination
    @keyword NVARCHAR(100),
    @language VARCHAR(10) = 'vi'
AS
BEGIN
    IF @language = 'en'
        SELECT id, name_en as name, description_en as description, region
        FROM Destinations 
        WHERE name_en LIKE '%' + @keyword + '%' OR description_en LIKE '%' + @keyword + '%'
    ELSE
        SELECT id, name, description, region
        FROM Destinations 
        WHERE name LIKE N'%' + @keyword + N'%' OR description LIKE N'%' + @keyword + N'%'
END;

-- Tạo stored procedure để lấy thông tin chi tiết điểm đến
CREATE PROCEDURE sp_GetDestinationDetails
    @destination_id INT,
    @language VARCHAR(10) = 'vi'
AS
BEGIN
    -- Thông tin điểm đến
    IF @language = 'en'
        SELECT name_en as name, description_en as description, region FROM Destinations WHERE id = @destination_id
    ELSE
        SELECT name, description, region FROM Destinations WHERE id = @destination_id
        
    -- Điểm tham quan
    IF @language = 'en'
        SELECT name_en as name, address, description_en as description, ticket_price, opening_hours 
        FROM Attractions WHERE destination_id = @destination_id
    ELSE
        SELECT name, address, description, ticket_price, opening_hours 
        FROM Attractions WHERE destination_id = @destination_id
        
    -- Nhà hàng
    IF @language = 'en'
        SELECT name_en as name, address, cuisine_type, price_range, specialties_en as specialties 
        FROM Restaurants WHERE destination_id = @destination_id
    ELSE
        SELECT name, address, cuisine_type, price_range, specialties 
        FROM Restaurants WHERE destination_id = @destination_id
        
    -- Khách sạn
    IF @language = 'en'
        SELECT name_en as name, address, star_rating, price_range, amenities_en as amenities 
        FROM Hotels WHERE destination_id = @destination_id
    ELSE
        SELECT name, address, star_rating, price_range, amenities 
        FROM Hotels WHERE destination_id = @destination_id
END;

GO

PRINT 'Database TourismDB đã được tạo thành công với đầy đủ dữ liệu mẫu!';