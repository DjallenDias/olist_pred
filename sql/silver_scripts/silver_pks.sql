ALTER TABLE silver.orders
ADD CONSTRAINT pk_orders
PRIMARY KEY (order_id);
ALTER TABLE silver.customers
ADD CONSTRAINT pk_customers
PRIMARY KEY (customer_id);
ALTER TABLE silver.products
ADD CONSTRAINT pk_products
PRIMARY KEY (product_id);
ALTER TABLE silver.sellers
ADD CONSTRAINT pk_sellers
PRIMARY KEY (seller_id);
ALTER TABLE silver.geolocation
ADD CONSTRAINT pk_geolocation
PRIMARY KEY (geolocation_zip_code_prefix);
ALTER TABLE silver.category_translation
ADD CONSTRAINT pk_category_translation
PRIMARY KEY (product_category_name);
ALTER TABLE silver.order_reviews
ADD CONSTRAINT pk_order_reviews
PRIMARY KEY (review_id, order_id);
ALTER TABLE silver.order_items
ADD CONSTRAINT pk_order_items
PRIMARY KEY (order_id, order_item_id);
ALTER TABLE silver.order_payments
ADD CONSTRAINT pk_order_payments
PRIMARY KEY (order_id, payment_sequential);