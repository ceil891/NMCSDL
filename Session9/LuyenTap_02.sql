CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL
);
--Tạo Hash Index trên cột email
create index idx_users_email on users using hash(email)
EXPLAIN
SELECT *
FROM users
WHERE email = 'abc@gmail.com';
