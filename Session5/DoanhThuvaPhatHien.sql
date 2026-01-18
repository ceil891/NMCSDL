--Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng:
--Chỉ hiển thị khách hàng có tổng doanh thu > 2000
--Dùng ALIAS: total_revenue và order_count
SELECT 
    c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;
--Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
--Sau đó hiển thị những khách hàng có doanh thu lớn hơn mức trung bình đó
SELECT 
    c.customer_name,
    SUM(o.total_price) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT 
            customer_id,
            SUM(total_price) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS avg_table
);
--Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
SELECT 
    c.city,
    SUM(o.total_price) AS total_revenue
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) > 3000;
--Mở rộng) Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết:
--Tên khách hàng, tên thành phố, tổng sản phẩm đã mua, tổng chi tiêu
SELECT 
    c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_products,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;
