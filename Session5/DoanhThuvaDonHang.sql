--1.ALIAS:
--Hiển thị danh sách tất cả các đơn hàng với các cột:
--Tên khách (customer_name)
--Ngày đặt hàng (order_date)
--Tổng tiền (total_amount)
SELECT 
    c.customer_name AS customer_name,
    o.order_date AS order_date,
    o.total_amount AS total_amount
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id;
--2.Aggregate Functions:
--Tính các thông tin tổng hợp:
--Tổng doanh thu (SUM(total_amount))
SELECT SUM(total_amount) AS total_sales
FROM orders;

--Trung bình giá trị đơn hàng (AVG(total_amount))
SELECT AVG(total_amount) AS avg_order_value
FROM orders;

--Đơn hàng lớn nhất (MAX(total_amount))
SELECT MAX(total_amount) AS max_order_value
FROM orders;

--Đơn hàng nhỏ nhất (MIN(total_amount))
SELECT MIN(total_amount) AS min_order_value
FROM orders;

--Số lượng đơn hàng (COUNT(order_id))
SELECT COUNT(order_id) AS order_count
FROM orders;
--3.GROUP BY / HAVING:
--Tính tổng doanh thu theo từng thành phố
SELECT 
    c.city,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.city;

--chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 10.000
SELECT 
    c.city,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;
--4.JOIN:
--Liệt kê tất cả các sản phẩm đã bán, kèm:
--Tên khách hàng
--Ngày đặt hàng
--Số lượng và giá
SELECT 
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id;
-- 5.Subquery:
--Tìm tên khách hàng có tổng doanh thu cao nhất.
SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_total)
    FROM (
        SELECT 
            customer_id,
            SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS revenue_table
);
--5.UNION và INTERSECT:
--Dùng UNION để hiển thị danh sách tất cả thành phố có khách hàng hoặc có đơn hàng
SELECT city
FROM customers

UNION

SELECT c.city
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id;


--Dùng INTERSECT để hiển thị các thành phố vừa có khách hàng vừa có đơn hàng
SELECT city
FROM customers

INTERSECT

SELECT c.city
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id;
