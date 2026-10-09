CREATE TABLE if not exists silver.order_reviews AS
SELECT
    review_id,
    order_id,
    NULLIF(TRIM(review_score), '')::integer
        AS review_score,
    NULLIF(TRIM(review_comment_title), '')
        AS review_comment_title,
    NULLIF(TRIM(review_comment_message), '')
        AS review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM raw.order_reviews;