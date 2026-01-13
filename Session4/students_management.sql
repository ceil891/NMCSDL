
CREATE TABLE  students (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    birth_year INT,
    major VARCHAR(50),
    gpa DECIMAL(3,2)
);
INSERT INTO students (id, full_name, gender, birth_year, major, gpa) VALUES
(1, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(2, 'Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
(3, 'Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
(4, 'Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
(5, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(6, 'Lưu Đức Tài', NULL, 2004, 'Cơ khí', NULL),
(7, 'Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

--Chèn dữ liệu mới : Thêm sinh viên Phan Hoàng Nam, Nam, 2003, CNTT, GPA 3.8
INSERT INTO students (full_name, gender, birth_year, major, gpa)
VALUES ('Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- Cập nhật dữ liệu : Cập nhật GPA của sinh viên Lê Quốc Cường thành 3.4
UPDATE students
SET gpa = 3.4
WHERE full_name = 'Lê Quốc Cường';

-- Xóa dữ liệu : Xóa tất cả sinh viên có GPA IS NULL
DELETE FROM students
WHERE gpa IS NULL;

-- Truy vấn cơ bản : Hiển thị sinh viên ngành CNTT có GPA >= 3.0, lấy 3 kết quả đầu tiên
SELECT *
FROM students
WHERE major = 'CNTT'
  AND gpa >= 3.0
LIMIT 3;

-- Loại bỏ trùng lặp : Liệt kê danh sách ngành học duy nhất
SELECT DISTINCT major
FROM students;

-- Sắp xếp : Hiển thị sinh viên ngành CNTT,sắp xếp GPA giảm dần, sau đó tên tăng dần
SELECT *
FROM students
WHERE major = 'CNTT'
ORDER BY gpa DESC, full_name ASC;

--  Tìm kiếm : Tìm sinh viên có tên bắt đầu bằng "Nguyễn"
SELECT *
FROM students
WHERE full_name LIKE 'Nguyễn%';

--  Khoảng giá trị : Hiển thị sinh viên có năm sinh từ 2001 đến 2003
SELECT *
FROM students
WHERE birth_year BETWEEN 2001 AND 2003;
