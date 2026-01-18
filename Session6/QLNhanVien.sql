CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE
);
--1. Thêm 4 nhân viên mới
INSERT INTO Employee (full_name, department, salary, hire_date) VALUES
('Nguyen Van An', 'IT', 8000000, '2023-02-15'),
('Tran Thi Binh', 'HR', 6500000, '2022-10-01'),
('Le Van Cuong', 'IT', 12000000, '2021-06-20'),
('Pham Thi Anh', 'Finance', 7000000, '2023-08-05');
--2. Cập nhật mức lương tăng 10% cho nhân viên phòng IT
UPDATE Employee
SET salary = salary * 1.10
WHERE department = 'IT';
--3. Xóa nhân viên có mức lương dưới 6,000,000
DELETE FROM Employee
WHERE salary < 6000000;
--4. Liệt kê các nhân viên có tên chứa chữ “An” (không phân biệt hoa thường)

SELECT *
FROM Employee
WHERE full_name ILIKE '%an%';
--5. Hiển thị các nhân viên có ngày vào làm việc trong khoảng từ '2023-01-01' đến '2023-12-31'
SELECT *
FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';
