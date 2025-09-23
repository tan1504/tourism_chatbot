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

-- Tạo bảng Transportation (Phương tiện di chuyển)
CREATE TABLE Transportation (
    id INT IDENTITY(1,1) PRIMARY KEY,
    destination_id INT,
    name NVARCHAR(100) NOT NULL,
    name_en NVARCHAR(100),
    type NVARCHAR(50),  
    price_range NVARCHAR(100),
    FOREIGN KEY (destination_id) REFERENCES Destinations(id) 
);

--========================================DESTINATIONS DATA==============================
INSERT INTO Destinations (name, name_en, description, description_en, region) VALUES
(N'Hạ Long', 'Ha Long', N'Vịnh Hạ Long nổi tiếng với cảnh quan thiên nhiên tuyệt đẹp, có hơn 1600 hòn đảo lớn nhỏ', 'Ha Long Bay famous for its stunning natural scenery with over 1600 islands', N'Miền Bắc'),
(N'Đà Lạt', 'Da Lat', N'Thành phố ngàn hoa với khí hậu mát mẻ quanh năm, nổi tiếng với đồi chè và thác nước', 'City of flowers with cool climate year-round, famous for tea hills and waterfalls', N'Miền Nam'),
(N'Vũng Tàu', 'Vung Tau', N'Thành phố biển gần TP.HCM với nhiều bãi biển đẹp và điểm tham quan hấp dẫn', 'Coastal city near Ho Chi Minh City with beautiful beaches and attractive sights', N'Miền Nam'),
(N'Phú Quốc', 'Phu Quoc', N'Đảo ngọc với bãi biển trong xanh, rừng nguyên sinh và đặc sản nước mắm', 'Pearl island with crystal clear beaches, pristine forests and famous fish sauce', N'Miền Nam'),
(N'Sapa', 'Sapa', N'Thị trấn miền núi với ruộng bậc thang tuyệt đẹp và văn hóa dân tộc thiểu số', 'Mountain town with stunning terraced fields and ethnic minority culture', N'Miền Bắc'),
(N'Hội An', 'Hoi An', N'Thành phố cổ kính với những ngôi nhà mái ngói rêu phong, đèn lồng rực rỡ và nền ẩm thực phong phú', 'Ancient town with moss-covered tiled houses, colorful lanterns, and rich cuisine', N'Miền Trung'), 
(N'Huế', 'Hue', N'Cố đô với quần thể di tích lịch sử, lăng tẩm uy nghi và nền văn hóa đậm chất cung đình', 'Ancient capital with historical monuments, majestic tombs, and distinct royal culture', N'Miền Trung'), 
(N'Nha Trang', 'Nha Trang', N'Thành phố biển sôi động với bãi cát trắng, nước biển trong xanh và các hoạt động thể thao dưới nước', 'Vibrant coastal city with white sand beaches, clear blue water, and water sports activities', N'Miền Trung'), 
(N'Mộc Châu', 'Moc Chau', N'Cao nguyên với những đồi chè xanh mướt, hoa mận, hoa đào nở trắng trời và khí hậu trong lành', 'Plateau with lush green tea hills, blooming plum and peach blossoms, and fresh climate', N'Miền Bắc'), 
(N'Đà Nẵng', 'Da Nang', N'Thành phố trẻ năng động với những cây cầu độc đáo, bãi biển Mỹ Khê và khu nghỉ dưỡng đẳng cấp', 'Dynamic young city with unique bridges, My Khe beach, and world-class resorts', N'Miền Trung'), 
(N'Cần Thơ', 'Can Tho', N'Thủ phủ miền Tây với chợ nổi Cái Răng, những vườn cây ăn trái và nét văn hóa sông nước đặc trưng', 'Capital of the Mekong Delta with Cai Rang floating market, fruit orchards, and unique riverine culture', N'Miền Nam'), 
(N'An Giang', 'An Giang', N'Vùng đất với núi non hùng vĩ, cánh đồng lúa bạt ngàn và những di tích lịch sử tâm linh', 'Land with majestic mountains, vast rice fields, and spiritual historical sites', N'Miền Nam'), 
(N'Hà Giang', 'Ha Giang', N'Miền đất cực Bắc của Tổ quốc với cảnh quan núi đá hùng vĩ, đường đèo hiểm trở và văn hóa dân tộc độc đáo', 'Northernmost land of the country with majestic rocky mountain landscapes, treacherous passes, and unique ethnic culture', N'Miền Bắc'), 
(N'Hải Phòng', 'Hai Phong', N'Thành phố cảng với bãi biển Đồ Sơn, ẩm thực phong phú và đảo Cát Bà', 'Port city with Do Son beach, rich cuisine, and Cat Ba island', N'Miền Bắc'), 
(N'Bình Thuận', 'Binh Thuan', N'Nổi tiếng với Mũi Né, những đồi cát bay và bờ biển dài đầy nắng gió', 'Famous for Mui Ne, sand dunes, and a long sunny, windy coastline', N'Miền Nam');

--========================================ATTRACTIONS DATA==============================
INSERT INTO Attractions (destination_id, name, name_en, address, description, description_en, ticket_price, opening_hours) VALUES
-- Hạ Long
(1, N'Đảo Ti Tốp', 'Ti Top Island', N'Đảo Ti Tốp, Vịnh Hạ Long', N'Đảo nổi tiếng với bãi biển đẹp và đỉnh núi để ngắm toàn cảnh vịnh Hạ Long', 'Famous island with beautiful beach and mountain peak for panoramic bay views', N'Miễn phí', '6:00-18:00'),
(1, N'Hang Sửng Sốt', 'Surprising Cave', N'Đảo Bo Hòn, Vịnh Hạ Long', N'Hang động lớn nhất và đẹp nhất vịnh Hạ Long với nhiều nhũ đá kỳ thú', 'Largest and most beautiful cave in Ha Long Bay with fascinating stalactites', '25,000 VNĐ', '8:00-17:00'),
(1, N'Đảo Cát Bà', 'Cat Ba Island', N'Đảo Cát Bà, Hải Phòng', N'Đảo lớn nhất vịnh Hạ Long với vườn quốc gia và bãi biển đẹp', 'Largest island in Ha Long Bay with national park and beautiful beaches', '40,000 VNĐ', '7:00-17:00'),
(1, N'Vịnh Bái Tử Long', 'Bai Tu Long Bay', N'Vịnh Bái Tử Long, Quảng Ninh', N'Vịnh nổi tiếng với cảnh sắc hoang sơ và nước biển trong xanh, thích hợp cho các hoạt động tham quan và du lịch sinh thái', 'Famous bay with pristine landscapes and clear water, ideal for sightseeing and eco-tourism activities', 'Miễn phí', '8:00-18:00'),
(1, N'Đảo Quan Lạn', 'Quan Lan Island', N'Đảo Quan Lạn, Quảng Ninh', N'Đảo hoang sơ với bãi biển dài, cát trắng, và là điểm đến lý tưởng cho các hoạt động thư giãn và khám phá thiên nhiên', 'Pristine island with long sandy beaches, ideal for relaxation and nature exploration', 'Miễn phí', '6:00-18:00'),

-- Đà Lạt
(2, N'Hồ Xuân Hương', 'Xuan Huong Lake', N'Trung tâm thành phố Đà Lạt', N'Hồ nước ngọt ở trung tâm thành phố, nơi lý tưởng để đi bộ và ngắm cảnh', 'Freshwater lake in city center, ideal for walking and sightseeing', N'Miễn phí', '24/7'),
(2, N'Thác Elephant', 'Elephant Falls', N'Cách trung tâm Đà Lạt 30km', N'Thác nước hùng vĩ với chiều cao 30m, được bao quanh bởi rừng thông', 'Majestic waterfall with 30m height, surrounded by pine forests', '20,000 VNĐ', '7:00-17:00'),
(2, N'Đồi Chè Cầu Đất', 'Cau Dat Tea Hill', N'Cầu Đất, Đà Lạt', N'Đồi chè xanh mướt với cảnh quan thơ mộng và không khí trong lành', 'Lush green tea hills with poetic scenery and fresh air', '30,000 VNĐ', '6:00-18:00'),
(2, N'Vườn Hoa Thành Phố', 'Dalat Flower Garden', N'Trung tâm thành phố Đà Lạt', N'Vườn hoa rộng lớn với hàng ngàn loài hoa rực rỡ, là điểm đến lý tưởng cho những ai yêu thích sắc màu thiên nhiên', 'Large flower garden with thousands of vibrant flowers, a perfect spot for nature lovers', '50,000 VNĐ', '7:00-17:00'),
(2, N'Nhà thờ Domaine de Marie', 'Domaine de Marie Church', N'15 Nguyễn Hữu Cảnh, Đà Lạt', N'Nhà thờ nổi tiếng với kiến trúc Pháp cổ kính và cảnh quan tuyệt đẹp xung quanh', 'Famous church with French architecture and beautiful surroundings', N'Miễn phí', '5:00-17:00'),

-- Vũng Tàu
(3, N'Khu du lịch Hồ Mây', 'Ho May Park', N'Núi Lớn, Vũng Tàu', N'Khu du lịch sinh thái với cáp treo và nhiều trò chơi giải trí', 'Eco-tourism area with cable car and various entertainment activities', '150,000 VNĐ', '8:00-17:00'),
(3, N'Tượng Chúa Kitô Vua', 'Christ the King Statue', N'Núi Nhỏ, Vũng Tàu', N'Tượng Chúa cao 32m trên đỉnh núi Nhỏ với tầm nhìn toàn cảnh thành phố', '32m high Christ statue on Small Mountain with city panoramic view', '10,000 VNĐ', '7:00-17:00'),
(3, N'Bãi biển Bãi Sau', 'Back Beach', N'Thùy Vân, Vũng Tàu', N'Bãi biển dài và đẹp với sóng lớn, thích hợp cho lướt sóng', 'Long and beautiful beach with big waves, suitable for surfing', N'Miễn phí', '24/7'),
(3, N'Khu du lịch Paradise', 'Paradise Resort', N'Đường Thùy Vân, Vũng Tàu', N'Khu nghỉ dưỡng sang trọng với các hoạt động thể thao biển và dịch vụ spa thư giãn', 'Luxury resort with beach sports activities and relaxing spa services', '200,000 VNĐ', '7:00-22:00'),
(3, N'Ngọn hải đăng Vũng Tàu', 'Vung Tau Lighthouse', N'Khu vực Hồ Mây, Vũng Tàu', N'Ngọn hải đăng trên đỉnh núi, mang lại tầm nhìn tuyệt vời ra biển và thành phố Vũng Tàu', 'Lighthouse on the mountain top offering stunning views of the sea and Vung Tau city', N'Miễn phí', '8:00-17:00'),

