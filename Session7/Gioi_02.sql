

CREATE TABLE post (
    post_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    tags TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id)
);

/* =========================================================
   1. TỐI ƯU TÌM KIẾM BÀI ĐĂNG CÔNG KHAI THEO TỪ KHÓA
   ========================================================= */

/* ---- Truy vấn BEFORE index (Seq Scan) ---- */
EXPLAIN ANALYZE
SELECT *
FROM post
WHERE is_public = TRUE
  AND LOWER(content) LIKE '%postgresql%';


CREATE INDEX idx_post_lower_content
ON post (LOWER(content));

EXPLAIN ANALYZE
SELECT *
FROM post
WHERE is_public = TRUE
  AND LOWER(content) LIKE '%postgresql%';

-- Truy vấn BEFORE index --
EXPLAIN ANALYZE
SELECT *
FROM post
WHERE tags @> ARRAY['sql'];

-- GIN Index cho cột tags --
CREATE INDEX idx_post_tags_gin
ON post
USING GIN (tags);

-- Truy vấn AFTER index --
EXPLAIN ANALYZE
SELECT *
FROM post
WHERE tags @> ARRAY['sql'];

-- Truy vấn BEFORE index ---
EXPLAIN ANALYZE
SELECT *
FROM post
WHERE is_public = TRUE
  AND created_at >= NOW() - INTERVAL '7 days';

/* ---- Partial Index cho bài đăng công khai ---- */
CREATE INDEX idx_post_recent_public
ON post (created_at)
WHERE is_public = TRUE;

-- Truy vấn AFTER index --
EXPLAIN ANALYZE
SELECT *
FROM post
WHERE is_public = TRUE
  AND created_at >= NOW() - INTERVAL '7 days';

-- Composite Index (user_id, created_at DESC) --
CREATE INDEX idx_post_user_created_at
ON post (user_id, created_at DESC);

-- Truy vấn feed bạn bè --
EXPLAIN ANALYZE
SELECT *
FROM post
WHERE user_id IN (2, 5, 8)
ORDER BY created_at DESC
LIMIT 20;

