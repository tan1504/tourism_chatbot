-- Tạo database
CREATE DATABASE TourismChatbot;
GO

USE TourismChatbot;
GO

-- Bảng điểm đến du lịch
CREATE TABLE Destinations (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name_vi NVARCHAR(255) NOT NULL,
    name_en NVARCHAR(255) NOT NULL,
    location NVARCHAR(255),
    description_vi NTEXT,
    description_en NTEXT,
    category NVARCHAR(100), -- historical, natural, cultural, beach, mountain, etc.
    rating FLOAT,
    best_time_to_visit NVARCHAR(100),
    entry_fee NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng văn hóa
CREATE TABLE Culture (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name_vi NVARCHAR(255) NOT NULL,
    name_en NVARCHAR(255) NOT NULL,
    type NVARCHAR(100), -- festival, tradition, custom, art, etc.
    description_vi NTEXT,
    description_en NTEXT,
    location NVARCHAR(255),
    time_period NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng ẩm thực
CREATE TABLE Cuisine (
    id INT IDENTITY(1,1) PRIMARY KEY,
    dish_name_vi NVARCHAR(255) NOT NULL,
    dish_name_en NVARCHAR(255) NOT NULL,
    type NVARCHAR(100), -- main_dish, appetizer, dessert, drink, street_food, etc.
    description_vi NTEXT,
    description_en NTEXT,
    ingredients_vi NTEXT,
    ingredients_en NTEXT,
    origin_location NVARCHAR(255),
    price_range NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng hoạt động du lịch
CREATE TABLE Activities (
    id INT IDENTITY(1,1) PRIMARY KEY,
    activity_name_vi NVARCHAR(255) NOT NULL,
    activity_name_en NVARCHAR(255) NOT NULL,
    destination_id INT,
    type NVARCHAR(100), -- adventure, relaxation, cultural, shopping, etc.
    description_vi NTEXT,
    description_en NTEXT,
    duration NVARCHAR(100),
    difficulty_level NVARCHAR(50),
    price_range NVARCHAR(100),
    FOREIGN KEY (destination_id) REFERENCES Destinations(id)
);

-- Bảng khách sạn / nhà nghỉ
CREATE TABLE Hotels (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name_vi NVARCHAR(255) NOT NULL,
    name_en NVARCHAR(255) NOT NULL,
    location NVARCHAR(255),         -- Địa chỉ hoặc khu vực
    description_vi NTEXT,
    description_en NTEXT,
    category NVARCHAR(100),         -- Ví dụ: hotel, resort, homestay, hostel...
    star_rating INT,                -- Số sao: 1-5
    price_range NVARCHAR(100),      -- Ví dụ: 500,000 - 2,000,000 VND / đêm
    amenities NVARCHAR(255),        -- Ví dụ: Free WiFi, Pool, Spa...
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng nhà hàng / quán ăn
CREATE TABLE Restaurants (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name_vi NVARCHAR(255) NOT NULL,
    name_en NVARCHAR(255) NOT NULL,
    location NVARCHAR(255),         -- Địa chỉ chi tiết hoặc khu vực
    description_vi NTEXT,
    description_en NTEXT,
    cuisine_type NVARCHAR(100),     -- Ví dụ: Vietnamese, Seafood, BBQ...
    price_range NVARCHAR(100),      -- Ví dụ: 50,000 - 200,000 VND
    rating FLOAT,
    opening_hours NVARCHAR(100),    -- Ví dụ: 8:00 - 22:00
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng phương tiện di chuyển
CREATE TABLE Transportation (
    id INT PRIMARY KEY IDENTITY(1,1),
    origin NVARCHAR(255),              -- Nơi xuất phát (ví dụ: TP.HCM, Hà Nội)
    destination_id INT,                -- Liên kết tới bảng Destinations
    transport_mode NVARCHAR(100),      -- Loại phương tiện (bus, train, flight, taxi...)
    description_vi NVARCHAR(MAX),
    description_en NVARCHAR(MAX),
    cost_min DECIMAL(18,2),            -- Giá thấp nhất
    cost_max DECIMAL(18,2),            -- Giá cao nhất
    duration NVARCHAR(100),            -- Thời gian di chuyển (ví dụ: "2 giờ", "5-6 tiếng")
    FOREIGN KEY (destination_id) REFERENCES Destinations(id)
);

CREATE TABLE ChatHistory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_message NVARCHAR(MAX) NOT NULL,
    bot_response NVARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

-- Insert dữ liệu mẫu cho Destinations
INSERT INTO Destinations (name_vi, name_en, location, description_vi, description_en, category, rating, best_time_to_visit, entry_fee)
VALUES 
(N'Vịnh Hạ Long', N'Ha Long Bay', N'Quảng Ninh', 
 N'Di sản thiên nhiên thế giới với hàng nghìn đảo đá vôi kỳ thú nổi lên từ vùng biển xanh ngọc bích.',
 N'UNESCO World Natural Heritage site featuring thousands of limestone islands rising from emerald waters.',
 N'natural', 4.8, N'Tháng 3-5, 9-11', N'200,000 - 500,000 VND'),

(N'Phố cổ Hội An', N'Hoi An Ancient Town', N'Quảng Nam',
 N'Thị trấn cổ được UNESCO công nhận với kiến trúc độc đáo pha trộn văn hóa Việt Nam, Trung Quốc và Nhật Bản.',
 N'UNESCO-recognized ancient town with unique architecture blending Vietnamese, Chinese and Japanese cultures.',
 N'historical', 4.7, N'Tháng 2-4, 8-10', N'120,000 VND'),

(N'Sapa', N'Sapa', N'Lào Cai',
 N'Thị trấn miền núi nổi tiếng với ruộng bậc thang đẹp như tranh và văn hóa dân tộc thiểu số phong phú.',
 N'Mountain town famous for stunning terraced rice fields and rich ethnic minority cultures.',
 N'mountain', 4.6, N'Tháng 3-5, 9-11', N'Miễn phí'),

(N'Đà Lạt', N'Da Lat', N'Lâm Đồng',
 N'Thành phố ngàn hoa với khí hậu mát mẻ quanh năm, nổi tiếng với các đồi thông, hồ nước và kiến trúc Pháp cổ.',
 N'City of flowers with a cool year-round climate, famous for pine hills, lakes, and French colonial architecture.',
 N'mountain', 4.7, N'Tháng 11 - 3', N'Miễn phí'),

(N'Bà Nà Hills', N'Ba Na Hills', N'Đà Nẵng',
 N'Khu du lịch trên núi với Cầu Vàng nổi tiếng, khí hậu mát mẻ và công trình kiến trúc châu Âu.',
 N'Mountain resort featuring the famous Golden Bridge, cool climate, and European-style architecture.',
 N'entertainment', 4.5, N'Tháng 3 - 9', N'850,000 VND'),

(N'Côn Đảo', N'Con Dao Islands', N'Bà Rịa - Vũng Tàu',
 N'Hòn đảo hoang sơ với bãi biển đẹp và lịch sử gắn liền với nhà tù thời Pháp.',
 N'Pristine island with beautiful beaches and historical significance due to former French colonial prisons.',
 N'island', 4.6, N'Tháng 3 - 9', N'Miễn phí'),

(N'Chùa Một Cột', N'One Pillar Pagoda', N'Hà Nội',
 N'Ngôi chùa độc đáo xây trên một cột đá, biểu tượng văn hóa tâm linh của Hà Nội.',
 N'Unique pagoda built on a single stone pillar, a spiritual and cultural symbol of Hanoi.',
 N'cultural', 4.3, N'Tháng 10 - 4', N'Miễn phí'),

(N'Mũi Né', N'Mui Ne', N'Bình Thuận',
 N'Điểm du lịch biển nổi tiếng với đồi cát bay và làng chài truyền thống.',
 N'Popular beach destination known for red sand dunes and traditional fishing villages.',
 N'beach', 4.4, N'Tháng 11 - 4', N'Miễn phí'),

(N'Vườn quốc gia Phong Nha - Kẻ Bàng', N'Phong Nha - Ke Bang National Park', N'Quảng Bình',
 N'Vườn quốc gia với hệ thống hang động kỳ vĩ, trong đó có Sơn Đoòng - hang lớn nhất thế giới.',
 N'National park with spectacular cave systems, including Son Doong - the largest cave in the world.',
 N'natural', 4.9, N'Tháng 2 - 8', N'150,000 - 1,500,000 VND'),

(N'Cố đô Huế', N'Hue Imperial City', N'Thừa Thiên Huế',
 N'Kinh đô xưa của triều Nguyễn với cung điện, lăng tẩm và di tích lịch sử đồ sộ.',
 N'Former imperial capital of the Nguyen Dynasty with palaces, tombs, and grand historical relics.',
 N'historical', 4.6, N'Tháng 1 - 3', N'150,000 VND'),

(N'Nhà thờ Đức Bà Sài Gòn', N'Saigon Notre-Dame Cathedral', N'TP. Hồ Chí Minh',
 N'Công trình kiến trúc Pháp cổ nổi bật giữa trung tâm thành phố, là điểm tham quan không thể bỏ lỡ.',
 N'Iconic French colonial cathedral in the city center, a must-see landmark in Ho Chi Minh City.',
 N'cultural', 4.4, N'Quanh năm', N'Miễn phí'),

(N'Đảo Phú Quốc', N'Phu Quoc Island', N'Kiên Giang',
 N'Đảo ngọc nổi tiếng với biển xanh, cát trắng, hải sản tươi sống và các khu nghỉ dưỡng cao cấp.',
 N'Pearl island famous for turquoise sea, white sand, fresh seafood, and luxury resorts.',
 N'island', 4.8, N'Tháng 11 - 4', N'Miễn phí'),

(N'Hồ Ba Bể', N'Ba Be Lake', N'Bắc Kạn',
 N'Hồ nước ngọt tự nhiên lớn nhất Việt Nam, nằm giữa núi rừng nguyên sinh và là nơi lý tưởng cho du lịch sinh thái.',
 N'Largest natural freshwater lake in Vietnam, nestled in pristine mountains—ideal for eco-tourism.',
 N'natural', 4.5, N'Tháng 4 - 10', N'25,000 - 50,000 VND'),

(N'Tràng An', N'Trang An', N'Ninh Bình',
 N'Khu du lịch sinh thái nổi bật với hệ thống hang động, sông nước và di tích cổ kính.',
 N'Eco-tourism complex famous for cave systems, waterways, and ancient temples.',
 N'natural', 4.8, N'Tháng 1 - 4, 10 - 12', N'250,000 VND'),

(N'Bắc Hà', N'Bac Ha', N'Lào Cai',
 N'Thị trấn vùng cao nổi tiếng với chợ phiên dân tộc, rượu ngô và văn hóa bản địa.',
 N'Mountain town known for ethnic markets, corn wine, and rich local culture.',
 N'cultural', 4.4, N'Tháng 10 - 4', N'Miễn phí'),

(N'Bãi Cháy', N'Bai Chay Beach', N'Quảng Ninh',
 N'Bãi biển nhân tạo nổi bật gần Vịnh Hạ Long, phù hợp nghỉ dưỡng và vui chơi.',
 N'Popular man-made beach near Ha Long Bay, great for leisure and activities.',
 N'beach', 4.2, N'Tháng 4 - 9', N'Miễn phí'),

(N'Rừng tràm Trà Sư', N'Tra Su Cajuput Forest', N'An Giang',
 N'Khu sinh thái ngập nước với hệ động thực vật đa dạng, nổi bật vào mùa nước nổi.',
 N'Flooded forest with diverse flora and fauna, best visited during high-water season.',
 N'natural', 4.5, N'Tháng 9 - 11', N'100,000 - 200,000 VND'),

(N'Làng cổ Đường Lâm', N'Duong Lam Ancient Village', N'Hà Nội',
 N'Làng cổ đặc trưng Bắc Bộ với nhà cổ đá ong, đình làng và văn hóa truyền thống.',
 N'Northern ancient village with laterite houses, communal houses, and local traditions.',
 N'historical', 4.3, N'Tháng 10 - 4', N'20,000 - 50,000 VND'),

(N'Núi Bà Đen', N'Ba Den Mountain', N'Tây Ninh',
 N'Ngọn núi cao nhất Nam Bộ với cáp treo, chùa Bà và cảnh quan hùng vĩ.',
 N'The highest mountain in Southern Vietnam with cable car, pagodas, and scenic views.',
 N'mountain', 4.6, N'Tháng 11 - 4', N'250,000 - 400,000 VND'),

(N'Đảo Lý Sơn', N'Ly Son Island', N'Quảng Ngãi',
 N'Hòn đảo núi lửa với cảnh biển đẹp, di tích lịch sử và đặc sản tỏi nổi tiếng.',
 N'Volcanic island with beautiful beaches, historical sites, and famous garlic products.',
 N'island', 4.7, N'Tháng 3 - 8', N'Miễn phí'),

(N'Bảo tàng Chứng tích Chiến tranh', N'War Remnants Museum', N'TP. Hồ Chí Minh',
 N'Nơi lưu giữ hình ảnh và hiện vật về chiến tranh Việt Nam với giá trị giáo dục cao.',
 N'Museum showcasing images and artifacts from the Vietnam War with strong educational value.',
 N'historical', 4.5, N'Quanh năm', N'40,000 VND'),

(N'Bãi biển Nhật Lệ', N'Nhat Le Beach', N'Quảng Bình',
 N'Bãi biển hoang sơ với cát trắng mịn và làn nước trong xanh.',
 N'Unspoiled beach with fine white sand and clear blue waters.',
 N'beach', 4.3, N'Tháng 4 - 8', N'Miễn phí'),

(N'Làng lụa Vạn Phúc', N'Van Phuc Silk Village', N'Hà Nội',
 N'Làng nghề truyền thống nổi tiếng với sản phẩm lụa tơ tằm chất lượng cao.',
 N'Famous traditional craft village specializing in high-quality silk products.',
 N'cultural', 4.2, N'Quanh năm', N'Miễn phí'),

(N'Pù Luông', N'Pu Luong Nature Reserve', N'Thanh Hóa',
 N'Khu bảo tồn thiên nhiên với ruộng bậc thang, bản làng dân tộc và không khí trong lành.',
 N'Nature reserve with terraced rice fields, ethnic villages, and fresh air.',
 N'natural', 4.6, N'Tháng 5 - 6, 9 - 10', N'Miễn phí'),

(N'Bãi biển Cửa Lò', N'Cua Lo Beach', N'Nghệ An',
 N'Một trong những bãi biển nổi tiếng Bắc Trung Bộ với cát mịn và hải sản tươi ngon.',
 N'Famous beach in North Central Vietnam with fine sand and fresh seafood.',
 N'beach', 4.1, N'Tháng 5 - 8', N'Miễn phí'),

(N'Thác Bản Giốc', N'Ban Gioc Waterfall', N'Cao Bằng',
 N'Một trong những thác nước lớn và đẹp nhất Việt Nam nằm gần biên giới Trung Quốc.',
 N'One of Vietnam’s most spectacular waterfalls near the China border.',
 N'natural', 4.9, N'Tháng 8 - 10', N'45,000 VND'),

(N'Chợ nổi Cái Răng', N'Cai Rang Floating Market', N'Cần Thơ',
 N'Chợ nổi lớn nhất miền Tây, nơi buôn bán nông sản diễn ra trên sông.',
 N'Largest floating market in the Mekong Delta, where trading takes place on boats.',
 N'cultural', 4.4, N'Tháng 5 - 8', N'50,000 VND (tour thuyền)'),

(N'Làng chài Hàm Ninh', N'Ham Ninh Fishing Village', N'Phú Quốc',
 N'Làng chài cổ nổi tiếng với hải sản tươi sống và cảnh hoàng hôn tuyệt đẹp.',
 N'Ancient fishing village known for fresh seafood and stunning sunsets.',
 N'cultural', 4.3, N'Quanh năm', N'Miễn phí'),

(N'Vịnh Vĩnh Hy', N'Vinh Hy Bay', N'Ninh Thuận',
 N'Vịnh biển nguyên sơ với nước trong xanh, thích hợp cho du lịch sinh thái.',
 N'Unspoiled bay with crystal-clear water, ideal for eco-tourism.',
 N'beach', 4.5, N'Tháng 4 - 8', N'Miễn phí'),

(N'Đồi chè Cầu Đất', N'Cau Dat Tea Hill', N'Đà Lạt',
 N'Đồi chè xanh ngát nằm trên cao nguyên với khung cảnh tuyệt đẹp cho check-in.',
 N'Lush green tea hills on the highland, perfect for photography and relaxation.',
 N'natural', 4.6, N'Tháng 10 - 3', N'Miễn phí'),

(N'Bảo tàng Dân tộc học Việt Nam', N'Vietnam Museum of Ethnology', N'Hà Nội',
 N'Nơi trưng bày văn hóa các dân tộc Việt Nam qua hiện vật, mô hình và phim tư liệu.',
 N'Museum showcasing the cultures of Vietnam’s ethnic groups through exhibits and documentaries.',
 N'cultural', 4.7, N'Quanh năm', N'40,000 VND'),

(N'Đảo Nam Du', N'Nam Du Island', N'Kiên Giang',
 N'Hòn đảo hoang sơ với bãi biển đẹp, nước trong và phong cảnh yên bình.',
 N'Peaceful island with beautiful beaches and crystal-clear water.',
 N'island', 4.5, N'Tháng 3 - 8', N'Miễn phí'),

(N'Hồ Tuyền Lâm', N'Tuyen Lam Lake', N'Đà Lạt',
 N'Hồ nước lớn và thơ mộng nằm giữa rừng thông, lý tưởng để dã ngoại và chèo thuyền.',
 N'Scenic lake surrounded by pine forest, ideal for picnics and boating.',
 N'natural', 4.6, N'Tháng 10 - 3', N'Miễn phí'),

(N'Vũng Tàu', N'Vung Tau', N'Bà Rịa - Vũng Tàu',
 N'Thành phố biển nổi tiếng gần TP.HCM, hấp dẫn với bãi biển đẹp, hải sản tươi ngon và nhiều địa danh lịch sử, văn hóa.',
 N'Coastal city near Ho Chi Minh City, famous for its beautiful beaches, fresh seafood, and various historical and cultural landmarks.',
 N'city', 4.5, N'Tháng 3 - 9', N'Miễn phí');

-- Insert dữ liệu mẫu cho Culture
INSERT INTO Culture (name_vi, name_en, type, description_vi, description_en, location, time_period)
VALUES
(N'Tết Nguyên Đán', N'Lunar New Year', N'festival',
 N'Lễ hội truyền thống quan trọng nhất của người Việt Nam, đánh dấu năm mới theo âm lịch.',
 N'The most important traditional festival of Vietnamese people, marking the lunar new year.',
 N'Toàn quốc', N'Tháng 1-2 âm lịch'),

(N'Nghệ thuật múa rối nước', N'Water Puppetry', N'art',
 N'Nghệ thuật biểu diễn truyền thống độc đáo của Việt Nam với các con rối được điều khiển trên mặt nước.',
 N'Unique traditional Vietnamese performing art featuring puppets controlled on water surface.',
 N'Bắc Bộ', N'Quanh năm'),

(N'Lễ hội Chùa Hương', N'Huong Pagoda Festival', N'festival',
 N'Một trong những lễ hội lớn nhất miền Bắc, thu hút hàng vạn phật tử hành hương đến chùa Hương.',
 N'One of the biggest festivals in Northern Vietnam, attracting thousands of pilgrims to Huong Pagoda.',
 N'Hà Nội', N'Tháng 1-3 âm lịch'),

(N'Áo dài', N'Ao Dai', N'custom',
 N'Trang phục truyền thống tôn vinh vẻ đẹp duyên dáng của người phụ nữ Việt Nam.',
 N'Traditional costume symbolizing the graceful beauty of Vietnamese women.',
 N'Toàn quốc', N'Quanh năm'),

(N'Lễ hội Đền Hùng', N'Hung Kings Temple Festival', N'festival',
 N'Lễ hội tưởng nhớ các Vua Hùng – tổ tiên của dân tộc Việt Nam, được tổ chức vào ngày Giỗ Tổ. ',
 N'Festival honoring the Hung Kings – ancestors of the Vietnamese people, held on the Hung Kings’ Death Anniversary.',
 N'Phú Thọ', N'Ngày 10 tháng 3 âm lịch'),

(N'Nghệ thuật ca trù', N'Ca Tru Singing', N'art',
 N'Loại hình nghệ thuật hát cổ truyền có từ thế kỷ 15, được UNESCO công nhận là di sản phi vật thể. ',
 N'Ancient genre of chamber music from the 15th century, recognized by UNESCO as intangible heritage.',
 N'Bắc Bộ', N'Quanh năm'),

(N'Tết Trung Thu', N'Mid-Autumn Festival', N'festival',
 N'Lễ hội dành cho thiếu nhi với đèn lồng, múa lân và bánh Trung Thu truyền thống.',
 N'Children’s festival with lanterns, lion dances, and traditional mooncakes.',
 N'Toàn quốc', N'Tháng 8 âm lịch'),

(N'Lễ hội Cồng chiêng Tây Nguyên', N'Gong Culture Festival', N'festival',
 N'Lễ hội đặc trưng của các dân tộc Tây Nguyên với biểu diễn cồng chiêng truyền thống.',
 N'Festival of Central Highlands ethnic groups with traditional gong performances.',
 N'Tây Nguyên', N'Tháng 3 hoặc theo mùa vụ'),

(N'Nghệ thuật tuồng', N'Tuong Classical Drama', N'art',
 N'Hình thức sân khấu cổ truyền với các yếu tố vũ đạo, âm nhạc và hóa trang đặc sắc.',
 N'Traditional theatrical art form with stylized dance, music, and elaborate costumes.',
 N'Toàn quốc', N'Quanh năm'),

(N'Lễ cưới truyền thống', N'Traditional Wedding Ceremony', N'custom',
 N'Nghi lễ truyền thống gồm nhiều bước như dạm ngõ, ăn hỏi, lễ cưới và nghi lễ gia tiên.',
 N'Traditional ceremony with multiple stages: proposal, betrothal, wedding, and ancestral rituals.',
 N'Toàn quốc', N'Theo dịp cưới'),

(N'Hò Huế', N'Hue Chanty', N'art',
 N'Loại hình dân ca trữ tình của vùng đất cố đô, thường hát trên sông Hương.',
 N'A lyrical folk song genre of the former imperial capital, usually performed on the Perfume River.',
 N'Thừa Thiên Huế', N'Quanh năm'),

(N'Tục thờ cúng tổ tiên', N'Ancestral Worship', N'custom',
 N'Phong tục truyền thống thể hiện lòng hiếu kính và sự gắn bó với cội nguồn.',
 N'Traditional custom showing filial piety and connection to ancestors.',
 N'Toàn quốc', N'Quanh năm');

-- Insert dữ liệu mẫu cho Cuisine
INSERT INTO Cuisine (dish_name_vi, dish_name_en, type, description_vi, description_en, ingredients_vi, ingredients_en, origin_location, price_range)
VALUES
(N'Phở', N'Pho', N'main_dish',
 N'Món ăn quốc hồn của Việt Nam với nước dùng trong vắt, bánh phở dai ngon và thịt bò hoặc gà.',
 N'Vietnam''s national dish featuring clear broth, chewy rice noodles and beef or chicken.',
 N'Bánh phở, thịt bò/gà, hành, ngò', N'Rice noodles, beef/chicken, onions, cilantro',
 N'Hà Nội', N'30,000 - 80,000 VND'),

(N'Bánh mì', N'Vietnamese Sandwich', N'street_food',
 N'Bánh mì giòn với nhân thịt, pate, rau chua và gia vị đặc trưng.',
 N'Crispy baguette with meat, pate, pickled vegetables and special seasonings.',
 N'Bánh mì, thịt, pate, rau chua, gia vị', N'Baguette, meat, pate, pickled vegetables, seasonings',
 N'Sài Gòn', N'15,000 - 40,000 VND'),

(N'Chả cá Lã Vọng', N'Cha Ca La Vong', N'specialty',
 N'Món cá nướng với nghệ, thì là ăn kèm bún và rau thơm, đặc sản nổi tiếng của Hà Nội.',
 N'Grilled fish with turmeric and dill, served with rice noodles and herbs, famous Hanoi specialty.',
 N'Cá, nghệ, thì là, bún, rau thơm', N'Fish, turmeric, dill, rice noodles, herbs',
 N'Hà Nội', N'150,000 - 300,000 VND'),

(N'Bún chả', N'Grilled Pork with Vermicelli', N'main_dish',
 N'Món ăn đặc trưng của Hà Nội gồm thịt nướng, bún tươi và nước mắm chua ngọt.',
 N'Hanoi specialty with grilled pork, rice vermicelli and sweet-savory fish sauce.',
 N'Bún, thịt heo nướng, nước mắm, rau sống', N'Vermicelli, grilled pork, fish sauce, herbs',
 N'Hà Nội', N'40,000 - 60,000 VND'),

(N'Gỏi cuốn', N'Fresh Spring Rolls', N'snack',
 N'Món cuốn thanh mát với tôm, thịt, bún và rau sống chấm mắm nêm hoặc nước chấm chua ngọt.',
 N'Fresh rolls with shrimp, pork, vermicelli, herbs and dipping sauce.',
 N'Bánh tráng, tôm, thịt, bún, rau', N'Rice paper, shrimp, pork, noodles, herbs',
 N'Nam Bộ', N'10,000 - 20,000 VND'),

(N'Bánh xèo', N'Vietnamese Pancake', N'street_food',
 N'Bánh giòn rụm cuốn với rau sống và nước mắm pha chua ngọt.',
 N'Crispy pancake filled with shrimp, pork, bean sprouts, served with herbs and dipping sauce.',
 N'Bột gạo, tôm, thịt, giá đỗ, rau sống', N'Rice flour, shrimp, pork, bean sprouts, herbs',
 N'Miền Trung', N'25,000 - 50,000 VND'),

(N'Cao lầu', N'Cao Lau Noodles', N'main_dish',
 N'Đặc sản Hội An với sợi mì đặc trưng, thịt xá xíu và rau sống. ',
 N'Hoi An specialty noodle dish with chewy noodles, roasted pork, and fresh herbs.',
 N'Mì cao lầu, thịt xá xíu, rau sống, nước sốt', N'Cao Lau noodles, pork, herbs, sauce',
 N'Hội An', N'35,000 - 60,000 VND'),

(N'Bún bò Huế', N'Hue Spicy Beef Noodle Soup', N'main_dish',
 N'Món bún cay nồng với nước dùng đậm đà và thịt bò, giò heo.',
 N'Spicy beef noodle soup with flavorful broth, beef and pork leg.',
 N'Bún, thịt bò, giò heo, sả, mắm ruốc', N'Vermicelli, beef, pork leg, lemongrass, fermented shrimp paste',
 N'Huế', N'40,000 - 70,000 VND'),

(N'Chả giò', N'Fried Spring Rolls', N'snack',
 N'Món chiên giòn với nhân thịt và rau củ, thường ăn kèm bún hoặc cơm.',
 N'Crispy fried rolls with meat and vegetable filling, often served with noodles or rice.',
 N'Bánh tráng, thịt băm, mộc nhĩ, miến', N'Rice paper, minced pork, wood ear mushrooms, vermicelli',
 N'Toàn quốc', N'8,000 - 15,000 VND/cái'),

(N'Bánh cuốn', N'Steamed Rice Rolls', N'street_food',
 N'Món ăn sáng phổ biến với bánh mỏng nhân thịt, ăn kèm chả và nước mắm.',
 N'Popular breakfast dish with thin rice sheets filled with minced pork, served with ham and fish sauce.',
 N'Bột gạo, thịt băm, hành phi, chả lụa', N'Rice batter, minced pork, fried shallots, Vietnamese ham',
 N'Hà Nội', N'20,000 - 40,000 VND'),

(N'Cơm tấm', N'Broken Rice with Grilled Pork', N'main_dish',
 N'Món cơm đặc sản Sài Gòn với sườn nướng, bì, trứng và mắm chua ngọt.',
 N'Saigon specialty with grilled pork chop, shredded pork skin, egg and sweet fish sauce.',
 N'Cơm tấm, sườn nướng, trứng, đồ chua', N'Broken rice, grilled pork, egg, pickles',
 N'Sài Gòn', N'35,000 - 60,000 VND'),

(N'Hủ tiếu', N'Clear Rice Noodle Soup', N'main_dish',
 N'Món nước miền Nam với sợi hủ tiếu dai và nước dùng ngọt thanh.',
 N'Southern noodle soup with chewy noodles and clear, sweet broth.',
 N'Hủ tiếu, thịt heo, tôm, hành lá', N'Clear noodles, pork, shrimp, scallions',
 N'Miền Nam', N'30,000 - 50,000 VND'),

(N'Bánh bèo', N'Savory Rice Cake', N'snack',
 N'Món ăn vặt Huế với bánh nhỏ, tôm cháy và hành phi, chan nước mắm mặn ngọt.',
 N'Hue snack with small rice cakes, dried shrimp, crispy shallots, and savory fish sauce.',
 N'Bột gạo, tôm, mỡ hành, hành phi', N'Rice flour, shrimp, scallion oil, fried shallots',
 N'Huế', N'10,000 - 20,000 VND'),

(N'Chè ba màu', N'Three-color Dessert', N'dessert',
 N'Món chè mát lạnh với đậu, thạch và nước cốt dừa.',
 N'Chilled dessert with beans, jelly, and coconut milk.',
 N'Đậu đỏ, đậu xanh, thạch, nước cốt dừa', N'Red beans, mung beans, jelly, coconut milk',
 N'Toàn quốc', N'10,000 - 25,000 VND'),

(N'Bánh khọt', N'Mini Savory Pancakes', N'street_food',
 N'Món bánh nhỏ giòn rụm với tôm và nước mắm chua ngọt.',
 N'Crunchy mini pancakes with shrimp and sweet fish sauce.',
 N'Bột gạo, tôm, mỡ hành, nước mắm', N'Rice flour, shrimp, scallion oil, fish sauce',
 N'Vũng Tàu', N'20,000 - 40,000 VND'),

(N'Mì Quảng', N'Quang-style Noodles', N'main_dish',
 N'Món mì đặc trưng Quảng Nam với nước dùng ít, ăn kèm rau sống và bánh tráng.',
 N'Quang Nam-style noodles with light broth, herbs, and sesame rice cracker.',
 N'Mì Quảng, thịt, tôm, trứng, rau sống', N'Quang noodles, meat, shrimp, egg, herbs',
 N'Quảng Nam', N'30,000 - 50,000 VND'),

(N'Nem nướng', N'Grilled Pork Sausage', N'street_food',
 N'Nem nướng thơm ngon ăn kèm bánh tráng, rau sống và nước chấm đặc biệt.',
 N'Grilled pork sausages served with rice paper, fresh herbs, and dipping sauce.',
 N'Nem, bánh tráng, rau sống, đồ chua', N'Grilled pork, rice paper, herbs, pickles',
 N'Nha Trang', N'25,000 - 50,000 VND'),

(N'Bánh da lợn', N'Steamed Layer Cake', N'dessert',
 N'Món bánh ngọt nhiều lớp mềm mịn, làm từ bột năng, lá dứa và nước cốt dừa.',
 N'Soft, sweet layered cake made from tapioca flour, pandan and coconut milk.',
 N'Bột năng, lá dứa, nước cốt dừa, đậu xanh', N'Tapioca flour, pandan, coconut milk, mung beans',
 N'Nam Bộ', N'5,000 - 15,000 VND');

 -- Insert dữ liệu mẫu cho Activities
INSERT INTO Activities (activity_name_vi, activity_name_en, destination_id, type, description_vi, description_en, duration, difficulty_level, price_range)
VALUES
-- Vịnh Hạ Long (destination_id = 1)
(N'Du thuyền ngắm cảnh', N'Scenic Cruise', 1, N'relaxation',
 N'Du ngoạn trên vịnh với thuyền để ngắm các đảo đá vôi và hang động tự nhiên.',
 N'Cruise around the bay to admire limestone islands and natural caves.',
 N'4-6 giờ', N'Easy', N'500,000 - 1,500,000 VND'),

(N'Thăm hang Sửng Sốt', N'Visit Sung Sot Cave', 1, N'adventure',
 N'Khám phá hang động lớn nhất Vịnh Hạ Long với nhũ đá kỳ thú.',
 N'Explore the largest cave in Ha Long Bay with amazing stalactites.',
 N'1-2 giờ', N'Moderate', N'200,000 VND'),

(N'Chèo kayak', N'Kayaking', 1, N'adventure',
 N'Chèo kayak qua các hang động và vịnh nhỏ để khám phá thiên nhiên gần gũi.',
 N'Paddle through caves and small bays for close nature exploration.',
 N'2-3 giờ', N'Moderate', N'300,000 - 500,000 VND'),

-- Hội An (destination_id = 2)
(N'Đi bộ phố cổ', N'Walking Tour', 2, N'cultural',
 N'Dạo bộ qua các con phố cổ kính, thăm hội quán và nhà cổ truyền thống.',
 N'Stroll through ancient streets, visit assembly halls and traditional houses.',
 N'2-3 giờ', N'Easy', N'100,000 - 200,000 VND'),

(N'Làm đèn lồng', N'Lantern Making', 2, N'cultural',
 N'Học cách làm đèn lồng truyền thống Hội An với nghệ nhân địa phương.',
 N'Learn to make traditional Hoi An lanterns with local artisans.',
 N'1-2 giờ', N'Easy', N'150,000 - 300,000 VND'),

(N'Tour xe đạp nông thôn', N'Countryside Bicycle Tour', 2, N'adventure',
 N'Đạp xe qua những cánh đồng lúa và làng quê xung quanh Hội An.',
 N'Cycle through rice fields and villages surrounding Hoi An.',
 N'3-4 giờ', N'Moderate', N'200,000 - 400,000 VND'),

-- Sapa (destination_id = 3)
(N'Trekking ruộng bậc thang', N'Terraced Fields Trekking', 3, N'adventure',
 N'Đi bộ khám phá những ruộng bậc thang đẹp như tranh và làng bản dân tộc.',
 N'Trek through stunning terraced rice fields and ethnic villages.',
 N'4-8 giờ', N'Hard', N'300,000 - 800,000 VND'),

(N'Chinh phục đỉnh Fansipan', N'Fansipan Summit', 3, N'adventure',
 N'Leo núi lên đỉnh cao nhất Đông Dương qua cáp treo hoặc trekking.',
 N'Climb to the highest peak in Indochina via cable car or trekking.',
 N'6-12 giờ', N'Hard', N'700,000 - 2,000,000 VND'),

(N'Thăm chợ Sapa', N'Sapa Market Visit', 3, N'cultural',
 N'Khám phá chợ địa phương với đặc sản vùng cao và thổ cẩm dân tộc.',
 N'Explore local market with highland specialties and ethnic textiles.',
 N'2-3 giờ', N'Easy', N'50,000 - 150,000 VND'),

 -- Đà Lạt (destination_id = 4)
(N'Thăm vườn hoa thành phố', N'Visit Dalat Flower Garden', 4, N'relaxation',
 N'Tản bộ giữa muôn vàn loài hoa khoe sắc tại vườn hoa trung tâm thành phố.',
 N'Stroll through countless blooming flowers at the central city garden.',
 N'1-2 giờ', N'Easy', N'40,000 VND'),

(N'Đạp xe quanh hồ Xuân Hương', N'Cycling around Xuan Huong Lake', 4, N'leisure',
 N'Tận hưởng không khí trong lành khi đạp xe dọc theo hồ nổi tiếng của Đà Lạt.',
 N'Enjoy the fresh air while biking along Da Lat’s iconic lake.',
 N'1-2 giờ', N'Easy', N'50,000 - 100,000 VND'),

-- Bà Nà Hills (destination_id = 5)
(N'Trải nghiệm Cầu Vàng', N'Walk on the Golden Bridge', 5, N'sightseeing',
 N'Chiêm ngưỡng kiến trúc độc đáo và khung cảnh ngoạn mục từ Cầu Vàng.',
 N'Admire the unique architecture and stunning views from the Golden Bridge.',
 N'30-60 phút', N'Easy', N'Đã bao gồm trong vé vào cổng'),

(N'Thăm làng Pháp', N'Visit French Village', 5, N'cultural',
 N'Khám phá kiến trúc châu Âu cổ điển giữa núi rừng Bà Nà.',
 N'Explore classic European-style architecture in Ba Na Hills.',
 N'1-2 giờ', N'Easy', N'Đã bao gồm trong vé vào cổng'),

-- Côn Đảo (destination_id = 6)
(N'Thăm nhà tù Côn Đảo', N'Visit Con Dao Prison', 6, N'historical',
 N'Tìm hiểu về lịch sử đau thương và tinh thần kiên cường của tù nhân chính trị Việt Nam.',
 N'Learn about the tragic history and resilience of Vietnamese political prisoners.',
 N'1-2 giờ', N'Easy', N'Miễn phí'),

(N'Lặn ngắm san hô', N'Snorkeling', 6, N'adventure',
 N'Trải nghiệm thế giới đại dương tuyệt đẹp với san hô và sinh vật biển phong phú.',
 N'Explore the beautiful underwater world with coral reefs and marine life.',
 N'2-3 giờ', N'Moderate', N'500,000 - 800,000 VND'),

-- Chùa Một Cột (destination_id = 7)
(N'Vãn cảnh chùa và chụp ảnh', N'Sightseeing and Photography', 7, N'relaxation',
 N'Thăm quan công trình kiến trúc độc đáo và chụp hình lưu niệm.',
 N'Visit this unique architectural site and take memorable photos.',
 N'30 phút', N'Easy', N'Miễn phí'),

-- Mũi Né (destination_id = 8)
(N'Trượt cát đồi cát bay', N'Sand Dune Sliding', 8, N'adventure',
 N'Trải nghiệm trượt cát thú vị trên đồi cát đỏ nổi tiếng.',
 N'Enjoy the thrilling activity of sliding down the famous red sand dunes.',
 N'1 giờ', N'Moderate', N'10,000 - 30,000 VND'),

(N'Thăm làng chài Mũi Né', N'Visit Mui Ne Fishing Village', 8, N'cultural',
 N'Khám phá cuộc sống ngư dân và thưởng thức hải sản tươi sống.',
 N'Discover the life of fishermen and enjoy fresh seafood.',
 N'1-2 giờ', N'Easy', N'Miễn phí'),

-- Vườn quốc gia Phong Nha - Kẻ Bàng (destination_id = 9)
(N'Thám hiểm hang Sơn Đoòng', N'Explore Son Doong Cave', 9, N'adventure',
 N'Hành trình khám phá hang động lớn nhất thế giới, chỉ dành cho người có thể lực tốt.',
 N'Journey to explore the world’s largest cave, for those with strong physical fitness.',
 N'4-5 ngày', N'Hard', N'65,000,000 VND'),

(N'Thăm động Phong Nha', N'Visit Phong Nha Cave', 9, N'nature',
 N'Du thuyền trên sông Son và chiêm ngưỡng vẻ đẹp kỳ ảo của hang động. ',
 N'Take a boat ride on the Son River and marvel at the mystical cave formations.',
 N'2-3 giờ', N'Moderate', N'150,000 - 250,000 VND'),

-- Cố đô Huế (destination_id = 10)
(N'Thăm Đại Nội Huế', N'Visit Hue Imperial City', 10, N'historical',
 N'Khám phá quần thể di tích cung đình triều Nguyễn với lăng tẩm, đền đài và thành quách.',
 N'Explore the Nguyen Dynasty’s royal complex with tombs, temples and palaces.',
 N'2-3 giờ', N'Moderate', N'150,000 VND'),

(N'Nghe ca Huế trên sông Hương', N'Hue Traditional Music on Perfume River', 10, N'cultural',
 N'Thưởng thức âm nhạc truyền thống Huế trên thuyền rồng vào buổi tối.',
 N'Enjoy traditional Hue music performed on a dragon boat at night.',
 N'1-2 giờ', N'Easy', N'100,000 - 200,000 VND'),

-- Nhà thờ Đức Bà Sài Gòn (destination_id = 11)
(N'Thăm quan kiến trúc nhà thờ', N'Explore Cathedral Architecture', 11, N'cultural',
 N'Chiêm ngưỡng công trình kiến trúc Pháp đặc sắc giữa trung tâm thành phố.',
 N'Admire the iconic French colonial architecture in the city center.',
 N'30 phút - 1 giờ', N'Easy', N'Miễn phí'),

-- Đảo Phú Quốc (destination_id = 12)
(N'Thăm cơ sở sản xuất nước mắm', N'Visit Fish Sauce Factory', 12, N'cultural',
 N'Tìm hiểu quy trình sản xuất nước mắm truyền thống đặc sản Phú Quốc.',
 N'Learn about the traditional process of making Phu Quoc’s famous fish sauce.',
 N'1 giờ', N'Easy', N'Miễn phí'),

(N'Tắm biển và lặn ngắm san hô', N'Swimming and Snorkeling', 12, N'nature',
 N'Tận hưởng làn nước trong xanh và khám phá rạn san hô gần bờ.',
 N'Enjoy the clear waters and discover coral reefs near the shore.',
 N'2-3 giờ', N'Moderate', N'300,000 - 600,000 VND'),

-- Hồ Ba Bể (destination_id = 13)
(N'Du thuyền trên hồ', N'Boat Tour on Ba Be Lake', 13, N'nature',
 N'Du ngoạn trên mặt hồ yên bình, ngắm cảnh núi rừng hùng vĩ.',
 N'Boat through the calm lake surrounded by majestic forests and mountains.',
 N'2-3 giờ', N'Easy', N'100,000 - 200,000 VND'),

(N'Trekking trong rừng nguyên sinh', N'Jungle Trekking', 13, N'adventure',
 N'Khám phá thiên nhiên hoang sơ và hệ động thực vật phong phú trong vườn quốc gia.',
 N'Explore the untouched nature and diverse wildlife in the national park.',
 N'3-5 giờ', N'Moderate', N'200,000 - 400,000 VND');

 -- Một số khách sạn / nhà nghỉ
INSERT INTO Hotels (name_vi, name_en, location, description_vi, description_en, category, star_rating, price_range, amenities)
VALUES 
(N'JW Marriott Hotel Hà Nội', N'JW Marriott Hotel Hanoi', N'8 Đỗ Đức Dục, Hà Nội', 
 N'Khách sạn 5 sao sang trọng bậc nhất Hà Nội, thiết kế hiện đại và dịch vụ cao cấp.', 
 'Luxury 5-star hotel in Hanoi with modern design and premium services.', N'Hotel', 5,
 N'3,000,000 - 7,000,000 VND / đêm', N'Free WiFi, Pool, Spa, Gym'),

(N'Khách sạn Mường Thanh Luxury Hạ Long', N'Muong Thanh Luxury Ha Long Hotel', N'Trần Hưng Đạo, Bãi Cháy, Hạ Long, Quảng Ninh', 
 N'Khách sạn 4 sao với view vịnh Hạ Long tuyệt đẹp, dịch vụ tốt.', 
 '4-star hotel offering stunning views of Ha Long Bay with good services.', N'Hotel', 4,
 N'1,200,000 - 3,000,000 VND / đêm', N'Free WiFi, Pool, Breakfast'),

(N'Sapa Cozy Homestay', N'Sapa Cozy Homestay', N'Tả Van, Sa Pa, Lào Cai', 
 N'Homestay ấm cúng nằm giữa bản làng, phù hợp cho trải nghiệm văn hóa địa phương.', 
 'Cozy homestay in Ta Van village, perfect for local cultural experience.', N'Homestay', 3,
 N'300,000 - 800,000 VND / đêm', N'Free WiFi, Local Meals, Mountain View'),

(N'Hội An Memories Resort & Spa', N'Hoi An Memories Resort & Spa', N'200 Nguyễn Tri Phương, Phường Cẩm Nam, Hội An, Quảng Nam', 
 N'Resort cao cấp nằm bên sông Hoài, cách Phố cổ Hội An vài phút đi bộ, hồ bơi đẹp và view sông.', 
 'Luxury resort by Hoai River, just a few minutes walk from Hoi An Ancient Town, beautiful pool and river view.', N'Resort', 5, 
 N'2,000,000 - 4,500,000 VND / đêm', N'Free WiFi, Pool, Spa, Restaurant'),

(N'Kiman Old Town Hotel', N'Kiman Old Town Hotel', N'626 Hai Bà Trưng, Sơn Phong, Hội An, Quảng Nam', 
 N'Khách sạn bình dân gần Phố cổ Hội An, phòng sạch sẽ và tiện nghi cơ bản.', 
 'Budget hotel near Hoi An Ancient Town, clean rooms with basic amenities.', N'Hotel', 2, 
 N'300,000 - 800,000 VND / đêm', N'Free WiFi, Air Conditioning, Breakfast'),

(N'Huy Hoang River Hotel', N'Huy Hoang River Hotel', N'73 Phan Bội Châu, Sơn Phong, Hội An, Quảng Nam', 
 N'Khách sạn ấm cúng bên sông, view đẹp, thuận tiện đi dạo trong khu phố cổ.', 
 'Cozy riverside hotel with nice views, convenient for walking around Old Town.', N'Hotel', 3, 
 N'600,000 - 1,200,000 VND / đêm', N'Free WiFi, River View, Restaurant'),

(N'Hotel De La Coupole Sapa, MGallery by Sofitel', N'De La Coupole Sapa, MGallery by Sofitel', N'Sapa, Lào Cai', 
 N'Khách sạn 5 sao đẳng cấp giữa núi rừng Sapa với kiến trúc sang trọng và dịch vụ cao cấp.', 
 '5‑star luxury hotel in the mountains of Sapa with high‑end architecture and premium service.', N'Hotel', 5, 
 N'3,000,000 - 6,000,000 VND / đêm', N'Spa, Free WiFi, Restaurant, Mountain View'),

(N'Bamboo Sapa Hotel', N'Bamboo Sapa Hotel', N'18 Đường Mường Hoa, Sapa, Lào Cai', 
 N'Khách sạn 4 sao với view thung lũng Hoàng Liên Sơn, hồ bơi vô cực và không gian sang trọng.', 
 '4‑star hotel with views of the Hoang Lien Son valley, infinity pool and elegant ambiance.', N'Hotel', 4, 
 N'1,500,000 - 3,500,000 VND / đêm', N'Free WiFi, Pool, Spa, Breakfast'),

(N'Dalat Palace Hotel', N'Dalat Palace Hotel', N'2 Trần Phú, Phường 3, Đà Lạt, Lâm Đồng', 
 N'Khách sạn lịch sử cao cấp nằm ngay bên hồ Xuân Hương, thiết kế cổ điển, dịch vụ sang trọng.', 
 'Historic luxury hotel right by Xuan Huong Lake, classic architecture and premium service.', N'Hotel', 5, 
 N'3,000,000 - 7,000,000 VND / đêm', N'Free WiFi, Spa, Restaurant, Lake View'),

(N'Bình An Village Dalat', N'Binh An Village Dalat Resort', N'Hồ Tuyền Lâm, Đà Lạt, Lâm Đồng', 
 N'Resort yên bình ven hồ Tuyền Lâm, phù hợp cho nghỉ dưỡng, gần thiên nhiên.', 
 'Peaceful lakeside resort by Tuyen Lam Lake, ideal for relaxation and close to nature.', N'Resort', 4, 
 N'2,500,000 - 4,500,000 VND / đêm', N'Free WiFi, Pool, Nature View, Restaurant'),

(N'Vinpearl Resort & Spa Phú Quốc', N'Vinpearl Resort & Spa Phu Quoc', N'Bãi Dài, Gành Dầu, Phú Quốc', 
 N'Khu nghỉ dưỡng 5 sao cao cấp với bãi biển riêng, hồ bơi lớn và spa chuyên nghiệp.', 
 'Premium 5-star beachfront resort with private beach, large pool, and professional spa.', 
 N'Resort', 5, N'3,000,000 - 7,000,000 VND / đêm', N'Free WiFi, Private Beach, Spa, Pool, Gym'),

(N'La Veranda Resort Phú Quốc - MGallery', N'La Veranda Resort Phu Quoc - MGallery', N'Trần Hưng Đạo, Dương Đông, Phú Quốc', 
 N'Khu nghỉ dưỡng mang phong cách kiến trúc Pháp cổ điển, không gian yên tĩnh và sang trọng.', 
 'Colonial-style resort with a peaceful and elegant atmosphere.', 
 N'Resort', 5, N'3,500,000 - 8,000,000 VND / đêm', N'Free WiFi, Beach Access, Spa, Pool, Airport Shuttle'),

(N'Khách sạn Lahana Phú Quốc', N'Lahana Phu Quoc Hotel', N'91/3 Trần Hưng Đạo, Dương Đông, Phú Quốc', 
 N'Khách sạn 3 sao xanh mát giữa thiên nhiên, có hồ bơi vô cực và nhà hàng.', 
 'Eco-friendly 3-star hotel surrounded by nature, featuring an infinity pool and restaurant.', 
 N'Hotel', 3, N'900,000 - 2,000,000 VND / đêm', N'Free WiFi, Infinity Pool, Restaurant, Garden View'),

(N'Khách sạn Imperial Vũng Tàu', N'The Imperial Hotel Vung Tau', N'159 Thùy Vân, Vũng Tàu', 
 N'Khách sạn 5 sao sang trọng với kiến trúc cổ điển châu Âu, sát biển.', 
 'Luxurious 5-star hotel with classic European architecture, beachfront location.', N'Hotel', 5,
 N'2,500,000 - 6,000,000 VND / đêm', N'Free WiFi, Pool, Beach Access, Spa, Gym'),

(N'Khách sạn Marina Bay Vũng Tàu', N'Marina Bay Vung Tau Resort & Spa', N'115 Trần Phú, Vũng Tàu', 
 N'Khu nghỉ dưỡng 5 sao với hồ bơi vô cực, view biển tuyệt đẹp.', 
 '5-star resort with infinity pool and stunning sea views.', N'Resort', 5,
 N'2,000,000 - 5,500,000 VND / đêm', N'Free WiFi, Infinity Pool, Spa, Sea View'),

(N'Nhà nghỉ Biển Xanh Vũng Tàu', N'Bien Xanh Guesthouse Vung Tau', N'45 Phan Chu Trinh, Vũng Tàu', 
 N'Nhà nghỉ bình dân, gần biển, phù hợp với nhóm bạn hoặc gia đình.', 
 'Budget guesthouse near the beach, suitable for groups or families.', N'Guesthouse', 2,
 N'300,000 - 700,000 VND / đêm', N'Free WiFi, Parking');

 SELECT * 
FROM Hotels
WHERE location COLLATE SQL_Latin1_General_CP1_CI_AI LIKE N'%vung tau%'
 -- Một số quán ăn / nhà hàng
INSERT INTO Restaurants (name_vi, name_en, location, description_vi, description_en, cuisine_type, price_range, rating, opening_hours)
VALUES 
(N'Phở Thìn', N'Pho Thin', N'13 Lò Đúc, Hà Nội', N'Phở bò truyền thống nổi tiếng với nước dùng đậm đà và hương vị đặc trưng.', 
 'Traditional beef pho with rich broth and authentic flavor.', N'Vietnamese', N'40,000 - 70,000 VND', 4.7, N'6:00 - 22:00'),

(N'Bún Chả Hương Liên', N'Huong Lien Bun Cha', N'24 Lê Văn Hưu, Hà Nội', N'Nổi tiếng khi Tổng thống Mỹ Obama từng ghé ăn, phục vụ bún chả truyền thống Hà Nội.', 
 'Famous for being visited by President Obama, serving authentic Hanoi grilled pork with noodles.', N'Vietnamese', N'50,000 - 100,000 VND', 4.6, N'10:00 - 21:00'),

(N'Hải Sản Ngon', N'Delicious Seafood', N'Đường Trần Phú, Hạ Long, Quảng Ninh', N'Nhà hàng chuyên hải sản tươi sống tại Hạ Long, giá cả hợp lý.', 
 'Seafood restaurant in Ha Long, specializing in fresh and affordable dishes.', N'Seafood', N'150,000 - 500,000 VND', 4.5, N'9:00 - 23:00'),

(N'Chả Cá Lã Vọng', N'Cha Ca La Vong', N'6B Đường Thành, Hoàn Kiếm, Hà Nội',
 N'Món chả cá Hà Nội truyền thống, cá nấu vừa tới, ăn kèm bún và ngò thơm.', 
 'Traditional Hanoi cha-ca dish, grilled fish with vermicelli and fresh herbs.', N'Vietnamese', N'200,000 - 350,000 VND', 4.5, N'10:00 - 22:00'),

(N'Green Tangerine', N'Green Tangerine Restaurant', N'Hàng Bè, Hoàn Kiếm, Hà Nội',
 N'Nhà hàng Pháp – Việt trong toà nhà cổ, không gian lãng mạn.', 
 'French‑Vietnamese restaurant in a colonial building, romantic atmosphere.', N'Fusion / French', N'300,000 - 700,000 VND', 4.6, N'11:00 - 23:00'),

(N'Hanoi Garden', N'Hanoi Garden Restaurant', N'Phố cổ Hà Nội', 
 N'Ẩm thực Việt với biến tấu hiện đại, không gian thoáng mát.', 
 'Vietnamese cuisine with modern twists, airy and relaxed space.', N'Vietnamese', N'150,000 - 400,000 VND', 4.4, N'09:00 - 22:30'),

(N'Com Nieu Saigon', N'Com Nieu Saigon', N'TP. Hồ Chí Minh', 
 N'Nhà hàng cơm niêu nổi tiếng, không gian truyền thống.', 
 'Famous clay pot rice restaurant with traditional ambiance.', N'Vietnamese', N'100,000 - 300,000 VND', 4.5, N'10:00 - 22:00'),

(N'Phở Minh', N'Pho Minh', N'63/6 Pasteur, Quận 1, Hồ Chí Minh', 
 N'Phở truyền thống lâu đời, nổi bật trong danh sách Michelin 2025.', 
 'Traditional pho with long history, honored in the 2025 Michelin list.', N'Vietnamese', N'60,000 - 120,000 VND', 4.7, N'06:00 - 10:00'),

(N'Nhà hàng Phương Nam', N'Phuong Nam Restaurant', N'Hà Nội', 
 N'Chuyên các món Nam Bộ, không gian thoáng và đẹp.', 
 'Specializes in Southern Vietnamese dishes, spacious and elegant.', N'Vietnamese (Southern)', N'120,000 - 350,000 VND', 4.3, N'08:30 - 22:00'),

(N'Bún Chả Hương Liên', N'Huong Lien Bun Cha', N'24 Lê Văn Hưu, Hà Nội', 
 N'Bún chả Hà Nội truyền thống, nổi tiếng vì Tổng thống Obama từng đến.', 
 'Authentic Hanoi bun cha, famous for being visited by President Obama.', N'Vietnamese', N'50,000 - 100,000 VND', 4.6, N'10:00 - 21:00'),

(N'Phở Thìn', N'Pho Thin', N'13 Lò Đúc, Hà Nội', 
 N'Phở bò truyền thống nổi tiếng với nước dùng đậm đà và hương vị đặc trưng.', 
 'Traditional beef pho with rich broth and authentic flavor.', N'Vietnamese', N'40,000 - 70,000 VND', 4.7, N'06:00 - 22:00'),

(N'Cơm Niêu Sài Gòn – chi nhánh 1', N'Com Nieu Saigon Branch 1', N'Quận 1, Hồ Chí Minh', 
 N'Chi nhánh nổi tiếng của Cơm Niêu Sài Gòn, phục vụ món ăn truyền thống.', 
 'Branch of the famous Com Nieu Saigon, serving traditional Vietnamese dishes.', N'Vietnamese', N'120,000 - 280,000 VND', 4.4, N'11:00 - 22:00'),

(N'Nhà hàng Tầm Vị', N'Tam Vi Restaurant', N'Hà Nội', 
 N'Nhà hàng Việt cao cấp, được đánh giá Michelin, không gian sang trọng.', 
 'High-end Vietnamese restaurant, Michelin-rated, elegant space.', N'Vietnamese (Fine Dining)', N'400,000 - 1,200,000 VND', 4.8, N'12:00 - 14:00, 18:00 - 22:00'),

(N'Dalat House Restaurant', N'Dalat House Restaurant', N'34 Nguyễn Du, P.9, Đà Lạt, Lâm Đồng',
 N'Nhà hàng thoáng mát, phục vụ món nướng, lẩu và hải sản với thực đơn đa dạng.', 
 'Spacious restaurant serving grilled dishes, hotpots and seafood with a varied menu.', N'Vietnamese / Fusion', N'50,000 - 300,000 VND', 4.3, N'07:00 - 22:00'),

(N'Chefs Dalat', N'Chefs Dalat – Farm to Table', N'156 Phạm Ngọc Thạch, P.6, Đà Lạt, Lâm Đồng',
 N'Nhà hàng Âu cao cấp với thực đơn farm‑to‑table, không gian ấm cúng và view đẹp.', 
 'High‑end European restaurant with farm‑to‑table menu, cozy ambiance and lovely views.', N'European / Fine Dining', N'400,000 - 1,200,000 VND', 4.7, N'08:00 - 22:00'),

(N'Tiệm Ăn Đà Lạt Phố', N'Dalat Street Restaurant', N'38 Tăng Bạt Hổ, P.1, Đà Lạt, Lâm Đồng',
 N'Nhà hàng ngay phố đêm Đà Lạt, món Việt truyền thống, không gian 2 tầng ấm cúng.', 
 'Restaurant on Dalat Night Street, serving traditional Vietnamese food, cozy 2‑floor space.', N'Vietnamese', N'60,000 - 200,000 VND', 4.4, N'07:30 - 20:30'),

(N'Alley Artist Restaurant', N'Alley Artist Restaurant', N'70 Trương Công Định, Đà Lạt, Lâm Đồng',
 N'Nhà hàng nhỏ, món ăn giá mềm, phù hợp khách tham quan lần đầu.', 
 'Small restaurant, affordable dishes, good choice for first‑time visitors.', N'Vietnamese', N'50,000 - 150,000 VND', 4.2, N'10:00 - 21:00'),

(N'La Sirena Seafood Restaurant', N'La Sirena Seafood Restaurant', N'8 Thùy Vân, P. Thắng Tam, Vũng Tàu, Bà Rịa ‑ Vũng Tàu',
 N'Nhà hàng hải sản sang trọng ven biển, thực đơn đa dạng và view đẹp.', 
 'Stylish seaside seafood restaurant with diverse menu and great ocean view.', N'Seafood / Fine Dining', N'100,000 - 300,000 VND', 4.3, N'07:00 - 22:00'),

(N'Nhà hàng Gành Hào 1', N'Ganh Hao 1 Restaurant', N'03 Trần Phú, P.5, Vũng Tàu, Bà Rịa ‑ Vũng Tàu',
 N'Nhà hàng hải sản nổi tiếng, không gian gần biển, phục vụ nhiều món tươi ngon.', 
 'Famous seafood restaurant near the sea, serving many fresh dishes.', N'Seafood / Vietnamese', N'100,000 - 500,000 VND', 4.5, N'10:30 - 21:30'),

(N'Nhà hàng Vạn Chài', N'Van Chai Restaurant', N'03 Trần Phú, P.5, Vũng Tàu, Bà Rịa ‑ Vũng Tàu',
 N'Không gian mộc mạc, phục vụ hải sản tươi và các món Việt truyền thống.', 
 'Rustic space, serving fresh seafood and traditional Vietnamese dishes.', N'Seafood / Vietnamese', N'80,000 - 300,000 VND', 4.4, N'10:00 - 21:30'),

(N'Nhà hàng Hải sản Lâm Đường', N'Lam Duong Seafood Restaurant', N'125B Trần Phú, P.5, Vũng Tàu, Bà Rịa ‑ Vũng Tàu',
 N'Nhà hàng lớn, sức chứa cao, phục vụ đa dạng hải sản theo kiểu buffet và gọi món.', 
 'Large restaurant with high capacity, serving a wide variety of seafood buffet & à la carte.', N'Seafood / Vietnamese', N'40,000 - 300,000 VND', 4.2, N'09:00 - 23:00'),

(N'Nhà hàng Quách', N'Quach Seafood Restaurant', N'187 Võ Thị Sáu, P. Thắng Tam, Vũng Tàu, Bà Rịa ‑ Vũng Tàu',
 N'Nhà hàng chuyên hải sản tươi sống, món Âu và món Việt, phục vụ cả sáng và tối.', 
 'Seafood restaurant specializing in fresh seafood, European and Vietnamese dishes, open for breakfast & dinner.', N'Seafood / Fusion', N'50,000 - 500,000 VND', 4.6, N'07:00 - 22:00'),
 
(N'Cơm Bắc 123', N'Com Bac 123', N'77 Trần Hưng Đạo, Phú Quốc', 
 N'Quán cơm truyền thống miền Bắc, nổi bật với các món ăn gia đình đậm đà.', N'Northern Vietnamese restaurant serving hearty family-style meals.', 
 N'Vietnamese', N'60,000 - 120,000 VND', 4.5, N'10:00 - 21:00'),

(N'Nhà Hàng Ra Khơi', N'Ra Khoi Restaurant', N'131 đường 30/4, Phú Quốc', 
 N'Nhà hàng hải sản nổi tiếng với món gỏi cá trích và các món hải sản tươi sống.', N'Famous seafood restaurant known for herring salad and fresh local seafood.', 
 N'Seafood', N'100,000 - 300,000 VND', 4.4, N'9:00 - 22:00'),

(N'Xin Chào Restaurant', N'Xin Chao Restaurant', N'66 Trần Hưng Đạo, Phú Quốc', 
 N'Không gian mở ven biển, chuyên phục vụ các món ăn Việt Nam hiện đại và hải sản.', N'Beachside restaurant offering modern Vietnamese cuisine and fresh seafood.', 
 N'Vietnamese Fusion', N'150,000 - 400,000 VND', 4.6, N'11:00 - 23:00');


 -- Từ TP.HCM đi Đà Lạt (id = 4)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 4, N'Xe khách', 
 N'Xe khách giường nằm từ TP.HCM đi Đà Lạt, khởi hành từ bến xe Miền Đông.', 
 N'Sleeper bus from Ho Chi Minh City to Da Lat, departing from Mien Dong bus station.', 
 250000, 350000, N'6-7 giờ');

INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 4, N'Máy bay', 
 N'Chuyến bay từ sân bay Tân Sơn Nhất đến sân bay Liên Khương (Đà Lạt).', 
 N'Flight from Tan Son Nhat Airport to Lien Khuong Airport (Da Lat).', 
 1200000, 1800000, N'1 giờ bay');

-- Từ TP.HCM đi Mũi Né (id = 8)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 8, N'Xe khách', 
 N'Xe khách từ TP.HCM đi Mũi Né, khởi hành từ bến xe Miền Đông.', 
 N'Bus from Ho Chi Minh City to Mui Ne, departing from Mien Dong bus station.', 
 150000, 250000, N'4-5 giờ');

INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 8, N'Tàu hỏa', 
 N'Tàu hỏa từ TP.HCM đi Phan Thiết, sau đó bắt taxi/bus đến Mũi Né.', 
 N'Train from Ho Chi Minh City to Phan Thiet, then taxi/bus to Mui Ne.', 
 160000, 300000, N'4-5 giờ');

-- Từ TP.HCM đi Phú Quốc (id = 12)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 12, N'Máy bay', 
 N'Chuyến bay thẳng từ sân bay Tân Sơn Nhất đến Phú Quốc.', 
 N'Direct flight from Tan Son Nhat Airport to Phu Quoc.', 
 900000, 1500000, N'1 giờ bay');

INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 12, N'Xe khách + tàu cao tốc', 
 N'Đi xe khách từ TP.HCM đến Rạch Giá, sau đó đi tàu cao tốc ra đảo Phú Quốc.', 
 N'Bus from Ho Chi Minh City to Rach Gia, then express ferry to Phu Quoc Island.', 
 600000, 1000000, N'8-10 giờ');

-- Từ TP.HCM đi Hội An (id = 2)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 2, N'Máy bay', 
 N'Bay từ TP.HCM đến sân bay Đà Nẵng, sau đó đi taxi/bus 30km để đến Hội An.', 
 N'Flight from Ho Chi Minh City to Da Nang Airport, then taxi/bus 30km to Hoi An.', 
 1000000, 1600000, N'1 giờ 20 phút (bay) + 45 phút di chuyển');

-- Từ TP.HCM đi Núi Bà Đen (id = 19)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 19, N'Xe máy / ô tô', 
 N'Đi xe máy hoặc ô tô theo quốc lộ 22, quãng đường khoảng 100km.', 
 N'Motorbike or car via National Highway 22, distance ~100km.', 
 100000, 300000, N'2-2.5 giờ');

-- Từ TP.HCM đi Chợ nổi Cái Răng (Cần Thơ, id = 27)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 27, N'Xe khách', 
 N'Xe khách từ TP.HCM đến Cần Thơ, sau đó đi thuyền ra Chợ nổi Cái Răng.', 
 N'Bus from Ho Chi Minh City to Can Tho, then boat to Cai Rang Floating Market.', 
 150000, 250000, N'3-4 giờ (bus) + 30 phút (thuyền)');

