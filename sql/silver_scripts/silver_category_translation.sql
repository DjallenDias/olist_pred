CREATE table if not exists silver.category_translation AS
SELECT
    LOWER(TRIM(product_category_name))
        AS product_category_name,
    LOWER(TRIM(product_category_name_english))
        AS product_category_name_english
FROM raw.category_translation;