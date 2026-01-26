CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(12,2) NOT NULL
);

-- Tạo một B-Tree Index trên cột customer_id
create index idx_orders_customer_id on orders(customer_id)
select *
from orders
where customer_id = 'customer1';
-- CHưa tạo index
--Successfully run. Total query runtime: 323 msec.
--Tạo index
--Successfully run. Total query runtime: 125 msec.