CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);
CREATE OR REPLACE PROCEDURE calculate_order_total(
    IN order_id_input INT,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;
END;
$$;
