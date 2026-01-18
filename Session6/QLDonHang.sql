CREATE TABLE OrderInfo (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total NUMERIC(10,2),
    status VARCHAR(20)
);
--1. Thêm 5 đơn hàng mẫu với tổng tiền khác nhau
INSERT INTO OrderInfo (customer_id, order_date, total, status) VALUES
(1, '2024-01-05', 300000, 'Completed'),
(2, '2024-01-12', 750000, 'Pending'),
(3, '2024-02-03', 1200000, 'Completed'),
(1, '2024-01-25', 550000, 'Cancelled'),
(4, '2023-12-28', 900000, 'Completed');
--2. Truy vấn các đơn hàng có tổng tiền lớn hơn 500,000
SELECT *
FROM OrderInfo
WHERE total > 500000;
--3. Truy vấn các đơn hàng có ngày đặt trong tháng 1 năm 2024
SELECT *
FROM OrderInfo
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31';
--4. Liệt kê các đơn hàng có trạng thái khác “Completed”
SELECT *
FROM OrderInfo
WHERE status <> 'Completed';
--5. Lấy 2 đơn hàng mới nhất
SELECT *
FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;