-- Phú Quốc
(4, N'Cáp treo Hòn Thơm', 'Hon Thom Cable Car', N'An Thới, Phú Quốc', N'Cáp treo dài nhất thế giới vượt biển đến đảo Hòn Thơm', 'World longest sea-crossing cable car to Hon Thom Island', '300,000 VNĐ', '7:30-18:00'),
(4, N'Chợ đêm Dinh Cậu', 'Dinh Cau Night Market', N'Dương Đông, Phú Quốc', N'Chợ đêm nổi tiếng với hải sản tươi sống và đặc sản địa phương', 'Famous night market with fresh seafood and local specialties', N'Miễn phí', '17:00-24:00'),
(4, N'Vinpearl Safari Phú Quốc', 'Vinpearl Safari Phu Quoc', N'Gành Dầu, Phú Quốc', N'Safari lớn nhất Việt Nam, nơi bạn có thể khám phá các loài động vật hoang dã', 'Largest safari in Vietnam, where you can explore wild animals', '600,000 VNĐ', '8:00-17:00'),
(4, N'Bãi Sao', 'Sao Beach', N'An Thới, Phú Quốc', N'Bãi biển với cát trắng mịn và nước biển trong xanh, lý tưởng cho các hoạt động thể thao nước', 'Beach with fine white sand and clear water, ideal for water sports', N'Miễn phí', '24/7'),
(4, N'Hòn Móng Tay', 'Mong Tay Island', N'An Thới, Phú Quốc', N'Đảo hoang sơ, ít người biết đến, với bãi biển đẹp và cảnh sắc tuyệt vời', 'Pristine island, less known, with beautiful beaches and stunning scenery', N'Miễn phí', '6:00-18:00'),

-- Sapa
(5, N'Ruộng bậc thang Mường Hoa', 'Muong Hoa Terraced Fields', N'Thung lũng Mường Hoa, Sapa', N'Hệ thống ruộng bậc thang đẹp nhất Việt Nam của người H''Mông', 'Most beautiful terraced fields system in Vietnam by H''Mong people', N'Miễn phí', '24/7'),
(5, N'Đỉnh Fansipan', 'Fansipan Peak', N'Sapa, Lào Cai', N'Đỉnh núi cao nhất Việt Nam với độ cao 3,143m', 'Highest mountain peak in Vietnam at 3,143m altitude', '700,000 VNĐ', '7:00-17:00'),
(5, N'Thác Bạc', 'Silver Waterfall', N'Thị trấn Sapa, Lào Cai', N'Thác nước hùng vĩ nằm giữa rừng núi Sapa, là điểm đến yêu thích của khách du lịch', 'Majestic waterfall located between the mountains of Sapa, a favorite destination for tourists', '20,000 VNĐ', '7:00-17:00'),
(5, N'Bản Cát Cát', 'Cat Cat Village', N'Thị trấn Sapa, Lào Cai', N'Bản làng của người H''Mông, nổi tiếng với những ngôi nhà truyền thống và cảnh sắc núi rừng', 'H''Mong ethnic village known for traditional houses and stunning mountain scenery', '50,000 VNĐ', '7:00-17:00'),
(5, N'Hồ Sapa', 'Sapa Lake', N'Thị trấn Sapa, Lào Cai', N'Hồ nước đẹp giữa trung tâm thị trấn, là nơi lý tưởng để dạo chơi và thư giãn', 'Beautiful lake in the town center, ideal for walking and relaxation', N'Miễn phí', '24/7'),

-- Hội An
(6, N'Phố cổ Hội An', 'Hoi An Ancient Town', N'Phố cổ Hội An, Quảng Nam', N'Khu phố cổ được UNESCO công nhận là di sản văn hóa thế giới, nổi bật với kiến trúc cổ kính và các ngôi nhà truyền thống', 'UNESCO World Heritage-listed ancient town, famous for its well-preserved architecture and traditional houses', N'Miễn phí', '24/7'),
(6, N'Cầu Nhật Bản', 'Japanese Covered Bridge', N'Phố cổ Hội An, Quảng Nam', N'Cầu Nhật Bản là một biểu tượng của Hội An, mang đậm ảnh hưởng văn hóa Nhật Bản từ thế kỷ 17', 'Japanese Covered Bridge, a symbol of Hoi An, influenced by Japanese culture from the 17th century', N'Miễn phí', '24/7'),
(6, N'Chợ Hội An', 'Hoi An Market', N'Phố cổ Hội An, Quảng Nam', N'Chợ truyền thống với nhiều sản phẩm địa phương, đặc sản và đồ lưu niệm', 'Traditional market with local products, specialties, and souvenirs', N'Miễn phí', '6:00-21:00'),
(6, N'Biển Cửa Đại', 'Cua Dai Beach', N'Biển Cửa Đại, Hội An', N'Bãi biển đẹp với cát trắng và nước biển trong xanh, lý tưởng cho tắm biển và thư giãn', 'Beautiful beach with white sand and clear water, ideal for swimming and relaxation', N'Miễn phí', '6:00-18:00'),
(6, N'Miếu Quan Công', 'Quan Cong Temple', N'Phố cổ Hội An, Quảng Nam', N'Miếu thờ Quan Công, vị tướng nổi tiếng trong lịch sử Trung Hoa, là điểm đến tâm linh nổi bật ở Hội An', 'Temple dedicated to Quan Cong, a famous Chinese general, a spiritual highlight in Hoi An', N'Miễn phí', '7:00-17:00'),

-- Huế
(7, N'Kinh Thành Huế', 'Hue Imperial City', N'Trung tâm thành phố Huế, Thừa Thiên Huế', N'Kinh Thành Huế là nơi ở của các vua triều Nguyễn, được UNESCO công nhận là di sản văn hóa thế giới', 'Hue Imperial City, the residence of the Nguyen kings, recognized as a UNESCO World Heritage site', '150,000 VNĐ', '7:00-17:00'),
(7, N'Thiên Mụ Pagoda', 'Thien Mu Pagoda', N'Phú An, Huế', N'Chùa Thiên Mụ là ngôi chùa nổi tiếng nhất ở Huế với tháp cổ cao và khung cảnh tuyệt đẹp', 'Thien Mu Pagoda, the most famous pagoda in Hue, with its tall ancient tower and stunning surroundings', N'Miễn phí', '6:00-18:00'),
(7, N'Chợ Đông Ba', 'Dong Ba Market', N'29 Trần Hưng Đạo, Huế', N'Chợ Đông Ba là chợ truyền thống lớn nhất Huế, nơi bày bán nhiều đặc sản và quà lưu niệm', 'Dong Ba Market, the largest traditional market in Hue, selling local specialties and souvenirs', N'Miễn phí', '5:00-22:00'),
(7, N'Huấn Công Sơn', 'Hue Royal Tombs', N'Rải rác khắp thành phố Huế', N'Huấn Công Sơn là nơi yên nghỉ của các vua triều Nguyễn, với kiến trúc lăng tẩm tuyệt đẹp', 'Hue Royal Tombs, the resting places of the Nguyen kings, featuring beautiful architectural tombs', '100,000 VNĐ', '7:00-17:00'),
(7, N'Ngũ Hành Sơn', 'Five Elements Mountains', N'Phường Hương Long, Huế', N'Ngũ Hành Sơn là một quần thể núi đá vôi, có các hang động và chùa chiền, được nhiều khách du lịch tham quan', 'Five Elements Mountains, a limestone mountain complex with caves and pagodas, popular among tourists', N'Miễn phí', '6:00-17:00'),

-- Nha Trang
(8, N'Vinpearl Land', 'Vinpearl Land', N'Đảo Hòn Tre, Nha Trang', N'Công viên giải trí và khu nghỉ dưỡng sang trọng với nhiều trò chơi và dịch vụ thư giãn', 'Amusement park and luxury resort with various games and relaxation services', '600,000 VNĐ', '8:00-18:00'),
(8, N'Chùa Long Sơn', 'Long Son Pagoda', N'22 đường 23 Tháng 10, Nha Trang', N'Chùa Long Sơn nổi tiếng với tượng Phật trắng lớn và không gian yên tĩnh, linh thiêng', 'Long Son Pagoda, famous for its large white Buddha statue and peaceful, sacred atmosphere', N'Miễn phí', '6:00-18:00'),
(8, N'Bãi Dài', 'Bai Dai Beach', N'Cam Ranh, Nha Trang', N'Bãi biển dài và hoang sơ, thích hợp cho các hoạt động tắm biển và thư giãn', 'Long and pristine beach, ideal for swimming and relaxation', N'Miễn phí', '6:00-18:00'),
(8, N'Hòn Mun', 'Mun Island', N'Thành phố Nha Trang', N'Đảo nổi tiếng với làn nước trong xanh và hệ sinh thái biển phong phú, là điểm lặn biển lý tưởng', 'Famous island with clear water and rich marine ecosystem, an ideal spot for diving', '250,000 VNĐ', '8:00-17:00'),
(8, N'Suối Khoáng Nóng', 'Hot Springs', N'Phước Đồng, Nha Trang', N'Khu nghỉ dưỡng với suối khoáng nóng tự nhiên, mang lại cảm giác thư giãn và trị liệu cho du khách', 'Resort with natural hot springs, offering relaxation and therapeutic benefits for visitors', '150,000 VNĐ', '7:00-20:00'),

-- Mộc Châu
(9, N'Bản Áng', 'Ban Ang Village', N'Mộc Châu, Sơn La', N'Bản Áng nổi tiếng với cảnh quan thiên nhiên tuyệt đẹp và những ruộng hoa cải trắng', 'Ban Ang Village, famous for its beautiful natural scenery and white mustard flower fields', N'Miễn phí', '6:00-18:00'),
(9, N'Đồi chè Mộc Châu', 'Moc Chau Tea Hill', N'Mộc Châu, Sơn La', N'Đồi chè xanh mướt, nơi du khách có thể tham quan và chụp ảnh với những đồi chè bạt ngàn', 'Lush green tea hills where visitors can tour and take photos with endless tea fields', N'Miễn phí', '6:00-18:00'),
(9, N'Thác Dải Yếm', 'Dai Yem Waterfall', N'Mộc Châu, Sơn La', N'Thác nước hùng vĩ với dòng nước chảy từ trên cao xuống, tạo thành một cảnh quan tuyệt đẹp', 'Majestic waterfall with water cascading from high above, creating a stunning view', N'Miễn phí', '7:00-17:00'),
(9, N'Hoa cải Mộc Châu', 'Moc Chau Mustard Flower', N'Mộc Châu, Sơn La', N'Mùa hoa cải nở rộ vào dịp cuối năm, tạo thành một khung cảnh đẹp như tranh vẽ', 'Mustard flowers bloom at the end of the year, creating a picturesque landscape', N'Miễn phí', '6:00-18:00'),
(9, N'Khu du lịch Mộc Châu', 'Moc Chau Resort', N'Mộc Châu, Sơn La', N'Khu du lịch nổi tiếng với cảnh sắc thiên nhiên tuyệt đẹp, phù hợp cho các chuyến tham quan nghỉ dưỡng', 'Famous resort area with stunning natural landscapes, perfect for sightseeing and relaxation', '100,000 VNĐ', '7:00-17:00'),

