--Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
--Hiển thị: product_name, total_revenue
SELECT 
    p.product_name,
    SUM(o.total_price) AS total_revenue
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.total_price) = (
    SELECT MAX(product_revenue)
    FROM (
        SELECT 
            product_id,
            SUM(total_price) AS product_revenue
        FROM orders
        GROUP BY product_id
    ) AS revenue_table
);
--Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
SELECT 
    p.category,
    SUM(o.total_price) AS total_revenue
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.category;
-- Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
-- Category của sản phẩm bán chạy nhất
SELECT p.category
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.category
HAVING SUM(o.total_price) = (
    SELECT MAX(product_revenue)
    FROM (
        SELECT 
            product_id,
            SUM(total_price) AS product_revenue
        FROM orders
        GROUP BY product_id
    ) AS revenue_table
)

INTERSECT

-- Category có tổng doanh thu > 3000
SELECT p.category
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;

