ALTER TABLE silver.orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES silver.customers(customer_id);
ALTER TABLE silver.order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES silver.orders(order_id);
ALTER TABLE silver.order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES silver.products(product_id);
ALTER TABLE silver.order_items
ADD CONSTRAINT fk_order_items_sellers
FOREIGN KEY (seller_id)
REFERENCES silver.sellers(seller_id);
ALTER TABLE silver.order_payments
ADD CONSTRAINT fk_order_payments_orders
FOREIGN KEY (order_id)
REFERENCES silver.orders(order_id);
ALTER TABLE silver.order_reviews
ADD CONSTRAINT fk_order_reviews_orders
FOREIGN KEY (order_id)
REFERENCES silver.orders(order_id);