-- Đà Nẵng
(10, N'Bà Nà Hills', 'Ba Na Hills', N'Phường Hòa Ninh, Đà Nẵng', N'Khu du lịch nổi tiếng với cáp treo dài nhất thế giới, có cầu Vàng nổi bật', 'Famous resort with the world’s longest cable car, home to the iconic Golden Bridge', '750,000 VNĐ', '7:00-17:00'),
(10, N'Ngũ Hành Sơn', 'Marble Mountains', N'Ngũ Hành Sơn, Đà Nẵng', N'Ngũ Hành Sơn là một quần thể núi đá vôi, nổi tiếng với các hang động và chùa chiền', 'The Marble Mountains are a complex of limestone hills, famous for caves and pagodas', '40,000 VNĐ', '7:00-17:00'),
(10, N'Cầu Rồng', 'Dragon Bridge', N'Bạch Đằng, Đà Nẵng', N'Cầu Rồng là biểu tượng nổi bật của Đà Nẵng, đặc biệt vào buổi tối khi cầu phun lửa và phun nước', 'Dragon Bridge, a prominent symbol of Da Nang, especially in the evenings when it breathes fire and water', N'Miễn phí', '24/7'),
(10, N'Chùa Linh Ứng', 'Linh Ung Pagoda', N'Sơn Trà, Đà Nẵng', N'Chùa Linh Ứng nổi tiếng với bức tượng Phật Bà Quan Âm cao 67m và cảnh đẹp quanh núi Sơn Trà', 'Linh Ung Pagoda, famous for the 67m tall statue of the Goddess of Mercy and the beautiful surroundings of Son Tra Mountain', N'Miễn phí', '6:00-18:00'),
(10, N'Bãi biển Mỹ Khê', 'My Khe Beach', N'Mỹ Khê, Đà Nẵng', N'Bãi biển đẹp với cát trắng mịn và nước biển trong xanh, là một trong những bãi biển đẹp nhất Việt Nam', 'Beautiful beach with fine white sand and clear water, one of the most beautiful beaches in Vietnam', N'Miễn phí', '24/7'),

-- Cần Thơ
(11, N'Chợ nổi Cái Răng', 'Cai Rang Floating Market', N'Chợ nổi Cái Răng, Cần Thơ', N'Chợ nổi lớn nhất miền Tây, nơi các tàu thuyền buôn bán hàng hóa và nông sản', 'The largest floating market in the Mekong Delta, where boats sell goods and agricultural products', N'Miễn phí', '5:00-9:00'),
(11, N'Bến Ninh Kiều', 'Ninh Kieu Wharf', N'Bến Ninh Kiều, Cần Thơ', N'Bến Ninh Kiều là địa điểm nổi bật của Cần Thơ, nơi du khách có thể dạo chơi, thưởng thức ẩm thực và ngắm cảnh', 'Ninh Kieu Wharf is a famous spot in Can Tho, where visitors can walk, enjoy food, and admire the scenery', N'Miễn phí', '24/7'),
(11, N'Vườn trái cây Cái Mơn', 'Cai Mon Fruit Orchard', N'Bến Tre, Cần Thơ', N'Vườn trái cây rộng lớn, nơi du khách có thể thưởng thức trái cây tươi và trải nghiệm cuộc sống nông thôn', 'Large fruit orchard where visitors can enjoy fresh fruits and experience rural life', N'Miễn phí', '7:00-17:00'),
(11, N'Hồ Xáng Thổi', 'Xang Thoi Lake', N'Thới Lai, Cần Thơ', N'Hồ nước thanh bình, thích hợp cho các hoạt động câu cá, tham quan và thư giãn', 'Peaceful lake, perfect for fishing, sightseeing, and relaxation', N'Miễn phí', '6:00-18:00'),
(11, N'Chùa Ông', 'Ong Pagoda', N'Phan Đình Phùng, Cần Thơ', N'Chùa Ông là ngôi chùa mang đậm nét văn hóa người Hoa, nổi tiếng với kiến trúc độc đáo và không gian tôn nghiêm', 'Ong Pagoda, a temple with strong Chinese cultural influences, famous for its unique architecture and serene atmosphere', N'Miễn phí', '7:00-17:00'),

-- An Giang
(12, N'Hồ Tà Pạ', 'Ta Pa Lake', N'Thị trấn Tri Tôn, An Giang', N'Hồ Tà Pạ nổi tiếng với nước xanh ngọc bích, bao quanh bởi núi non hùng vĩ', 'Ta Pa Lake, famous for its emerald green water surrounded by majestic mountains', N'Miễn phí', '6:00-18:00'),
(12, N'Chùa Ba Chúc', 'Ba Chuc Pagoda', N'Xã Ba Chúc, An Giang', N'Chùa Ba Chúc là ngôi chùa linh thiêng, nổi tiếng với di tích lịch sử và cảnh quan yên bình', 'Ba Chuc Pagoda, a sacred temple famous for its historical relics and peaceful surroundings', N'Miễn phí', '7:00-17:00'),
(12, N'Tịnh Biên', 'Tinh Bien', N'Tịnh Biên, An Giang', N'Tịnh Biên là một thị trấn biên giới nổi tiếng với vẻ đẹp hoang sơ và các hoạt động du lịch sinh thái', 'Tinh Bien, a border town known for its pristine beauty and eco-tourism activities', N'Miễn phí', '6:00-18:00'),
(12, N'Chợ Mới', 'Cho Moi Market', N'Chợ Mới, An Giang', N'Chợ Mới là chợ truyền thống với nhiều sản phẩm địa phương và đặc sản miền Tây', 'Cho Moi Market, a traditional market with many local products and Mekong Delta specialties', N'Miễn phí', '5:00-21:00'),
(12, N'Khu du lịch Rừng Tràm Trà Sư', 'Tra Su Forest', N'Trà Sư, An Giang', N'Rừng Tràm Trà Sư là khu rừng ngập nước nổi tiếng với hệ động thực vật phong phú và là điểm đến du lịch sinh thái', 'Tra Su Forest, a famous wetland forest with rich flora and fauna, an ideal eco-tourism destination', '30,000 VNĐ', '7:00-17:00'),

-- Hà Giang
(13, N'Cao nguyên đá Đồng Văn', 'Dong Van Stone Plateau', N'Đồng Văn, Hà Giang', N'Khu vực cao nguyên đá nổi tiếng với cảnh quan thiên nhiên độc đáo và làng dân tộc thiểu số', 'Dong Van Stone Plateau, famous for its unique natural landscapes and ethnic minority villages', N'Miễn phí', '24/7'),
(13, N'Bản Lác', 'Lac Village', N'Phương Độ, Hà Giang', N'Bản Lác là một ngôi làng của người H’mông với phong cảnh núi non hùng vĩ và văn hóa đặc sắc', 'Lac Village, a H’mong ethnic village with stunning mountainous scenery and rich culture', N'Miễn phí', '6:00-18:00'),
(13, N'Hà Giang Loop', 'Ha Giang Loop', N'Hà Giang', N'Hà Giang Loop là một trong những cung đường đẹp nhất Việt Nam, nổi bật với cảnh sắc hùng vĩ và các bản làng dân tộc', 'Ha Giang Loop, one of the most beautiful routes in Vietnam, famous for its breathtaking landscapes and ethnic villages', N'Miễn phí', '24/7'),
(13, N'Mã Pí Lèng', 'Ma Pi Leng Pass', N'Mã Pí Lèng, Hà Giang', N'Mã Pí Lèng là đèo nổi tiếng nhất ở Hà Giang, với cảnh sắc tuyệt đẹp và cảm giác phấn khích khi vượt qua đèo', 'Ma Pi Leng, the most famous pass in Ha Giang, offers stunning views and an exhilarating experience crossing the mountain pass', N'Miễn phí', '24/7'),
(13, N'Chợ phiên Đồng Văn', 'Dong Van Market', N'Đồng Văn, Hà Giang', N'Chợ phiên Đồng Văn là nơi tập trung các sản phẩm đặc sản của các dân tộc thiểu số', 'Dong Van Market, where ethnic minority products are sold, showcasing local specialties', N'Miễn phí', '6:00-14:00'),

-- Hải Phòng
(14, N'Vịnh Lan Hạ', 'Lan Ha Bay', N'Cat Ba, Hải Phòng', N'Vịnh Lan Hạ có cảnh đẹp hoang sơ, là điểm đến lý tưởng cho du lịch sinh thái và tham quan biển', 'Lan Ha Bay with its pristine beauty, an ideal destination for eco-tourism and sea sightseeing', N'Miễn phí', '7:00-17:00'),
(14, N'Đảo Cát Bà', 'Cat Ba Island', N'Cat Ba, Hải Phòng', N'Đảo Cát Bà nổi tiếng với bãi biển đẹp và vườn quốc gia rộng lớn', 'Cat Ba Island, famous for its beautiful beaches and vast national park', '30,000 VNĐ', '6:00-18:00'),
(14, N'Cảng Hải Phòng', 'Hai Phong Port', N'Quốc lộ 10, Hải Phòng', N'Cảng Hải Phòng là một trong những cảng lớn nhất miền Bắc, với cảnh quan bến cảng và các hoạt động thương mại sôi động', 'Hai Phong Port, one of the largest ports in the North, with bustling harbor views and commercial activities', N'Miễn phí', '24/7'),
(14, N'Chùa Dư Hàng', 'Du Hang Pagoda', N'2 Dư Hàng, Hải Phòng', N'Chùa Dư Hàng là ngôi chùa cổ kính và linh thiêng với kiến trúc đặc sắc', 'Du Hang Pagoda, an ancient and sacred pagoda with unique architecture', N'Miễn phí', '6:00-17:00'),
(14, N'Công viên Rồng', 'Dragon Park', N'Phường Minh Khai, Hải Phòng', N'Công viên Rồng là khu vui chơi giải trí lớn với nhiều trò chơi cảm giác mạnh và các khu vực giải trí cho trẻ em', 'Dragon Park, a large amusement park with thrilling rides and entertainment areas for kids', '200,000 VNĐ', '8:00-18:00'),

-- Bình Thuận
(15, N'Phan Thiết', 'Phan Thiet', N'Phan Thiết, Bình Thuận', N'Phan Thiết nổi tiếng với các bãi biển đẹp, du lịch nghỉ dưỡng và các làng chài cổ', 'Phan Thiet is famous for its beautiful beaches, resort tourism, and old fishing villages', N'Miễn phí', '24/7'),
(15, N'Ham Tiến', 'Ham Tien', N'Phan Thiết, Bình Thuận', N'Ham Tiến nổi tiếng với bãi biển Mũi Né, là nơi lý tưởng cho các hoạt động thể thao nước', 'Ham Tien is famous for Mui Ne Beach, ideal for water sports activities', N'Miễn phí', '24/7'),
(15, N'Du lịch Suối Tiên', 'Suoi Tien Tourism Area', N'Phan Thiết, Bình Thuận', N'Khu du lịch Suối Tiên nổi bật với cảnh quan thiên nhiên, thác nước và các dịch vụ nghỉ dưỡng', 'Suoi Tien Tourism Area, known for its natural landscapes, waterfalls, and resort services', '50,000 VNĐ', '7:00-17:00'),
(15, N'Cồn Cát Bay', 'Bay Sand Dunes', N'Mũi Né, Bình Thuận', N'Cồn cát Bay là khu vực cồn cát lớn, nơi du khách có thể tham gia các trò chơi trượt cát', 'Bay Sand Dunes, a large sand dune area where visitors can enjoy sandboarding', N'Miễn phí', '6:00-18:00'),
(15, N'Chùa Linh Sơn', 'Linh Son Pagoda', N'Phan Thiết, Bình Thuận', N'Chùa Linh Sơn với kiến trúc độc đáo và không gian tĩnh lặng, là một trong những điểm đến tâm linh nổi bật ở Bình Thuận', 'Linh Son Pagoda with unique architecture and peaceful space, one of the prominent spiritual destinations in Binh Thuan', N'Miễn phí', '6:00-17:00');