-- Từ TP.HCM đi Vịnh Vĩnh Hy (Ninh Thuận, id = 29)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 29, N'Xe khách', 
 N'Xe khách từ TP.HCM đi Phan Rang, sau đó taxi/xe máy đến Vĩnh Hy.', 
 N'Bus from Ho Chi Minh City to Phan Rang, then taxi/motorbike to Vinh Hy Bay.', 
 250000, 400000, N'6-7 giờ');

-- Từ TP.HCM đi Đồi chè Cầu Đất (Đà Lạt, id = 30)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 30, N'Xe khách', 
 N'Xe khách đi Đà Lạt, sau đó đi taxi/xe máy thêm 25km để đến Đồi chè Cầu Đất.', 
 N'Sleeper bus to Da Lat, then taxi/motorbike 25km to Cau Dat Tea Hill.', 
 250000, 400000, N'6-7 giờ (bus) + 40 phút (xe)');

-- Từ TP.HCM đi Đảo Lý Sơn (Quảng Ngãi, id = 20)
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 20, N'Máy bay + tàu cao tốc', 
 N'Bay từ TP.HCM đến Chu Lai/Đà Nẵng, sau đó đi tàu cao tốc ra đảo Lý Sơn.', 
 N'Flight from Ho Chi Minh City to Chu Lai/Da Nang, then express ferry to Ly Son Island.', 
 1500000, 2200000, N'1.5 giờ (bay) + 1 giờ (tàu)');

