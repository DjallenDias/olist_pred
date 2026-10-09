UPDATE gold.delivery_delay g
SET
    purchase_month =
        EXTRACT(MONTH FROM o.order_purchase_timestamp),
    purchase_day_of_week =
        EXTRACT(DOW FROM o.order_purchase_timestamp),
    purchase_hour =
        EXTRACT(HOUR FROM o.order_purchase_timestamp),
    approval_time_hours =
        EXTRACT(
            EPOCH FROM (
                o.order_approved_at
                - o.order_purchase_timestamp
            )
        ) / 3600.0,
    estimated_delivery_days =
        EXTRACT(
            EPOCH FROM (
                o.order_estimated_delivery_date
                - o.order_approved_at
            )
        ) / 86400.0
FROM silver.orders o
WHERE g.order_id = o.order_id;