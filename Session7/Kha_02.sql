CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer (customer_id),
    total_amount DECIMAL(10,2),
    order_date DATE
);

create view v_order_summary as
select c.full_name , o.total_amount ,o.order_date
from customer c join orders o  on o.customer_id = c.customer_id 


-- Viết truy vấn để xem tất cả dữ liệu từ View
select * from v_order_summary

-- Cập nhật tổng tiền đơn hàng thông qua View (gợi ý: dùng WITH CHECK OPTION nếu cần)
update v_order_summary 
set total_amount = 500000
where  full_name = 'Nguyen Van Hung' AND  order_date = '2026-21-01'
 
-- Tạo một View thứ hai v_monthly_sales thống kê tổng doanh thu mỗi tháng dung DATE_TRUNC
Create view v_monthly_sales as
sellect
DATE_TRUNC('month', order_date) as sales_month
sum(total_amount) as total_sales
from orders 
group by DATE_TRUNC('month', order_date)
order by sales_month


