CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- B-tree cho genre
 create index idx_book_genre on book(genre);
-- GIN cho title hoặc description
create index idx_book_title on book using gin(title);

