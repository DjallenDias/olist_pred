WITH category_counts AS (
    SELECT
        g.order_id,
        COUNT(DISTINCT p.product_category_name) AS category_count
    FROM gold.delivery_delay g
    JOIN silver.order_items oi
        ON g.order_id = oi.order_id
    LEFT JOIN silver.products p
        ON oi.product_id = p.product_id
    GROUP BY g.order_id
),
category_ranking AS (
    SELECT
        oi.order_id,
        COALESCE(
            ct.product_category_name_english,
            p.product_category_name,
            'unknown'
        ) AS category,
        COUNT(*) AS item_count,
        ROW_NUMBER() OVER (
            PARTITION BY oi.order_id
            ORDER BY
                COUNT(*) DESC,
                COALESCE(
                    ct.product_category_name_english,
                    p.product_category_name,
                    'unknown'
                ) ASC
        ) AS rn
    FROM silver.order_items oi
    LEFT JOIN silver.products p
        ON oi.product_id = p.product_id
    LEFT JOIN silver.category_translation ct
        ON p.product_category_name = ct.product_category_name
    GROUP BY
        oi.order_id,
        COALESCE(
            ct.product_category_name_english,
            p.product_category_name,
            'unknown'
        )
)
UPDATE gold.delivery_delay g
SET
    category_count = cc.category_count,
    main_product_category = cr.category
FROM category_counts cc
JOIN category_ranking cr
    ON cc.order_id = cr.order_id
   AND cr.rn = 1
WHERE g.order_id = cc.order_id;