CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    stock INT CHECK (stock >= 0)
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    quantity INT CHECK (quantity > 0)
);

CREATE OR REPLACE FUNCTION update_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE products
        SET stock = stock - NEW.quantity
        WHERE id = NEW.product_id;
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity - NEW.quantity
        WHERE id = NEW.product_id;
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        UPDATE products
        SET stock = stock + OLD.quantity
        WHERE id = OLD.product_id;
        RETURN OLD;
    END IF;
END;
$$;

CREATE TRIGGER trg_update_stock
AFTER INSERT OR UPDATE OR DELETE
ON orders
FOR EACH ROW
EXECUTE FUNCTION update_stock();

INSERT INTO products(name, stock)
VALUES
('Laptop', 50),
('Mouse', 100);

INSERT INTO orders(product_id, quantity)
VALUES (1, 5);

UPDATE orders
SET quantity = 10
WHERE id = 1;

DELETE FROM orders
WHERE id = 1;

SELECT * FROM products;
SELECT * FROM orders;
