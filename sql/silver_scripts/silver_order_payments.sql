CREATE TABLE if not exists silver.order_payments AS
SELECT
    order_id,
    payment_sequential,
    LOWER(TRIM(payment_type))
        AS payment_type,
    payment_installments,
    payment_value::numeric(10,2)
        AS payment_value
FROM raw.order_payments;