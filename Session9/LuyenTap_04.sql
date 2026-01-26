CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    amount DECIMAL(12,2)
);
-- Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
CREATE VIEW CustomerSales AS
SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;
--Truy vấn khách hàng mua trên 1000
SELECT *
FROM CustomerSales
WHERE total_amount > 1000;
-- Thử cập nhật một bản ghi qua View và quan sát kết quả
UPDATE CustomerSales
SET total_amount = 5000
WHERE customer_id = 'C001';


