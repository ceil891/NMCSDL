CREATE TABLE Department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department_id INT,
    salary NUMERIC(10,2)
);
-- 1. Liệt kê danh sách nhân viên kèm tên phòng ban
SELECT
    e.full_name AS employee_name,
    d.name AS department_name
FROM Employee e
INNER JOIN Department d
    ON e.department_id = d.id;
-- 2. Tính lương trung bình của từng phòng ban
SELECT
    d.name AS department_name,
    AVG(e.salary) AS avg_salary
FROM Department d
INNER JOIN Employee e
    ON e.department_id = d.id
GROUP BY d.name;
-- 3. Hiển thị các phòng ban có lương trung bình > 10 triệu
SELECT
    d.name AS department_name,
    AVG(e.salary) AS avg_salary
FROM Department d
INNER JOIN Employee e
    ON e.department_id = d.id
GROUP BY d.name
HAVING AVG(e.salary) > 10000000;
-- 4. Liệt kê phòng ban không có nhân viên nào
SELECT
    d.name AS department_name
FROM Department d
LEFT JOIN Employee e
    ON e.department_id = d.id
WHERE e.id IS NULL;
