
CREATE DATABASE LibraryDB;
CREATE SCHEMA library1;
CREATE TABLE library1.books (
    book_id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_year INTEGER,
    available BOOLEAN DEFAULT TRUE
);
CREATE TABLE library1.members (
    member_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE
);
INSERT INTO library1.books (book_id, title, author, published_year, available)
VALUES
(1, 'Clean Code', 'Robert C. Martin', 2008, TRUE),
(2, 'Design Patterns', 'Erich Gamma', 1994, TRUE),
(3, 'Database System Concepts', 'Silberschatz', 2010, FALSE);
INSERT INTO library1.members (member_id, name, email)
VALUES
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com');
SELECT * FROM library1.books;
SELECT * FROM library1.members;
