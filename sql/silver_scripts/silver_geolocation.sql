CREATE TABLE if not exists silver.geolocation AS
SELECT
    geolocation_zip_code_prefix,
    AVG(geolocation_lat::double precision)
        AS geolocation_lat,
    AVG(geolocation_lng::double precision)
        AS geolocation_lng,
    MIN(LOWER(TRIM(geolocation_city)))
        AS geolocation_city,
    MIN(UPPER(TRIM(geolocation_state)))
        AS geolocation_state
FROM raw.geolocation
WHERE geolocation_lat IS NOT NULL
  AND geolocation_lng IS NOT NULL
GROUP BY geolocation_zip_code_prefix;