--========================================RESTAURANTS DATA==============================
INSERT INTO Restaurants (destination_id, name, name_en, address, cuisine_type, price_range, specialties, specialties_en) VALUES
-- Hạ Long
(1, N'Nhà Hàng Hạ Long Seafood', 'Ha Long Seafood Restaurant', N'Bãi Cháy, Hạ Long', N'Hải sản', '200,000-500,000 VNĐ', N'Cua Hạ Long, tôm hùm nướng, cá thu nướng, chả mực', 'Ha Long crab, grilled lobster, grilled tuna, squid cake'),
(1, N'Quán Cơm Niêu Hạ Long', 'Ha Long Clay Pot Rice', N'Hồng Gai, Hạ Long', N'Việt Nam', '100,000-200,000 VNĐ', N'Cơm niêu, canh chua cá, nem nướng', 'Clay pot rice, sour fish soup, grilled spring rolls'),
(1, N'Nhà hàng Emeralda', 'Emeralda Restaurant', N'Bãi Cháy, Hạ Long', N'Âu-Á', '300,000-800,000 VNĐ', N'Buffet hải sản, steak, pasta', 'Seafood buffet, steak, pasta'),
(1, N'Nhà hàng Thanh Sơn', 'Thanh Son Restaurant', N'Đường Hạ Long, Hạ Long', N'Việt Nam', '150,000-300,000 VNĐ', N'Bánh cuốn, bún chả, lẩu cua', 'Vietnamese rice rolls, grilled pork vermicelli, crab hotpot'),
(1, N'Nhà hàng Hương Biển', 'Huong Bien Restaurant', N'Bãi Cháy, Hạ Long', N'Hải sản', '250,000-500,000 VNĐ', N'Cá bớp nướng, mực nướng, tôm hùm', 'Grilled barramundi, grilled squid, lobster'),
(1, N'Nhà hàng Cảng Hạ Long', 'Ha Long Port Restaurant', N'Khu vực Cảng Hạ Long, Hạ Long', N'Âu-Á', '200,000-600,000 VNĐ', N'Steak, cơm chiên hải sản, salad', 'Steak, seafood fried rice, salad'),

-- Đà Lạt
(2, N'Bánh ướt Chồng Đà Lạt', 'Da Lat Wet Rice Paper Rolls', N'Nguyễn Thị Minh Khai, Đà Lạt', N'Việt Nam', '50,000-100,000 VNĐ', N'Bánh ướt lòng heo, bánh căn, chè Đà Lạt', 'Wet rice paper rolls with pork, mini pancakes, Da Lat sweet soup'),
(2, N'Nhà hàng Le Rabelais', 'Le Rabelais Restaurant', N'Trần Phú, Đà Lạt', N'Pháp', '400,000-800,000 VNĐ', N'Foie gras, bít tết, rượu vang Đà Lạt', 'Foie gras, steak, Da Lat wine'),
(2, N'Quán Nem Nướng Ninh Hòa', 'Ninh Hoa Grilled Spring Rolls', N'Bùi Thị Xuân, Đà Lạt', N'Việt Nam', '80,000-150,000 VNĐ', N'Nem nướng, bánh hỏi, nước chấm đặc biệt', 'Grilled spring rolls, vermicelli, special dipping sauce'),
(2, N'Nhà hàng Ẩm thực Đà Lạt', 'Da Lat Cuisine Restaurant', N'Nguyễn Đình Chiểu, Đà Lạt', N'Việt Nam', '100,000-300,000 VNĐ', N'Canh gà lá é, cơm lam, bánh căn', 'Chicken soup with Vietnamese basil, steamed rice, mini pancakes'),
(2, N'Nhà hàng Hoa Sữa', 'Hoa Sua Restaurant', N'Nguyễn Chí Thanh, Đà Lạt', N'Việt Nam', '150,000-350,000 VNĐ', N'Cơm tấm, bún bò Huế, nem lụi', 'Broken rice, Hue beef noodle soup, grilled pork skewers'),

-- Vũng Tàu
(3, N'Aloha Hotel Restaurant', 'Aloha Hotel Restaurant', N'Thùy Vân, Vũng Tàu', N'Hải sản', '150,000-400,000 VNĐ', N'Bánh khọt Vũng Tàu, lẩu cá song, tôm rang me', 'Vung Tau mini pancakes, grouper hotpot, tamarind prawns'),
(3, N'Nhà hàng Ganh Hao', 'Ganh Hao Restaurant', N'Hạ Long, Vũng Tàu', N'Hải sản', '200,000-600,000 VNĐ', N'Cua rang me, ốc hương nướng mỡ hành, cháo hến', 'Tamarind crab, grilled sea snails with scallion oil, clam porridge'),
(3, N'Quán Bánh Mì Má Ti', 'Ma Ti Sandwich', N'Lê Lợi, Vũng Tàu', N'Việt Nam', '15,000-50,000 VNĐ', N'Bánh mì thịt nướng, bánh mì pate, cà phê', 'Grilled meat sandwich, pate sandwich, coffee'),
(3, N'Nhà hàng Long Hải', 'Long Hai Restaurant', N'Long Hải, Vũng Tàu', N'Hải sản', '200,000-500,000 VNĐ', N'Cua biển, cá nướng, sò huyết', 'Crab, grilled fish, blood clams'),
(3, N'Nhà hàng Thuận Kiều', 'Thuan Kieu Restaurant', N'Nguyễn An Ninh, Vũng Tàu', N'Việt Nam', '100,000-250,000 VNĐ', N'Bánh xèo, bún riêu, gỏi cuốn', 'Vietnamese pancakes, crab noodle soup, spring rolls'),

-- Phú Quốc
(4, N'Nhà hàng Crab House', 'Crab House Restaurant', N'Ông Lang, Phú Quốc', N'Hải sản', '300,000-800,000 VNĐ', N'Cua Phú Quốc, ghẹ rang me, cá mú nướng', 'Phu Quoc crab, tamarind blue crab, grilled grouper'),
(4, N'Pepper Farm Restaurant', 'Pepper Farm Restaurant', N'Khu Tượng, Phú Quốc', N'Âu-Á', '250,000-600,000 VNĐ', N'Tôm hùm tiêu đen, cà ri dê, salad hải sản', 'Black pepper lobster, goat curry, seafood salad'),
(4, N'Nhà hàng Ra Khơi', 'Ra Khoi Restaurant', N'Khu vực An Thới, Phú Quốc', N'Hải sản', '250,000-600,000 VNĐ', N'Cua rang me, tôm hùm, ghẹ hấp', 'Tamarind crab, lobster, steamed crab'),
(4, N'Nhà hàng Búp Sen', 'Bup Sen Restaurant', N'Bãi Trường, Phú Quốc', N'Âu-Á', '300,000-800,000 VNĐ', N'Steak, pizza, pasta', 'Steak, pizza, pasta'),
(4, N'Nhà hàng Cội Nguồn', 'Coi Nguon Restaurant', N'Dương Đông, Phú Quốc', N'Việt Nam', '150,000-350,000 VNĐ', N'Gỏi cá trích, cá lóc nướng, hải sản nướng', 'Herring salad, grilled snakehead fish, grilled seafood'),
(4, N'Nhà hàng Ocean', 'Ocean Restaurant', N'Khu du lịch Bãi Sao, Phú Quốc', N'Hải sản', '300,000-700,000 VNĐ', N'Hàu nướng mỡ hành, cá thu nướng, tôm hùm', 'Grilled oysters with scallion oil, grilled tuna, lobster'),
(4, N'Nhà hàng The Spice', 'The Spice Restaurant', N'Thị trấn Dương Đông, Phú Quốc', N'Âu-Á', '200,000-500,000 VNĐ', N'Pizza, pasta, cơm chiên hải sản', 'Pizza, pasta, seafood fried rice'),

-- Sapa
(5, N'Nhà hàng Hill Station', 'Hill Station Restaurant', N'Cầu Mây, Sapa', N'Âu-Á', '200,000-500,000 VNĐ', N'Thịt trâu nướng, cá tầm nướng, rau rừng', 'Grilled buffalo meat, grilled sturgeon, wild vegetables'),
(5, N'Quán Thắng Cố', 'Thang Co Restaurant', N'Fansipan, Sapa', N'Dân tộc', '100,000-250,000 VNĐ', N'Thắng cố, thịt lợn cắp nách, rượu cần', 'Thang co soup, armpit pork, ruou can wine'),
(5, N'Nhà hàng Sapa View', 'Sapa View Restaurant', N'Khu vực trung tâm, Sapa', N'Việt Nam', '100,000-250,000 VNĐ', N'Canh cá hồi, cơm lam, lẩu cá', 'Salmon soup, steamed rice, fish hotpot'),
(5, N'Nhà hàng Hoàng Liên', 'Hoang Lien Restaurant', N'Sapa, Lào Cai', N'Việt Nam', '150,000-400,000 VNĐ', N'Bánh chưng, cơm tấm, nem cuốn', 'Square rice cake, broken rice, spring rolls'),
(5, N'Nhà hàng Thắng Cố', 'Thang Co Restaurant', N'Khu vực thị trấn Sapa, Sapa', N'Việt Nam', '100,000-250,000 VNĐ', N'Thắng cố, lẩu cá tầm, cơm trắng', 'Thang Co, sturgeon hotpot, steamed rice'),
(5, N'Nhà hàng Dzao', 'Dzao Restaurant', N'Bản Cát Cát, Sapa', N'Việt Nam', '120,000-300,000 VNĐ', N'Gà đồi nướng, xôi ngũ sắc, canh rau rừng', 'Grilled hill chicken, five-color sticky rice, wild vegetable soup'),
(5, N'Nhà hàng Lúa Mới', 'Lua Moi Restaurant', N'Khu vực trung tâm Sapa', N'Việt Nam', '150,000-350,000 VNĐ', N'Chả cá Lăng, lẩu cá hồi, xôi đen', 'Lang fish cakes, salmon hotpot, black sticky rice'),

-- Hội An
(6, N'Nhà hàng Morning Glory', 'Morning Glory Restaurant', N'Nguyễn Thái Học, Hội An', N'Việt Nam', '150,000-350,000 VNĐ', N'Cao lầu, mì Quảng, bánh bao', 'Cao lau, Mi Quang, steamed buns'),
(6, N'Nhà hàng Mermaid', 'Mermaid Restaurant', N'Chùa Cầu, Hội An', N'Việt Nam', '100,000-250,000 VNĐ', N'Gỏi cuốn, bún thịt nướng, bánh xèo', 'Spring rolls, grilled pork vermicelli, Vietnamese pancakes'),
(6, N'Nhà hàng Thanh Tâm', 'Thanh Tam Restaurant', N'Phan Châu Trinh, Hội An', N'Việt Nam', '80,000-200,000 VNĐ', N'Bánh bao, bánh vạc, mì Quảng', 'Steamed buns, white rose dumplings, Mi Quang'),
(6, N'Nhà hàng The Temple', 'The Temple Restaurant', N'Khu phố cổ, Hội An', N'Âu-Á', '250,000-600,000 VNĐ', N'Steak, pizza, pasta', 'Steak, pizza, pasta'),
(6, N'Nhà hàng Hai Cây Dừa', 'Hai Cay Dua Restaurant', N'Bà Triệu, Hội An', N'Việt Nam', '100,000-250,000 VNĐ', N'Cơm gà, cao lầu, bánh mì', 'Chicken rice, cao lau, banh mi'),

