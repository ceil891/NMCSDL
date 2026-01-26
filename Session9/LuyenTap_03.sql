CREATE TABLE  products (
    product_id VARCHAR(50) PRIMARY KEY,
    category_id VARCHAR(50),
    price NUMERIC(12,2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Tạo Clustered Index trên cột category_id
create clustered index idx_products_category_id on products(category_id)
-- Tạo Non-clustered Index trên cột price
create index idx_products_price on products(price)
-- Thực hiện truy vấn SELECT * FROM Products WHERE category_id = X ORDER BY price; và giải thích cách Index hỗ trợ tối ưu
EXPLAIN ANALYZE
SELECT *
FROM products
WHERE category_id = '1'
ORDER BY price;
/*Clustered Index trên category_id giúp truy xuất nhanh các sản phẩm cùng danh mục

Non-clustered Index trên price giúp giảm chi phí sắp xếp*/