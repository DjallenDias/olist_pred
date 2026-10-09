WITH payment_features AS (
    SELECT
        order_id,
        COUNT(*) AS payment_count,
        COUNT(DISTINCT payment_type) AS payment_type_count,
        MAX(payment_installments) AS max_installments
    FROM silver.order_payments
    GROUP BY order_id
)
UPDATE gold.delivery_delay g
SET
    payment_count = p.payment_count,
    payment_type_count = p.payment_type_count,
    max_installments = p.max_installments
FROM payment_features p
WHERE g.order_id = p.order_id;