-- Huế
(7, N'Nhà hàng Cơm Hến', 'Com Hen Restaurant', N'Khu phố cổ, Huế', N'Việt Nam', '50,000-150,000 VNĐ', N'Cơm hến, bún bò Huế, nem lụi', 'Rice with mussels, Hue beef noodle soup, grilled pork skewers'),
(7, N'Nhà hàng Tân Cổ', 'Tan Co Restaurant', N'Nguyễn Huệ, Huế', N'Việt Nam', '150,000-300,000 VNĐ', N'Lẩu cá, bánh bột lọc, nem chua', 'Fish hotpot, tapioca cake, fermented pork'),
(7, N'Nhà hàng Thiên Anh', 'Thien Anh Restaurant', N'Phú Hậu, Huế', N'Việt Nam', '100,000-250,000 VNĐ', N'Bánh bèo, cơm hến, bún thịt nướng', 'Rice cakes, rice with mussels, grilled pork vermicelli'),
(7, N'Nhà hàng La Residence', 'La Residence Restaurant', N'Vị Dạ, Huế', N'Âu-Á', '400,000-800,000 VNĐ', N'Steak, foie gras, bánh xèo', 'Steak, foie gras, Vietnamese pancakes'),
(7, N'Nhà hàng Huế Ẩm Thực', 'Hue Cuisine Restaurant', N'Phan Bội Châu, Huế', N'Việt Nam', '150,000-350,000 VNĐ', N'Chả lụa, bún riêu, cơm trắng', 'Vietnamese sausage, crab noodle soup, steamed rice'),

-- Nha Trang
(8, N'Nhà hàng Sailing Club', 'Sailing Club Restaurant', N'Bãi biển Trần Phú, Nha Trang', N'Âu-Á', '300,000-600,000 VNĐ', N'Steak, pizza, pasta', 'Steak, pizza, pasta'),
(8, N'Nhà hàng Món Huế', 'Mon Hue Restaurant', N'Nguyễn Thiện Thuật, Nha Trang', N'Việt Nam', '100,000-250,000 VNĐ', N'Bánh canh, bún bò Huế, cơm hến', 'Vietnamese noodle soup, Hue beef noodle soup, rice with mussels'),
(8, N'Nhà hàng Nha Trang Seafood', 'Nha Trang Seafood Restaurant', N'Bãi biển, Nha Trang', N'Hải sản', '250,000-600,000 VNĐ', N'Cua rang me, tôm hùm, cá thu', 'Tamarind crab, lobster, tuna'),
(8, N'Nhà hàng La Costa', 'La Costa Restaurant', N'Nguyễn Thị Minh Khai, Nha Trang', N'Âu-Á', '200,000-500,000 VNĐ', N'Pizza, pasta, hải sản nướng', 'Pizza, pasta, grilled seafood'),
(8, N'Nhà hàng Nha Trang Xưa', 'Nha Trang Xua Restaurant', N'Nguyễn Thiện Thuật, Nha Trang', N'Việt Nam', '150,000-350,000 VNĐ', N'Gỏi cuốn, bún thịt nướng, lẩu hải sản', 'Spring rolls, grilled pork vermicelli, seafood hotpot'),

-- Mộc Châu
(9, N'Nhà hàng Sơn La', 'Son La Restaurant', N'Thị trấn Mộc Châu, Sơn La', N'Việt Nam', '100,000-250,000 VNĐ', N'Xôi nếp, thịt lợn mán, canh rau dớn', 'Sticky rice, local pork, wild vegetable soup'),
(9, N'Nhà hàng Dốc Mơ', 'Doc Mo Restaurant', N'Bản Áng, Mộc Châu', N'Việt Nam', '150,000-300,000 VNĐ', N'Gà đồi nướng, cá suối, cơm lam', 'Grilled hill chicken, stream fish, steamed rice'),
(9, N'Nhà hàng Mộc Châu View', 'Moc Chau View Restaurant', N'Khu du lịch Mộc Châu, Sơn La', N'Việt Nam', '200,000-500,000 VNĐ', N'Lẩu cá, thịt dê nướng, xôi ngũ sắc', 'Fish hotpot, grilled goat meat, five-color sticky rice'),
(9, N'Nhà hàng Thảo Nguyên', 'Thao Nguyen Restaurant', N'Thị trấn Mộc Châu, Sơn La', N'Việt Nam', '120,000-250,000 VNĐ', N'Cháo gà, thịt dê, rau sạch', 'Chicken porridge, goat meat, organic vegetables'),
(9, N'Nhà hàng Sapa Mộc Châu', 'Sapa Moc Chau Restaurant', N'Khu vực Mộc Châu, Sơn La', N'Việt Nam', '100,000-300,000 VNĐ', N'Món xôi, lẩu thập cẩm, thịt ba chỉ nướng', 'Sticky rice, mixed hotpot, grilled pork belly'),

-- Đà Nẵng
(10, N'Nhà hàng Bà Rô', 'Ba Ro Restaurant', N'Nguyễn Tất Thành, Đà Nẵng', N'Hải sản', '200,000-500,000 VNĐ', N'Cua rang me, tôm hùm nướng, cá thu', 'Tamarind crab, grilled lobster, tuna'),
(10, N'Nhà hàng Hải Sản 2 Tháng 9', 'Hai San 2 Thang 9 Restaurant', N'2 Tháng 9, Đà Nẵng', N'Hải sản', '150,000-350,000 VNĐ', N'Cá mú, mực nướng, bề bề', 'Grouper, grilled squid, mantis shrimp'),
(10, N'Nhà hàng Ẩm Thực Hương Sơn', 'Am Thuc Huong Son Restaurant', N'Hải Châu, Đà Nẵng', N'Việt Nam', '100,000-250,000 VNĐ', N'Bánh xèo, gỏi cuốn, bún bò Huế', 'Vietnamese pancakes, spring rolls, Hue beef noodle soup'),
(10, N'Nhà hàng The Rachel', 'The Rachel Restaurant', N'Bà Nà Hills, Đà Nẵng', N'Âu-Á', '300,000-700,000 VNĐ', N'Steak, pizza, pasta', 'Steak, pizza, pasta'),
(10, N'Nhà hàng Minh Toàn', 'Minh Toan Restaurant', N'Trần Phú, Đà Nẵng', N'Việt Nam', '100,000-200,000 VNĐ', N'Gà nướng, lẩu cá, cơm tấm', 'Grilled chicken, fish hotpot, broken rice'),

-- Cần Thơ
(11, N'Nhà hàng Ba Sạch', 'Ba Sach Restaurant', N'Chợ Cái Răng, Cần Thơ', N'Việt Nam', '50,000-150,000 VNĐ', N'Bánh xèo, lẩu mắm, cơm tấm', 'Vietnamese pancakes, fish hotpot, broken rice'),
(11, N'Nhà hàng Cần Thơ Xưa', 'Can Tho Xua Restaurant', N'Nguyễn Văn Cừ, Cần Thơ', N'Việt Nam', '100,000-250,000 VNĐ', N'Bánh hỏi, cá lóc nướng, gỏi cuốn', 'Vietnamese vermicelli, grilled snakehead fish, spring rolls'),
(11, N'Nhà hàng Bến Ninh Kiều', 'Ben Ninh Kieu Restaurant', N'Ninh Kiều, Cần Thơ', N'Việt Nam', '150,000-400,000 VNĐ', N'Lẩu cá, mắm tôm, bánh xèo', 'Fish hotpot, shrimp paste, Vietnamese pancakes'),
(11, N'Nhà hàng Sông Hậu', 'Song Hau Restaurant', N'Chợ Cái Răng, Cần Thơ', N'Việt Nam', '120,000-300,000 VNĐ', N'Bánh tằm, lẩu mắm, gỏi đu đủ', 'Banh tam, fish hotpot, papaya salad'),
(11, N'Nhà hàng Hoa Sữa', 'Hoa Sua Restaurant', N'Mỹ Khánh, Cần Thơ', N'Việt Nam', '100,000-250,000 VNĐ', N'Cơm gà, bánh mì, bún riêu', 'Chicken rice, sandwich, crab noodle soup'),

-- An Giang
(12, N'Nhà hàng Bún Cá Châu Đốc', 'Chau Doc Fish Noodle Soup Restaurant', N'Châu Đốc, An Giang', N'Việt Nam', '50,000-150,000 VNĐ', N'Bún cá, cá lóc nướng, bánh xèo', 'Fish noodle soup, grilled snakehead fish, Vietnamese pancakes'),
(12, N'Nhà hàng Năm Phượng', 'Nam Phuong Restaurant', N'Châu Đốc, An Giang', N'Việt Nam', '100,000-250,000 VNĐ', N'Gỏi cuốn, cá lóc nướng, bún mắm', 'Spring rolls, grilled snakehead fish, fermented fish noodle soup'),
(12, N'Nhà hàng Tân Quý', 'Tan Quy Restaurant', N'Tân Châu, An Giang', N'Việt Nam', '80,000-200,000 VNĐ', N'Bánh xèo, gà nướng, bún riêu', 'Vietnamese pancakes, grilled chicken, crab noodle soup'),
(12, N'Nhà hàng Bến Đoàn', 'Ben Doan Restaurant', N'Thị trấn An Phú, An Giang', N'Việt Nam', '120,000-300,000 VNĐ', N'Bánh tằm, mắm nêm, lẩu cá', 'Banh tam, shrimp paste, fish hotpot'),
(12, N'Nhà hàng Hòa Bình', 'Hoa Binh Restaurant', N'Châu Đốc, An Giang', N'Việt Nam', '100,000-250,000 VNĐ', N'Gà đồi, cá lóc nướng, bún mắm', 'Hill chicken, grilled snakehead fish, fermented fish noodle soup'),

-- Hà Giang
(13, N'Nhà hàng Hoàng Su Phì', 'Hoang Su Phi Restaurant', N'Thị trấn Vị Xuyên, Hà Giang', N'Việt Nam', '80,000-200,000 VNĐ', N'Phở chua, xôi ngũ sắc, gà đồi', 'Sour pho, five-color sticky rice, hill chicken'),
(13, N'Quán Bánh Cuốn Phở', 'Banh Cuon Pho Restaurant', N'Trung tâm Hà Giang', N'Việt Nam', '50,000-120,000 VNĐ', N'Bánh cuốn, phở bò, cơm tấm', 'Steamed rice rolls, beef pho, broken rice'),
(13, N'Nhà hàng Tây Bắc', 'Tay Bac Restaurant', N'Phương Thiện, Hà Giang', N'Việt Nam', '100,000-250,000 VNĐ', N'Lẩu cá suối, thịt dê nướng, bánh trôi tàu', 'Stream fish hotpot, grilled goat meat, sweet rice dumplings'),
(13, N'Nhà hàng Cao Nguyên', 'Cao Nguyen Restaurant', N'Hà Giang City', N'Việt Nam', '150,000-350,000 VNĐ', N'Bánh canh, bún mắm, cơm nắm', 'Vietnamese noodle soup, shrimp paste noodle soup, rice balls'),
(13, N'Nhà hàng Lũng Cú', 'Lung Cu Restaurant', N'Lũng Cú, Hà Giang', N'Việt Nam', '120,000-300,000 VNĐ', N'Gà ri nướng, thịt lợn mán, rau rừng', 'Grilled local chicken, local pork, wild vegetables'),

