CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);

CREATE TABLE OrderDetail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);
-- 1 .Tính tổng doanh thu từng sản phẩm
SELECT
    p.name AS product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM Product p
INNER JOIN OrderDetail od
    ON p.id = od.product_id
GROUP BY p.name;
-- 2. Tính doanh thu trung bình theo từng loại sản phẩm
SELECT
    p.category,
    AVG(p.price * od.quantity) AS avg_sales
FROM Product p
INNER JOIN OrderDetail od
    ON p.id = od.product_id
GROUP BY p.category;
-- 3.Chỉ hiển thị các loại sản phẩm có doanh thu trung bình > 20 triệu
SELECT
    p.category,
    AVG(p.price * od.quantity) AS avg_sales
FROM Product p
INNER JOIN OrderDetail od
    ON p.id = od.product_id
GROUP BY p.category
HAVING AVG(p.price * od.quantity) > 20000000;
-- 4.Hiển thị tên sản phẩm có doanh thu cao hơn doanh thu trung bình của toàn bộ sản phẩm
SELECT
    p.name AS product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM Product p
INNER JOIN OrderDetail od
    ON p.id = od.product_id
GROUP BY p.name
HAVING SUM(p.price * od.quantity) > (
    SELECT AVG(product_sales)
    FROM (
        SELECT SUM(p2.price * od2.quantity) AS product_sales
        FROM Product p2
        INNER JOIN OrderDetail od2
            ON p2.id = od2.product_id
        GROUP BY p2.id
    ) sub
);
