CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    balance NUMERIC(12,2)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2),
    stock INT
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    total_amount NUMERIC(12,2),
    created_at TIMESTAMP DEFAULT NOW(),
    status VARCHAR(20) DEFAULT 'PENDING'
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    subtotal NUMERIC(12,2)
);

INSERT INTO customers (name, balance)
VALUES ('Tran Thi B', 5000);

INSERT INTO products (name, price, stock)
VALUES 
('Phone', 2000, 5),
('Headphone', 500, 1),
('Mouse', 300, 10);

SELECT * FROM customers;
SELECT * FROM products;

BEGIN;

INSERT INTO orders (customer_id, total_amount)
VALUES (1, 0);

SAVEPOINT step1;

UPDATE products
SET stock = stock - 1
WHERE product_id = 1 AND stock >= 1;

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (1, 1, 1, 2000);

SAVEPOINT step2;

UPDATE products
SET stock = stock - 2
WHERE product_id = 3 AND stock >= 2;

INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (1, 3, 2, 600);

UPDATE orders
SET total_amount = 2600
WHERE order_id = 1;

UPDATE customers
SET balance = balance - 2600
WHERE customer_id = 1 AND balance >= 2600;

UPDATE orders
SET status = 'COMPLETED'
WHERE order_id = 1;

COMMIT;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

BEGIN;

INSERT INTO orders (customer_id, total_amount)
VALUES (1, 0);

SAVEPOINT sp_fail;

UPDATE products
SET stock = stock - 10
WHERE product_id = 2 AND stock >= 10;

ROLLBACK TO sp_fail;

ROLLBACK;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;