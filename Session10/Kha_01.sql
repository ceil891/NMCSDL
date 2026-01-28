CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION update_last_modified()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.last_modified := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_update_last_modified
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_last_modified();

INSERT INTO products (name, price)
VALUES
('Laptop Dell', 1500),
('Chuột Logitech', 25),
('Bàn phím cơ', 80);

UPDATE products
SET price = 1600
WHERE id = 1;

SELECT * FROM products;