-- Hải Phòng
(14, N'Nhà hàng Hải Sản Cô Đôi', 'Co Doi Seafood Restaurant', N'Lạch Tray, Hải Phòng', N'Hải sản', '200,000-600,000 VNĐ', N'Cua rang me, mực nướng, cá song', 'Tamarind crab, grilled squid, grouper'),
(14, N'Nhà hàng Dân Dã', 'Dan Da Restaurant', N'Nguyễn Bỉnh Khiêm, Hải Phòng', N'Việt Nam', '150,000-350,000 VNĐ', N'Cánh gà nướng, lẩu hải sản, bún riêu', 'Grilled chicken wings, seafood hotpot, crab noodle soup'),
(14, N'Quán Ốc Biển', 'Oc Bien Restaurant', N'Trần Phú, Hải Phòng', N'Hải sản', '100,000-250,000 VNĐ', N'Ốc hương nướng mỡ hành, cua rang me, tôm sú', 'Grilled sea snails with scallion oil, tamarind crab, tiger prawns'),
(14, N'Nhà hàng Lẩu Cua', 'Lau Cua Restaurant', N'Lạch Tray, Hải Phòng', N'Hải sản', '200,000-500,000 VNĐ', N'Lẩu cua, cá nướng, bún hải sản', 'Crab hotpot, grilled fish, seafood noodle soup'),
(14, N'Nhà hàng Tiệc Buffet Hải Sản', 'Seafood Buffet Restaurant', N'Nguyễn Tri Phương, Hải Phòng', N'Hải sản', '350,000-800,000 VNĐ', N'Buffet hải sản, cá hồi nướng, sò điệp', 'Seafood buffet, grilled salmon, scallops'),

-- Bình Thuận
(15, N'Nhà hàng Biển Xanh', 'Bien Xanh Restaurant', N'Phan Thiết, Bình Thuận', N'Hải sản', '150,000-400,000 VNĐ', N'Tôm hùm nướng, mực hấp, cá thu', 'Grilled lobster, steamed squid, tuna'),
(15, N'Nhà hàng Hưng Phát', 'Hung Phat Restaurant', N'Mũi Né, Bình Thuận', N'Hải sản', '200,000-500,000 VNĐ', N'Cua rang me, bề bề nướng, sò điệp', 'Tamarind crab, grilled mantis shrimp, scallops'),
(15, N'Nhà hàng Quán Nha Trang', 'Nha Trang Restaurant', N'Phan Thiết, Bình Thuận', N'Hải sản', '150,000-300,000 VNĐ', N'Cá nướng, hải sản hấp, lẩu cá', 'Grilled fish, steamed seafood, fish hotpot'),
(15, N'Nhà hàng Hoàng Sa', 'Hoang Sa Restaurant', N'Bình Thuận', N'Âu-Á', '200,000-600,000 VNĐ', N'Steak, pizza, hải sản', 'Steak, pizza, seafood'),
(15, N'Nhà hàng Phú Quý', 'Phu Quy Restaurant', N'Mũi Né, Bình Thuận', N'Hải sản', '100,000-250,000 VNĐ', N'Bánh xèo, lẩu hải sản, mực nướng', 'Vietnamese pancakes, seafood hotpot, grilled squid');

--========================================HOTELS DATA==============================
INSERT INTO Hotels (destination_id, name, name_en, address, star_rating, price_range, amenities, amenities_en) VALUES
-- Hạ Long
(1, N'Khách sạn Mường Thanh Grand Hạ Long', 'Muong Thanh Grand Ha Long Hotel', N'Bãi Cháy, Hạ Long', 5, '2,000,000-4,000,000 VNĐ', N'Spa, hồ bơi, phòng gym, nhà hàng, bar', 'Spa, swimming pool, gym, restaurant, bar'),
(1, N'Novotel Ha Long Bay', 'Novotel Ha Long Bay', N'Hạ Long, Quảng Ninh', 4, '1,800,000-3,500,000 VNĐ', N'Hồ bơi vô cực, spa, tennis, kids club', 'Infinity pool, spa, tennis, kids club'),
(1, N'Khách sạn Royal Lotus Hạ Long', 'Royal Lotus Ha Long Hotel', N'Bãi Cháy, Hạ Long', 4, '1,200,000-2,500,000 VNĐ', N'Hồ bơi, massage, karaoke, tour du thuyền', 'Swimming pool, massage, karaoke, cruise tours'),
(1, N'Vinpearl Resort & Spa Hạ Long', 'Vinpearl Resort & Spa Ha Long', N'Vịnh Hạ Long', 5, '3,000,000-6,500,000 VNĐ', N'Spa, hồ bơi vô cực, sân golf, nhà hàng quốc tế', 'Spa, infinity pool, golf course, international restaurant'),
(1, N'Khách sạn Halong Plaza', 'Halong Plaza Hotel', N'Bãi Cháy, Hạ Long', 4, '1,500,000-3,000,000 VNĐ', N'Hồ bơi, phòng gym, nhà hàng, bar, phòng hội nghị', 'Swimming pool, gym, restaurant, bar, conference rooms'),
(1, N'Paradise Suites Hotel', 'Paradise Suites Hotel', N'Đảo Tuần Châu, Hạ Long', 4, '2,500,000-5,000,000 VNĐ', N'Hồ bơi, nhà hàng, phòng họp, dịch vụ du thuyền', 'Swimming pool, restaurant, meeting rooms, cruise services'),

-- Đà Lạt  
(2, N'Ana Mandara Villas Dalat Resort & Spa', 'Ana Mandara Villas Dalat Resort & Spa', N'Lê Lai, Đà Lạt', 5, '3,500,000-8,000,000 VNĐ', N'Villa riêng biệt, spa cao cấp, sân golf, nhà hàng 5 sao', 'Private villas, luxury spa, golf course, 5-star restaurant'),
(2, N'Dalat Palace Luxury Hotel', 'Dalat Palace Luxury Hotel', N'Trần Phú, Đà Lạt', 5, '3,000,000-6,000,000 VNĐ', N'Sân golf 18 lỗ, spa, hồ bơi, casino', '18-hole golf course, spa, swimming pool, casino'),
(2, N'Khách sạn Sammy Dalat', 'Sammy Dalat Hotel', N'Bùi Thị Xuân, Đà Lạt', 4, '800,000-1,500,000 VNĐ', N'Hồ bơi, nhà hàng, tour tham quan', 'Swimming pool, restaurant, sightseeing tours'),
(2, N'Bảo Đại Palace Hotel', 'Bao Dai Palace Hotel', N'Phường 4, Đà Lạt', 4, '1,200,000-2,800,000 VNĐ', N'Spa, nhà hàng, phòng tập gym', 'Spa, restaurant, gym'),
(2, N'Khách sạn Dalat Edensee Lake Resort & Spa', 'Dalat Edensee Lake Resort & Spa', N'Hồ Tuyền Lâm, Đà Lạt', 5, '4,000,000-8,500,000 VNĐ', N'Khu nghỉ dưỡng ven hồ, spa, nhà hàng, bể bơi', 'Lakefront resort, spa, restaurant, swimming pool'),
(2, N'Khách sạn TTC Hotel Premium Ngọc Lan', 'TTC Hotel Premium Ngoc Lan', N'Trần Phú, Đà Lạt', 4, '1,000,000-2,500,000 VNĐ', N'Hồ bơi, spa, karaoke, nhà hàng', 'Swimming pool, spa, karaoke, restaurant'),

-- Vũng Tàu
(3, N'Aloha Hotel Vũng Tàu', 'Aloha Hotel Vung Tau', N'Thùy Vân, Vũng Tàu', 4, '1,200,000-2,500,000 VNĐ', N'Hồ bơi, spa, gym, nhà hàng view biển', 'Swimming pool, spa, gym, sea view restaurant'),
(3, N'Pullman Vung Tau', 'Pullman Vung Tau', N'Thi Sách, Vũng Tàu', 5, '2,500,000-5,000,000 VNĐ', N'Hồ bơi vô cực, spa, club trẻ em, 3 nhà hàng', 'Infinity pool, spa, kids club, 3 restaurants'),
(3, N'Khách sạn Petro House', 'Petro House Hotel', N'Lê Lợi, Vũng Tàu', 4, '900,000-1,800,000 VNĐ', N'Hồ bơi, karaoke, massage, gần biển', 'Swimming pool, karaoke, massage, near beach'),
(3, N'InterContinental Vung Tau', 'InterContinental Vung Tau', N'Khu du lịch Long Hải, Vũng Tàu', 5, '4,500,000-8,000,000 VNĐ', N'Hồ bơi vô cực, spa, sân golf, 3 nhà hàng', 'Infinity pool, spa, golf course, 3 restaurants'),
(3, N'Khách sạn Green Hotel Vũng Tàu', 'Green Hotel Vung Tau', N'Nguyễn An Ninh, Vũng Tàu', 4, '1,000,000-2,500,000 VNĐ', N'Hồ bơi, phòng gym, phòng hội nghị', 'Swimming pool, gym, meeting rooms'),
(3, N'Khách sạn Rạng Đông', 'Rang Dong Hotel', N'Bãi Sau, Vũng Tàu', 3, '500,000-1,500,000 VNĐ', N'Hồ bơi, bar, nhà hàng, gần bãi biển', 'Swimming pool, bar, restaurant, near beach'),

-- Phú Quốc
(4, N'JW Marriott Phu Quoc Emerald Bay Resort & Spa', 'JW Marriott Phu Quoc Emerald Bay', N'Bãi Khem, Phú Quốc', 5, '8,000,000-20,000,000 VNĐ', N'Spa cao cấp, 6 nhà hàng, hồ bơi vô cực, bãi biển riêng', 'Luxury spa, 6 restaurants, infinity pools, private beach'),
(4, N'Salinda Resort Phu Quoc Island', 'Salinda Resort Phu Quoc', N'Cửa Lấp, Phú Quốc', 5, '4,000,000-12,000,000 VNĐ', N'Villa biển, spa, 3 hồ bơi, kids club', 'Beachfront villas, spa, 3 swimming pools, kids club'),
(4, N'Vinpearl Resort & Golf Phú Quốc', 'Vinpearl Resort & Golf Phu Quoc', N'Gành Dầu, Phú Quốc', 5, '4,500,000-9,000,000 VNĐ', N'Spa, hồ bơi vô cực, sân golf, nhà hàng, bar', 'Spa, infinity pool, golf course, restaurant, bar'),
(4, N'InterContinental Phú Quốc Long Beach Resort', 'InterContinental Phu Quoc Long Beach Resort', N'Dương Tơ, Phú Quốc', 5, '5,000,000-12,000,000 VNĐ', N'Spa, hồ bơi vô cực, nhà hàng quốc tế, phòng gym', 'Spa, infinity pool, international restaurant, gym'),
(4, N'Khách sạn Eden Resort Phú Quốc', 'Eden Resort Phu Quoc', N'Dương Đông, Phú Quốc', 4, '2,000,000-4,500,000 VNĐ', N'Hồ bơi, nhà hàng, bãi biển riêng, spa', 'Swimming pool, restaurant, private beach, spa'),
(4, N'Khu nghỉ dưỡng Premier Village Phu Quoc', 'Premier Village Phu Quoc Resort', N'Bãi Kem, Phú Quốc', 5, '6,000,000-15,000,000 VNĐ', N'Spa, bãi biển riêng, nhà hàng, hồ bơi', 'Spa, private beach, restaurant, swimming pool'),
(4, N'Khách sạn Sea Star', 'Sea Star Hotel', N'Bãi Sau, Phú Quốc', 3, '1,000,000-2,500,000 VNĐ', N'Hồ bơi, nhà hàng, bar, gần biển', 'Swimming pool, restaurant, bar, near beach'),

