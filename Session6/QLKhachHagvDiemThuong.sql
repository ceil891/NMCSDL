CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    points INT
);
-- 1. Thêm 7 khách hàng
INSERT INTO Customer (name, email, phone, points) VALUES
('Nguyen Van An', 'an@gmail.com', '0901111111', 120),
('Tran Thi Binh', 'binh@gmail.com', '0902222222', 200),
('Le Van Cuong', 'cuong@gmail.com', '0903333333', 150),
('Pham Thi Dao', NULL, '0904444444', 80),
('Hoang Van Em', 'em@gmail.com', '0905555555', 300),
('Do Thi Hoa', 'hoa@gmail.com', '0906666666', 250),
('Vu Van Kien', 'kien@gmail.com', '0907777777', 180);
-- 2. Truy vấn danh sách tên khách hàng duy nhất (DISTINCT)
SELECT DISTINCT name
FROM Customer;
-- 3. Tìm các khách hàng chưa có email (IS NULL)
SELECT *
FROM Customer
WHERE email IS NULL;
-- 4. Hiển thị 3 khách hàng có điểm thưởng cao nhất
SELECT *
FROM Customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;
-- 5. Sắp xếp danh sách khách hàng theo tên giảm dần
SELECT *
FROM Customer
ORDER BY name DESC;
