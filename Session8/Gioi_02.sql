create table products (
id serial primary key,
name varchar(100),
price numeric ,
discount_percent int
);
/*
Viết Procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC) để:
Lấy price và discount_percent của sản phẩm
Tính giá sau giảm:
 p_final_price = price - (price * discount_percent / 100)*/
CREATE OR REPLACE PROCEDURE calculate_discount(
    IN p_id INT,
    OUT p_final_price NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price NUMERIC;
    v_discount INT;
BEGIN
    -- Lấy giá và % giảm
    SELECT price, discount_percent
    INTO v_price, v_discount
    FROM products
    WHERE id = p_id;

    -- Nếu không tìm thấy sản phẩm
    IF v_price IS NULL THEN
        RAISE EXCEPTION 'Sản phẩm không tồn tại';
    END IF;

    -- Giới hạn giảm giá tối đa 50%
    IF v_discount > 50 THEN
        v_discount := 50;
    END IF;

    -- Tính giá sau giảm
    p_final_price := v_price - (v_price * v_discount / 100);

    -- Cập nhật lại giá trong bảng
    UPDATE products
    SET price = p_final_price
    WHERE id = p_id;

END;
$$;
