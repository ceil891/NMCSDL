
CREATE SCHEMA IF NOT EXISTS sales;
CREATE TABLE sales.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL
);
CREATE TABLE sales.orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    member_id INTEGER NOT NULL,
    CONSTRAINT fk_orders_member
        FOREIGN KEY (member_id)
        REFERENCES library1.members(member_id)
);
CREATE TABLE sales.order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    CONSTRAINT fk_orderdetails_order
        FOREIGN KEY (order_id)
        REFERENCES sales.orders(order_id),
    CONSTRAINT fk_orderdetails_product
        FOREIGN KEY (product_id)
        REFERENCES sales.products(product_id)
);
INSERT INTO sales.products (product_name, price, stock_quantity)
VALUES
('Laptop Dell', 15000000.00, 10),
('Chuột Logitech', 350000.00, 50),
('Bàn phím cơ', 1200000.00, 20);
INSERT INTO sales.orders (member_id)
VALUES
(1),
(2);
INSERT INTO sales.order_details (order_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);
SELECT * FROM sales.products;
SELECT * FROM sales.orders;
SELECT * FROM sales.order_details;
ALTER TABLE library1.books
ADD COLUMN genre VARCHAR(100);
ALTER TABLE library1.books
RENAME COLUMN available TO is_available;
ALTER TABLE library1.members
DROP COLUMN email;
DROP TABLE IF EXISTS sales.order_details;