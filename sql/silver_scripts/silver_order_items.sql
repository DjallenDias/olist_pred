CREATE table if not exists silver.order_items AS
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    NULLIF(shipping_limit_date, '')::timestamp
        AS shipping_limit_date,
    price::numeric(10,2)
        AS price,
    freight_value::numeric(10,2)
        AS freight_value
FROM raw.order_items;