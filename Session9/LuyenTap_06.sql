CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    price NUMERIC(12,2),
    category_id INT
);
CREATE OR REPLACE PROCEDURE update_product_price(
    p_category_id INT,
    p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    r RECORD;
    new_price NUMERIC;
BEGIN
    FOR r IN
        SELECT product_id, price
        FROM products
        WHERE category_id = p_category_id
    LOOP
        new_price := r.price + (r.price * p_increase_percent / 100);

        UPDATE products
        SET price = new_price
        WHERE product_id = r.product_id;
    END LOOP;
END;
$$;