-- Sapa
(5, N'Hotel de la Coupole MGallery', 'Hotel de la Coupole MGallery', N'Mường Hoa, Sapa', 5, '3,000,000-7,000,000 VNĐ', N'Spa, hồ bơi trong nhà, nhà hàng Pháp, bar thưởng trà', 'Spa, indoor pool, French restaurant, tea lounge'),
(5, N'Victoria Sapa Resort & Spa', 'Victoria Sapa Resort & Spa', N'Xuân Viên, Sapa', 4, '2,200,000-4,500,000 VNĐ', N'Spa truyền thống, nhà hàng cao cấp, tour trekking', 'Traditional spa, fine dining, trekking tours'),
(5, N'Khách sạn Sapa Topaz', 'Sapa Topaz Hotel', N'Phố Cầu Mây, Sapa', 4, '1,200,000-2,500,000 VNĐ', N'Spa, nhà hàng, phòng gym, tour tham quan', 'Spa, restaurant, gym, sightseeing tours'),
(5, N'Khách sạn Silk Path Grand Resort & Spa', 'Silk Path Grand Resort & Spa', N'Nhà thờ đá, Sapa', 5, '3,500,000-7,000,000 VNĐ', N'Spa, hồ bơi, nhà hàng, khu vui chơi trẻ em', 'Spa, swimming pool, restaurant, kids play area'),
(5, N'Khách sạn Mường Thanh Sapa', 'Muong Thanh Sapa Hotel', N'Nguyễn Chí Thanh, Sapa', 4, '1,000,000-2,500,000 VNĐ', N'Hồ bơi, phòng gym, nhà hàng, karaoke', 'Swimming pool, gym, restaurant, karaoke'),
(5, N'Khu nghỉ dưỡng Topas Ecolodge', 'Topas Ecolodge Resort', N'Bản Lác, Sapa', 5, '4,000,000-8,000,000 VNĐ', N'Spa, nhà hàng, tour trekking', 'Spa, restaurant, trekking tours'),
(5, N'Khách sạn Green Valley Sapa', 'Green Valley Sapa Hotel', N'Xuân Viên, Sapa', 3, '600,000-1,200,000 VNĐ', N'Nhà hàng, phòng tắm hơi, tour du lịch', 'Restaurant, sauna, tour services'),

-- Hội An
(6, N'Four Seasons Resort The Nam Hai', 'Four Seasons Resort The Nam Hai', N'Điện Dương, Hội An', 5, '10,000,000-25,000,000 VNĐ', N'Spa, hồ bơi vô cực, sân golf, nhà hàng', 'Spa, infinity pool, golf course, restaurant'),
(6, N'Khách sạn Royal Riverside Hoi An', 'Royal Riverside Hoi An Hotel', N'Sông Hoài, Hội An', 4, '1,500,000-3,500,000 VNĐ', N'Hồ bơi, nhà hàng, phòng tập gym, phòng hội nghị', 'Swimming pool, restaurant, gym, conference rooms'),
(6, N'Khu nghỉ dưỡng Anantara Hoi An Resort', 'Anantara Hoi An Resort', N'Riverside, Hội An', 5, '4,500,000-10,000,000 VNĐ', N'Spa, hồ bơi, nhà hàng, bãi biển riêng', 'Spa, swimming pool, restaurant, private beach'),
(6, N'Khách sạn Vinh Hung Riverside', 'Vinh Hung Riverside Hotel', N'Hội An', 4, '1,000,000-2,500,000 VNĐ', N'Hồ bơi, nhà hàng, dịch vụ xe đạp miễn phí', 'Swimming pool, restaurant, free bicycle service'),
(6, N'Khách sạn Little Hoi An', 'Little Hoi An Boutique Hotel & Spa', N'Phố Nguyễn Du, Hội An', 3, '800,000-1,800,000 VNĐ', N'Spa, hồ bơi, nhà hàng, dịch vụ đưa đón sân bay', 'Spa, swimming pool, restaurant, airport transfer service'),

-- Huế
(7, N'Khách sạn Azerai La Residence Huế', 'Azerai La Residence Hue', N'Phú Hậu, Huế', 5, '4,000,000-8,500,000 VNĐ', N'Spa, hồ bơi vô cực, nhà hàng, phòng tập gym', 'Spa, infinity pool, restaurant, gym'),
(7, N'Khách sạn Imperial Huế', 'Imperial Hotel Hue', N'Bến Nghé, Huế', 5, '3,500,000-7,000,000 VNĐ', N'Spa, hồ bơi, nhà hàng, bar', 'Spa, swimming pool, restaurant, bar'),
(7, N'Khách sạn Mondial Huế', 'Mondial Hotel Hue', N'Phạm Ngũ Lão, Huế', 4, '1,500,000-3,500,000 VNĐ', N'Hồ bơi, nhà hàng, karaoke, phòng gym', 'Swimming pool, restaurant, karaoke, gym'),
(7, N'Khách sạn Century Riverside Huế', 'Century Riverside Hue', N'Bến Nghé, Huế', 4, '1,200,000-2,800,000 VNĐ', N'Hồ bơi, nhà hàng, phòng họp, dịch vụ xe đạp', 'Swimming pool, restaurant, meeting rooms, bicycle rental'),
(7, N'Khách sạn Moonlight Huế', 'Moonlight Hotel Hue', N'Nguyễn Huệ, Huế', 3, '800,000-1,800,000 VNĐ', N'Hồ bơi, nhà hàng, bar, phòng massage', 'Swimming pool, restaurant, bar, massage room'),

-- Nha Trang
(8, N'Vinpearl Resort Nha Trang', 'Vinpearl Resort Nha Trang', N'Đảo Hòn Tre, Nha Trang', 5, '5,000,000-12,000,000 VNĐ', N'Spa, hồ bơi vô cực, sân golf, nhà hàng, khu vui chơi', 'Spa, infinity pool, golf course, restaurant, amusement park'),
(8, N'Khách sạn InterContinental Nha Trang', 'InterContinental Nha Trang', N'Trần Phú, Nha Trang', 5, '4,000,000-8,000,000 VNĐ', N'Spa, hồ bơi, gym, nhà hàng', 'Spa, swimming pool, gym, restaurant'),
(8, N'Khách sạn Sunrise Nha Trang', 'Sunrise Nha Trang Beach Hotel & Spa', N'Trần Phú, Nha Trang', 4, '2,500,000-5,500,000 VNĐ', N'Spa, hồ bơi, nhà hàng, phòng gym', 'Spa, swimming pool, restaurant, gym'),
(8, N'Khách sạn Novotel Nha Trang', 'Novotel Nha Trang', N'Trần Phú, Nha Trang', 4, '1,500,000-3,500,000 VNĐ', N'Hồ bơi, nhà hàng, phòng gym, phòng họp', 'Swimming pool, restaurant, gym, meeting rooms'),
(8, N'Khách sạn Galaxy Nha Trang', 'Galaxy Hotel Nha Trang', N'Hải Thượng Lãn Ông, Nha Trang', 3, '600,000-1,500,000 VNĐ', N'Hồ bơi, nhà hàng, phòng massage', 'Swimming pool, restaurant, massage room'),

-- Mộc Châu
(9, N'Khu nghỉ dưỡng Mộc Châu Arena', 'Moc Chau Arena Resort', N'Mộc Châu, Sơn La', 4, '1,200,000-3,000,000 VNĐ', N'Spa, hồ bơi, nhà hàng, khu vui chơi', 'Spa, swimming pool, restaurant, playground'),
(9, N'Khách sạn Mộc Châu', 'Moc Chau Hotel', N'Mộc Châu, Sơn La', 3, '600,000-1,500,000 VNĐ', N'Nhà hàng, phòng tập gym, wifi miễn phí', 'Restaurant, gym, free wifi'),
(9, N'Khu nghỉ dưỡng Thảo Nguyên', 'Thao Nguyen Resort', N'Xã Tân Lập, Mộc Châu', 3, '800,000-1,800,000 VNĐ', N'Spa, nhà hàng, phòng hội nghị', 'Spa, restaurant, conference rooms'),
(9, N'Khách sạn Mộc Châu Happy Land', 'Moc Chau Happy Land Hotel', N'Mộc Châu, Sơn La', 3, '500,000-1,200,000 VNĐ', N'Nhà hàng, khu vui chơi, dịch vụ xe đạp', 'Restaurant, amusement park, bicycle rental'),
(9, N'Khách sạn Hồng Anh', 'Hong Anh Hotel', N'Mộc Châu, Sơn La', 2, '400,000-800,000 VNĐ', N'Nhà hàng, wifi miễn phí', 'Restaurant, free wifi'),

-- Đà Nẵng
(10, N'InterContinental Danang Sun Peninsula Resort', 'InterContinental Danang Sun Peninsula Resort', N'Bán đảo Sơn Trà, Đà Nẵng', 5, '6,000,000-15,000,000 VNĐ', N'Spa, hồ bơi vô cực, sân golf, nhà hàng, khu vui chơi', 'Spa, infinity pool, golf course, restaurant, amusement park'),
(10, N'Khách sạn Novotel Danang Premier Han River', 'Novotel Danang Premier Han River', N'Bạch Đằng, Đà Nẵng', 5, '2,500,000-6,000,000 VNĐ', N'Hồ bơi, nhà hàng, phòng gym, spa', 'Swimming pool, restaurant, gym, spa'),
(10, N'Khách sạn Furama Resort Da Nang', 'Furama Resort Da Nang', N'Trường Sa, Đà Nẵng', 5, '4,500,000-10,000,000 VNĐ', N'Spa, bãi biển riêng, nhà hàng, phòng gym', 'Spa, private beach, restaurant, gym'),
(10, N'Khách sạn Holiday Beach Danang', 'Holiday Beach Danang Hotel', N'Trường Sa, Đà Nẵng', 4, '1,800,000-4,000,000 VNĐ', N'Hồ bơi, nhà hàng, phòng gym, wifi miễn phí', 'Swimming pool, restaurant, gym, free wifi'),
(10, N'Khách sạn Grand Mercure Danang', 'Grand Mercure Danang', N'Hải Châu, Đà Nẵng', 4, '1,500,000-3,500,000 VNĐ', N'Hồ bơi, nhà hàng, spa, phòng gym', 'Swimming pool, restaurant, spa, gym'),

-- Cần Thơ
(11, N'Khách sạn Victoria Cần Thơ Resort', 'Victoria Can Tho Resort', N'Phường Cái Khế, Cần Thơ', 5, '3,000,000-6,000,000 VNĐ', N'Spa, hồ bơi, nhà hàng, phòng gym, khu vui chơi', 'Spa, swimming pool, restaurant, gym, playground'),
(11, N'Khách sạn Ninh Kiều Riverside', 'Ninh Kieu Riverside Hotel', N'Bến Ninh Kiều, Cần Thơ', 4, '1,200,000-2,500,000 VNĐ', N'Hồ bơi, nhà hàng, phòng gym, phòng họp', 'Swimming pool, restaurant, gym, meeting rooms'),
(11, N'Khách sạn Best Western Premier Sonasea', 'Best Western Premier Sonasea', N'Phường An Thới, Cần Thơ', 5, '4,000,000-9,000,000 VNĐ', N'Hồ bơi, nhà hàng, spa, sân golf', 'Swimming pool, restaurant, spa, golf course'),
(11, N'Khách sạn Hau Giang', 'Hau Giang Hotel', N'Phường 7, Cần Thơ', 3, '500,000-1,200,000 VNĐ', N'Nhà hàng, phòng hội nghị, wifi miễn phí', 'Restaurant, conference rooms, free wifi'),
(11, N'Khách sạn Kim Tho', 'Kim Tho Hotel', N'Phường Cái Khế, Cần Thơ', 3, '600,000-1,500,000 VNĐ', N'Nhà hàng, phòng massage, wifi miễn phí', 'Restaurant, massage room, free wifi'),

