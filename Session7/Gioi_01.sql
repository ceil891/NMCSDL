CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR,
    region VARCHAR(58)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id),
    total_amount DECIMAL(10,2),
    order_date DATE,
    status VARCHAR(29)
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(160),
    price DECIMAL(10,2),
    category VARCHAR(255)
);

CREATE TABLE order_detail (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES product(product_id),
    quantity INT
);
--Tạo View tổng hợp doanh thu theo khu vực: 
-- a)
CREATE VIEW revenue_by_region AS
SELECT c.region, SUM(o.total_amount) AS total_revenue
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region  desc limit 3; 
-- Tạo View chi tiết đơn hàng có thể cập nhật được: 
CREATE VIEW v_order_updatable AS
SELECT
    o.order_id,
    c.full_name,
    o.status,
    o.total_amount
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.status IN ('NEW', 'PROCESSING')
WITH CHECK OPTION;
 -- Cập nhật status qua View 
 UPDATE v_order_updatable
SET status = 'PROCESSING'
WHERE order_id = 1;
-- Vi phạm WITH CHECK OPTION
-- View phức hợp
CREATE VIEW v_revenue_above_avg AS
SELECT
    region,
    total_revenue
FROM v_revenue_by_region
WHERE total_revenue >
      (SELECT AVG(total_revenue) FROM v_revenue_by_region);
