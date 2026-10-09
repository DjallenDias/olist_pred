WITH distances AS (
    SELECT
        g.order_id,
        6371 * 2 * ASIN(
            SQRT(
                POWER(
                    SIN(
                        RADIANS(gc.geolocation_lat - gs.geolocation_lat) / 2
                    ),
                    2
                )
                +
                COS(RADIANS(gs.geolocation_lat))
                * COS(RADIANS(gc.geolocation_lat))
                * POWER(
                    SIN(
                        RADIANS(gc.geolocation_lng - gs.geolocation_lng) / 2
                    ),
                    2
                )
            )
        ) AS distance_km
    FROM gold.delivery_delay g
    JOIN silver.orders o
        ON g.order_id = o.order_id
    JOIN silver.customers c
        ON o.customer_id = c.customer_id
    JOIN silver.order_items oi
        ON g.order_id = oi.order_id
    JOIN silver.sellers s
        ON oi.seller_id = s.seller_id
    LEFT JOIN silver.geolocation gc
        ON c.customer_zip_code_prefix =
           gc.geolocation_zip_code_prefix
    LEFT JOIN silver.geolocation gs
        ON s.seller_zip_code_prefix =
           gs.geolocation_zip_code_prefix
    WHERE gc.geolocation_lat IS NOT NULL
      AND gc.geolocation_lng IS NOT NULL
      AND gs.geolocation_lat IS NOT NULL
      AND gs.geolocation_lng IS NOT NULL
),
order_distances AS (
    SELECT
        order_id,
        MAX(distance_km) AS distance_km
    FROM distances
    GROUP BY order_id
)
UPDATE gold.delivery_delay g
SET distance_km = d.distance_km
FROM order_distances d
WHERE g.order_id = d.order_id;