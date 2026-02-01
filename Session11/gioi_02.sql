CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    balance NUMERIC(12,2)
);

CREATE TABLE transactions (
    trans_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    amount NUMERIC(12,2),
    trans_type VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO accounts (customer_name, balance)
VALUES
('Nguyen Van A', 1000),
('Tran Van B', 500);

SELECT * FROM accounts;

BEGIN;

UPDATE accounts
SET balance = balance - 200
WHERE account_id = 1 AND balance >= 200;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 200, 'WITHDRAW');

COMMIT;

SELECT * FROM accounts;
SELECT * FROM transactions;

BEGIN;

UPDATE accounts
SET balance = balance - 300
WHERE account_id = 1 AND balance >= 300;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (999, 300, 'WITHDRAW');

ROLLBACK;

SELECT * FROM accounts;
SELECT * FROM transactions;

BEGIN;

UPDATE accounts
SET balance = balance - 50
WHERE account_id = 1 AND balance >= 50;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 50, 'WITHDRAW');

UPDATE accounts
SET balance = balance - 50
WHERE account_id = 1 AND balance >= 50;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 50, 'WITHDRAW');

COMMIT;

SELECT * FROM accounts;
SELECT * FROM transactions;