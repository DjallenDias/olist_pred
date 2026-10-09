CREATE TABLE if not exists gold.delivery_delay AS
SELECT
    order_id,
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN 1
        ELSE 0
    END AS is_delayed
FROM silver.orders
WHERE order_status = 'delivered'
  AND order_approved_at IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;