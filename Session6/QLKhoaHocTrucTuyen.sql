-- 1. Thêm ít nhất 6 khóa học vào bảng
INSERT INTO Course (title, instructor, price, duration) VALUES
('SQL Cơ Bản', 'Nguyễn An', 600000, 25),
('SQL Nâng Cao', 'Trần Bình', 1200000, 40),
('Java Backend', 'Lê Cường', 1800000, 50),
('Python Data', 'Phạm Dũng', 1500000, 35),
('Web Demo HTML', 'Hoàng Em', 400000, 20),
('DevOps Demo', 'Vũ Giang', 900000, 30);
-- 2. Cập nhật giá tăng 15% cho các khóa học có thời lượng trên 30 giờ
UPDATE Course
SET price = price * 1.15
WHERE duration > 30;
-- 3. Xóa khóa học có tên chứa từ khóa “Demo”
DELETE FROM Course
WHERE title LIKE '%Demo%';
-- 4. Hiển thị các khóa học có tên chứa từ “SQL”
SELECT *
FROM Course
WHERE title ILIKE '%sql%';
-- 5. Lấy 3 khóa học có giá từ 500,000 đến 2,000,000 sắp xếp theo giá giảm dần
SELECT *
FROM Course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;