-- An Giang
(12, N'Khách sạn Victoria Châu Đốc', 'Victoria Chau Doc Hotel', N'Châu Đốc, An Giang', 5, '2,500,000-5,000,000 VNĐ', N'Spa, hồ bơi, nhà hàng, tour du lịch', 'Spa, swimming pool, restaurant, sightseeing tours'),
(12, N'Khách sạn 3 Sao Tân Hòa', 'Tan Hoa Hotel 3 Star', N'Châu Đốc, An Giang', 3, '600,000-1,500,000 VNĐ', N'Nhà hàng, phòng họp, wifi miễn phí', 'Restaurant, meeting rooms, free wifi'),
(12, N'Khách sạn Hòa Bình', 'Hoa Binh Hotel', N'Châu Đốc, An Giang', 3, '400,000-1,000,000 VNĐ', N'Nhà hàng, phòng hội nghị, wifi miễn phí', 'Restaurant, conference rooms, free wifi'),
(12, N'Khách sạn Green An Giang', 'Green An Giang Hotel', N'Thị Trấn Long Xuyên, An Giang', 4, '1,200,000-2,500,000 VNĐ', N'Hồ bơi, nhà hàng, phòng gym', 'Swimming pool, restaurant, gym'),
(12, N'Khách sạn Ánh Dương', 'Anh Duong Hotel', N'Thị Trấn Long Xuyên, An Giang', 2, '300,000-700,000 VNĐ', N'Wifi miễn phí, phòng hội nghị', 'Free wifi, conference rooms'),

-- Hà Giang
(13, N'Khách sạn Mèo Vạc', 'Meo Vac Hotel', N'Mèo Vạc, Hà Giang', 3, '600,000-1,200,000 VNĐ', N'Nhà hàng, wifi miễn phí, phòng hội nghị', 'Restaurant, free wifi, conference rooms'),
(13, N'Khách sạn Hương Sơn', 'Huong Son Hotel', N'Thị trấn Tam Sơn, Hà Giang', 3, '500,000-1,000,000 VNĐ', N'Nhà hàng, phòng massage, wifi miễn phí', 'Restaurant, massage room, free wifi'),
(13, N'Khách sạn Quan Ba', 'Quan Ba Hotel', N'Quan Ba, Hà Giang', 2, '300,000-800,000 VNĐ', N'Nhà hàng, wifi miễn phí', 'Restaurant, free wifi'),
(13, N'Khách sạn Hà Giang Riverside', 'Ha Giang Riverside Hotel', N'Bờ sông, Hà Giang', 4, '1,000,000-2,500,000 VNĐ', N'Hồ bơi, phòng gym, nhà hàng', 'Swimming pool, gym, restaurant'),
(13, N'Khách sạn Cao nguyên đá', 'Stone Plateau Hotel', N'Cao nguyên đá Đồng Văn, Hà Giang', 4, '1,500,000-3,000,000 VNĐ', N'Spa, nhà hàng, phòng gym, tour du lịch', 'Spa, restaurant, gym, sightseeing tours'),

-- Hải Phòng
(14, N'Vinpearl Hotel Hải Phòng', 'Vinpearl Hotel Hai Phong', N'Quận Hải An, Hải Phòng', 5, '2,500,000-6,000,000 VNĐ', N'Hồ bơi, spa, nhà hàng, gym, khu vui chơi trẻ em', 'Swimming pool, spa, restaurant, gym, kids club'),
(14, N'Khách sạn Pearl River', 'Pearl River Hotel', N'Quận Hồng Bàng, Hải Phòng', 4, '1,500,000-3,500,000 VNĐ', N'Nhà hàng, phòng hội nghị, spa', 'Restaurant, conference rooms, spa'),
(14, N'Khách sạn Marina', 'Marina Hotel', N'Bến Bính, Hải Phòng', 3, '1,000,000-2,000,000 VNĐ', N'Nhà hàng, wifi miễn phí, phòng massage', 'Restaurant, free wifi, massage room'),
(14, N'Khách sạn Scorpion', 'Scorpion Hotel', N'Trung tâm Hải Phòng', 3, '600,000-1,500,000 VNĐ', N'Nhà hàng, wifi miễn phí', 'Restaurant, free wifi'),
(14, N'Khách sạn Grand Plaza Hải Phòng', 'Grand Plaza Hai Phong', N'Quận Ngô Quyền, Hải Phòng', 4, '1,200,000-3,000,000 VNĐ', N'Nhà hàng, phòng gym, phòng hội nghị, bãi đỗ xe', 'Restaurant, gym, conference rooms, parking lot'),

-- Bình Thuận
(15, N'Rạn đá Ninh Chữ Resort', 'Ninh Chu Reef Resort', N'Ninh Chữ, Bình Thuận', 5, '3,000,000-7,000,000 VNĐ', N'Khu nghỉ dưỡng ven biển, hồ bơi, nhà hàng, sân tennis', 'Beachfront resort, swimming pool, restaurant, tennis court'),
(15, N'Phan Thiet Ocean Dunes Resort', 'Ocean Dunes Resort Phan Thiet', N'Phan Thiết, Bình Thuận', 4, '2,000,000-5,000,000 VNĐ', N'Hồ bơi, sân golf, nhà hàng, phòng tập thể dục', 'Swimming pool, golf course, restaurant, gym'),
(15, N'Khách sạn Sea Links Beach Resort', 'Sea Links Beach Resort', N'Mũi Né, Bình Thuận', 5, '4,500,000-10,000,000 VNĐ', N'Hồ bơi vô cực, sân golf, spa, bãi biển riêng', 'Infinity pool, golf course, spa, private beach'),
(15, N'Khách sạn The Cliff Resort & Residences', 'The Cliff Resort & Residences', N'Mũi Né, Bình Thuận', 4, '2,500,000-6,000,000 VNĐ', N'Hồ bơi, nhà hàng, spa, bãi biển riêng', 'Swimming pool, restaurant, spa, private beach'),
(15, N'Khách sạn Bamboo Village Beach Resort & Spa', 'Bamboo Village Beach Resort & Spa', N'Mũi Né, Bình Thuận', 4, '2,000,000-5,000,000 VNĐ', N'Hồ bơi, spa, nhà hàng, yoga', 'Swimming pool, spa, restaurant, yoga');

--========================================TRANSPORTATIONS DATA==============================
INSERT INTO Transportation (destination_id, name, name_en, type, price_range) VALUES
--Hạ Long
(1, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 220,000 VNĐ'),
(1, 'Taxi', 'Taxi', 'Taxi', '250,000 - 400,000 VNĐ'),
(1, 'Máy bay', 'Airplane', 'Máy bay', '500,000 - 1,000,000 VNĐ'),

--Đà Lạt
(2, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 200,000 VNĐ'),
(2, 'Taxi', 'Taxi', 'Taxi', '250,000 - 400,000 VNĐ'),
(2, 'Xe máy', 'Motorbike', 'Xe máy', '100,000 - 150,000 VNĐ'),

--Vũng Tàu
(3, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 200,000 VNĐ'),
(3, 'Taxi', 'Taxi', 'Taxi', '250,000 - 400,000 VNĐ'),
(3, 'Xe máy', 'Motorbike', 'Xe máy', '100,000 - 150,000 VNĐ'),

-- Phú Quốc
(4, 'Máy bay', 'Airplane', 'Máy bay', '500,000 - 1,500,000 VNĐ'),
(4, 'Taxi', 'Taxi', 'Taxi', '200,000 - 400,000 VNĐ'),

-- Sapa
(5, 'Xe khách', 'Bus', 'Xe khách', '150,000 - 250,000 VNĐ'),
(5, 'Máy bay', 'Airplane', 'Máy bay', '1,000,000 - 2,000,000 VNĐ'),
(5, 'Taxi', 'Taxi', 'Taxi', '300,000 - 500,000 VNĐ'),

-- Hội An
(6, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 200,000 VNĐ'),
(6, 'Máy bay', 'Airplane', 'Máy bay', '900,000 - 1,800,000 VNĐ'),
(6, 'Taxi', 'Taxi', 'Taxi', '250,000 - 400,000 VNĐ'),

-- Huế
(7, 'Xe khách', 'Bus', 'Xe khách', '150,000 - 250,000 VNĐ'),
(7, 'Taxi', 'Taxi', 'Taxi', '200,000 - 350,000 VNĐ'),
(7, 'Máy bay', 'Airplane', 'Máy bay', '700,000 - 1,500,000 VNĐ'),

-- Nha Trang
(8, 'Xe khách', 'Bus', 'Xe khách', '150,000 - 250,000 VNĐ'),
(8, 'Taxi', 'Taxi', 'Taxi', '200,000 - 350,000 VNĐ'),
(8, 'Máy bay', 'Airplane', 'Máy bay', '700,000 - 1,800,000 VNĐ'),

-- Mộc Châu
(9, 'Xe khách', 'Bus', 'Xe khách', '100,000 - 200,000 VNĐ'),
(9, 'Taxi', 'Taxi', 'Taxi', '250,000 - 400,000 VNĐ'),
(9, 'Xe máy', 'Motorbike', 'Xe máy', '100,000 - 150,000 VNĐ'),

-- Đà Nẵng
(10, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 200,000 VNĐ'),
(10, 'Taxi', 'Taxi', 'Taxi', '250,000 - 400,000 VNĐ'),
(10, 'Máy bay', 'Airplane', 'Máy bay', '800,000 - 1,800,000 VNĐ'),

-- Cần Thơ
(11, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 220,000 VNĐ'),
(11, 'Taxi', 'Taxi', 'Taxi', '200,000 - 350,000 VNĐ'),
(11, 'Máy bay', 'Airplane', 'Máy bay', '500,000 - 1,200,000 VNĐ'),

-- An Giang
(12, 'Xe khách', 'Bus', 'Xe khách', '100,000 - 180,000 VNĐ'),
(12, 'Taxi', 'Taxi', 'Taxi', '180,000 - 300,000 VNĐ'),
(12, 'Xe máy', 'Motorbike', 'Xe máy', '80,000 - 150,000 VNĐ'),

-- Hà Giang
(13, 'Xe khách', 'Bus', 'Xe khách', '150,000 - 300,000 VNĐ'),
(13, 'Taxi', 'Taxi', 'Taxi', '300,000 - 500,000 VNĐ'),
(13, 'Xe máy', 'Motorbike', 'Xe máy', '100,000 - 180,000 VNĐ'),

-- Hải Phòng
(14, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 220,000 VNĐ'),
(14, 'Taxi', 'Taxi', 'Taxi', '250,000 - 400,000 VNĐ'),
(14, 'Máy bay', 'Airplane', 'Máy bay', '500,000 - 1,000,000 VNĐ'),

-- Bình Thuận
(15, 'Xe khách', 'Bus', 'Xe khách', '120,000 - 200,000 VNĐ'),
(15, 'Taxi', 'Taxi', 'Taxi', '200,000 - 350,000 VNĐ'),
(15, 'Xe máy', 'Motorbike', 'Xe máy', '100,000 - 150,000 VNĐ');

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

PRINT 'Database TourismDB đã được tạo thành công !';