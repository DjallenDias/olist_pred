WITH order_states AS (
    SELECT
        g.order_id,
        c.customer_state,
        COUNT(DISTINCT s.seller_state) AS seller_state_count,
        COUNT(DISTINCT s.seller_state)
            FILTER (
                WHERE s.seller_state = c.customer_state
            ) AS matching_states
    FROM gold.delivery_delay g
    JOIN silver.orders o
        ON g.order_id = o.order_id
    JOIN silver.customers c
        ON o.customer_id = c.customer_id
    JOIN silver.order_items oi
        ON g.order_id = oi.order_id
    JOIN silver.sellers s
        ON oi.seller_id = s.seller_id
    GROUP BY
        g.order_id,
        c.customer_state
)
UPDATE gold.delivery_delay g
SET shipping_state_type =
    CASE
        WHEN os.seller_state_count = 1
             AND os.matching_states = 1
            THEN 1
        WHEN os.matching_states = 0
            THEN 0
        ELSE 2
    END
FROM order_states os
WHERE g.order_id = os.order_id;