-- Từ TP.HCM đi Vũng Tàu bằng xe khách
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 34, N'Xe khách', 
 N'Xe khách chất lượng cao từ TP.HCM đến trung tâm Vũng Tàu, khởi hành liên tục mỗi ngày.', 
 N'High-quality bus service from Ho Chi Minh City to Vung Tau city center, with frequent daily departures.', 
 150000, 200000, N'2-2.5 giờ');

-- Từ TP.HCM đi Vũng Tàu bằng xe máy
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 34, N'Xe máy', 
 N'Đi xe máy theo cung đường qua phà Cát Lái hoặc quốc lộ 51.', 
 N'Motorbike trip via Cat Lai ferry or National Highway 51.', 
 100000, 150000, N'2.5-3 giờ');

-- Từ TP.HCM đi Vũng Tàu bằng ô tô cá nhân
INSERT INTO Transportation (origin, destination_id, transport_mode, description_vi, description_en, cost_min, cost_max, duration)
VALUES 
(N'TP.Hồ Chí Minh', 34, N'Ô tô cá nhân', 
 N'Lái xe ô tô cá nhân qua cao tốc TP.HCM - Long Thành - Dầu Giây, sau đó đi tiếp quốc lộ 51.', 
 N'Drive your own car via HCMC - Long Thanh - Dau Giay expressway, then continue on Highway 51.', 
 300000, 500000, N'2-2.5 giờ');

