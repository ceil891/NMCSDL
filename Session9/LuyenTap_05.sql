CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0),
    sale_date DATE NOT NULL
);
/*Tạo Procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC) để tính tổng amount trong khoảng start_date đến end_date*/
CREATE OR REPLACE PROCEDURE calculate_total_sales(
    start_date DATE,
    end_date DATE,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COALESCE(SUM(amount), 0)
    INTO total
    FROM sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;
/*
Gọi Procedure với các ngày mẫu và hiển thị kết quả
*/
CALL calculate_total_sales('2024-01-01','2024-01-31',@total);
SELECT @total;
