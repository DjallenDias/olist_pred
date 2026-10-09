UPDATE gold.delivery_delay g
SET
    item_count = agg.item_count,
    unique_product_count = agg.unique_product_count,
    seller_count = agg.seller_count,
    total_price = agg.total_price,
    total_freight = agg.total_freight,
    total_weight_g = agg.total_weight_g,
    total_volume_cm3 = agg.total_volume_cm3
FROM (
    SELECT
        oi.order_id,
        COUNT(*) AS item_count,
        COUNT(DISTINCT oi.product_id) AS unique_product_count,
        COUNT(DISTINCT oi.seller_id) AS seller_count,
        SUM(oi.price) AS total_price,
        SUM(oi.freight_value) AS total_freight,
        SUM(p.product_weight_g)::bigint AS total_weight_g,
        SUM(
            p.product_length_cm::bigint
            * p.product_height_cm::bigint
            * p.product_width_cm::bigint
        ) AS total_volume_cm3
    FROM silver.order_items oi
    LEFT JOIN silver.products p
        ON oi.product_id = p.product_id
    GROUP BY oi.order_id
) agg
WHERE g.order_id = agg.order_id;