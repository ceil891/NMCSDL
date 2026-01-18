--Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
--Đặt bí danh cột như sau:
--total_sales cho tổng doanh thu
--total_quantity cho tổng số lượng
SELECT 
    p.category AS category,
    SUM(o.total_price) AS total_sales,
    SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.category;
--Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
SELECT 
    p.category AS category,
    SUM(o.total_price) AS total_sales,
    SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000;
--Sắp xếp kết quả theo tổng doanh thu giảm dần
SELECT 
    p.category AS category,
    SUM(o.total_price) AS total_sales,
    SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;
