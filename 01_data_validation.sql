--Count of rows all tables of olist e-commerce.

SELECT 'customers' AS table_name ,COUNT(*) AS row_count
FROM olist_customers

UNION ALL

SELECT 'orders' AS table_name ,COUNT(*) AS row_count
FROM olist_orders

UNION ALL

SELECT 'order_items' AS table_name ,COUNT(*) AS row_count
FROM olist_order_items

UNION ALL

SELECT 'products' AS table_name ,COUNT(*) AS row_count
FROM olist_products

UNION ALL

SELECT 'product_category_name_translation' AS table_name ,COUNT(*) AS row_count
FROM product_category_name_translation
;




--DATA QUALITY :-

--MISSING VALUES IN olist_customers :
SELECT 
		COUNT(*)  FILTER (WHERE customer_id IS NULL) AS missing_customer_id , 
		COUNT(*) FILTER (WHERE customer_unique_id IS NULL) AS missing_customer_unique_id,
		COUNT(*) FILTER (WHERE customer_zip_code_prefix IS NULL) AS missing_zip_code_prefix,
		COUNT(*) FILTER (WHERE customer_city IS NULL) AS missing_customer_city,
		COUNT(*) FILTER (WHERE customer_state IS NULL) AS missing_customer_state
FROM olist_customers 
;

-- MISSING VALUES IN olist_order_items :
SELECT 
		count(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
		COUNT(*) FILTER (WHERE order_item_id IS NULL) AS missing_order_item_id,
		COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
		COUNT(*) FILTER (WHERE seller_id IS NULL) AS missing_seller_id,
		COUNT(*) FILTER (WHERE shipping_limit_date IS NULL ) AS missing_shipping_limit_date,
		COUNT(*) FILTER (WHERE price IS NULL) AS missing_price,
		COUNT(*) FILTER (WHERE freight_value IS NULL) AS missing_freight_value
FROM olist_order_items 
;

--MISSING VALUE IN olist_orders:
SELECT 
		COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
		COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
		COUNT(*) FILTER (WHERE order_status IS NULL) AS missing_order_status_id,
		COUNT(*) FILTER (WHERE order_purchase_timestamp IS NULL) AS missing_order_purchase_timstamp,
		COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS missing_order_approved_at,
		COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS missing_order_delivered_carrier_date,
		COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS missing_order_delivered_customer_date,
		COUNT(*) FILTER (WHERE order_estimated_delivery_date IS NULL) AS missing_order_estimated_delivery_date
FROM olist_orders
;

--MISSING VALUE IN olist_products:
SELECT 
		COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
		COUNT(*) FILTER (WHERE product_category_name IS NULL) AS missing_product_category_name
FROM olist_products
;


--DUPLICATES IN olist_customers :
SELECT 
		customer_id,
		COUNT(*) AS occur
FROM olist_customers
GROUP BY customer_id
HAVING COUNT(*) > 1
;

--DUPLICATES IN olist_order_items:
SELECT 
		order_id,
		order_item_id,
		COUNT(*) AS occur
FROM olist_order_items
GROUP BY order_id,
		order_item_id
HAVING COUNT(*) >1
;

--DUPLICATES IN olist_orders:
SELECT
		order_id,
		count(*) AS occur
FROM olist_orders
GROUP BY order_id
HAVING COUNT(*) >1 
;

--DUPLICATES IN olist_products:
SELECT 
		product_id,
		COUNT(*) AS occur
FROM olist_products
GROUP BY product_id
HAVING COUNT(*) >1
;



--Order items without a matching order:
SELECT COUNT(*)
FROM olist_order_items AS oi
LEFT JOIN olist_orders AS o
		ON oi.order_id = o.order_id
WHERE oi.order_id IS NULL ;

--Order item without a mating customer record :
SELECT COUNT(*)
FROM olist_orders AS oo
LEFT JOIN olist_customers AS C
		ON oo.customer_id = c.customer_id
WHERE oo.order_id IS NULL
;

--What order statuses are available?
SELECT order_status,
		COUNT(*) AS total_order
FROM olist_orders
GROUP BY order_status
ORDER BY total_order DESC
;


--What dates does the dataset cover?
SELECT 
	MIN(order_purchase_timestamp):: DATE AS first_order_date,
	MAX(order_purchase_timestamp):: DATE AS last_order_date
FROM olist_orders
;


--Check invalid or suspicious prices
SELECT 
		COUNT(*) FILTER (WHERE price < 0 ) AS negative_price,
		COUNT(*) FILTER (WHERE freight_value < 0 ) AS negative_freight_value,
		COUNT(*) FILTER (WHERE price = 0 ) AS zero_price,
		COUNT(*) FILTER (WHERE freight_value = 0 ) AS zero_freight_value
FROM olist_order_items
;



SELECT * FROM olist_order_items
SELECT * FROM olist_products