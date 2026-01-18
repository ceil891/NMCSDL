CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);
--1. Thêm 5 sản phẩm vào bảng (INSERT)
INSERT INTO Product (name, category, price, stock) VALUES
('Laptop Dell', 'Electronics', 15000000, 10),
('iPhone 13', 'Electronics', 20000000, 5),
('Bàn học', 'Furniture', 3500000, 20),
('Ghế xoay', 'Furniture', 2500000, 15),
('Tai nghe', 'Accessories', 800000, 50);
--2. Hiển thị danh sách toàn bộ sản phẩm
SELECT * 
FROM Product;
--3. Hiển thị 3 sản phẩm có giá cao nhất
SELECT * 
FROM Product
ORDER BY price DESC
LIMIT 3;
--4. Hiển thị sản phẩm thuộc danh mục “Điện tử”
SELECT * 
FROM Product
WHERE category = 'Electronics'
  AND price < 10000000;
--5. Sắp xếp sản phẩm theo số lượng tồn kho tăng dần
SELECT * 
FROM Product
ORDER BY stock ASC;
