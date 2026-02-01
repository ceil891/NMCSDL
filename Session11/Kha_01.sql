CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    flight_name VARCHAR(100),
    available_seats INT
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    flight_id INT REFERENCES flights(flight_id),
    customer_name VARCHAR(100)
);

-- ============================
-- DỮ LIỆU BAN ĐẦU
-- ============================
INSERT INTO flights (flight_name, available_seats)
VALUES 
('VN123', 3),
('VN456', 2);

-- ============================
-- KIỂM TRA BAN ĐẦU
-- ============================
SELECT * FROM flights;
SELECT * FROM bookings;

-- ============================
-- TRANSACTION ĐẶT VÉ THÀNH CÔNG
-- ============================
BEGIN;

UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

INSERT INTO bookings (flight_id, customer_name)
VALUES (1, 'Nguyen Van A');

COMMIT;


-- KIỂM TRA SAU COMMIT

SELECT * FROM flights;
SELECT * FROM bookings;


-- MÔ PHỎNG LỖI + ROLLBACK

BEGIN;

UPDATE flights
SET available_seats = available_seats - 1
WHERE flight_name = 'VN123';

-- flight_id sai để gây lỗi
INSERT INTO bookings (flight_id, customer_name)
VALUES (999, 'Tran Thi B');

ROLLBACK;


-- KIỂM TRA SAU ROLLBACK
SELECT * FROM flights;
SELECT * FROM bookings;
