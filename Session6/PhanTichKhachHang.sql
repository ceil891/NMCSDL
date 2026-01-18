CREATE TABLE Customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2)
);
-- 1. Hiển thị tên khách hàng và tổng tiền đã mua, sắp xếp theo tổng tiền giảm dần

SELECT
    c.name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customer c
INNER JOIN Orders o
    ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;
-- 2. Tìm khách hàng có tổng chi tiêu cao nhất
SELECT
    c.name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customer c
INNER JOIN Orders o
    ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) = (
    SELECT MAX(total_by_customer)
    FROM (
        SELECT SUM(total_amount) AS total_by_customer
        FROM Orders
        GROUP BY customer_id
    ) sub
);
-- 3.Liệt kê khách hàng chưa từng mua hàng
SELECT
    c.name AS customer_name
FROM Customer c
LEFT JOIN Orders o
    ON c.id = o.customer_id
WHERE o.id IS NULL;

-- 4. Hiển thị khách hàng có tổng chi tiêu > trung bình toàn bộ khách hàng
SELECT
    c.name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customer c
INNER JOIN Orders o
    ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM Orders
        GROUP BY customer_id
    ) avg_table
);
