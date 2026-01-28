CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credit_limit NUMERIC(12,2) NOT NULL CHECK (credit_limit >= 0)
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    order_amount NUMERIC(12,2) NOT NULL CHECK (order_amount > 0)
);

CREATE OR REPLACE FUNCTION check_credit_limit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    total_orders NUMERIC(12,2);
    customer_limit NUMERIC(12,2);
BEGIN
    SELECT COALESCE(SUM(order_amount), 0)
    INTO total_orders
    FROM orders
    WHERE customer_id = NEW.customer_id;

    SELECT credit_limit
    INTO customer_limit
    FROM customers
    WHERE id = NEW.customer_id;

    IF total_orders + NEW.order_amount > customer_limit THEN
        RAISE EXCEPTION 'Credit limit exceeded for customer %', NEW.customer_id;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_check_credit
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_credit_limit();

INSERT INTO customers (name, credit_limit)
VALUES
('Nguyen Van A', 1000),
('Tran Thi B', 500);

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 300);

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 400);

INSERT INTO orders (customer_id, order_amount)
VALUES (1, 500);

INSERT INTO orders (customer_id, order_amount)
VALUES (2, 600);

SELECT * FROM customers;
SELECT * FROM orders;
