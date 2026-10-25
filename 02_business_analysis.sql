--How many total orders exist?
SELECT 
	COUNT(DISTINCT(order_id))
FROM olist_orders
;

--How many delivered orders exist?	
SELECT 
	COUNT(*)
FROM olist_orders
WHERE order_status = 'delivered'
;

--What percentage of orders were delivered?	
SELECT
		ROUND(100.0 * (
				SELECT 
						COUNT(*)
				FROM olist_orders
				WHERE order_status = 'delivered'
				):: NUMERIC
		/
		COUNT(order_status), 2)
		AS pect_of_delivered_order
FROM olist_orders
;

--What is the total product revenue from delivered orders?	
SELECT 
	op.product_category_name,
	oo.order_status, 
	SUM(oi.price) AS total_revenue
FROM olist_orders AS oo

INNER JOIN olist_order_items AS oi
		ON oo.order_id = oi.order_id
		
INNER JOIN olist_products  AS op
		ON op.product_id = oi.product_id
GROUP BY op.product_category_name, oo.order_status
HAVING oo.order_status = 'delivered'
		AND 
		op.product_category_name IS NOT NULL
;


--What is the total freight value for delivered orders?	
SELECT 
	oo.order_status, 
	SUM(oi.freight_value) AS total_freight_value
FROM olist_orders AS oo
INNER JOIN olist_order_items AS oi
		ON oo.order_id = oi.order_id
GROUP BY oo.order_status
HAVING order_status = 'delivered'
;

--What is the average product value per delivered order?
SELECT 
		op.product_category_name,
		oo.order_status,
		AVG(oi.price) AS avg_price
FROM olist_orders AS oo

INNER JOIN olist_order_items AS oi
		ON oo.order_id = oi.order_id

INNER JOIN olist_products AS op
		ON op.product_id = oi.product_id

GROUP BY op.product_category_name,
		oo.order_status
HAVING oo.order_status = 'delivered' 
		AND 
		op.product_category_name IS NOT NULL
;


--Which product categories generate the most revenue?	
SELECT op.product_category_name, SUM(oi.price) AS price
FROM olist_products	AS op 
INNER JOIN olist_order_items AS oi
		ON op.product_id = oi.product_id
GROUP BY op.product_category_name
ORDER BY price DESC
LIMIT 1
;


--Which 10 products generate the most revenue?
SELECT op.product_category_name, SUM(oi.price) AS price
FROM olist_order_items AS oi
INNER JOIN olist_products AS op
		ON oi.product_id = op.product_id
GROUP BY op.product_category_name
ORDER BY price DESC
LIMIT 10
;



-- Which states have the highest delivered-order revenue?
SELECT oc.customer_state, oo.order_status, SUM(oi.price) AS Price
FROM olist_customers AS oc

INNER JOIN olist_orders AS oo
		ON oc.customer_id = oo.customer_id

INNER JOIN olist_order_items AS oi
		ON oo.order_id = oi.order_id

GROUP BY oc.customer_state, oo.order_status
HAVING oo.order_status = 'delivered'
ORDER BY Price DESC
LIMIT 1
;


-- Which cities have the most customers?	
SELECT customer_city, COUNT(DISTINCT(customer_id)) AS customer_count
FROM olist_customers
GROUP BY customer_city
ORDER BY customer_count DESC
;


--How many unique customers placed orders?
SELECT COUNT(DISTINCT(oc.customer_unique_id)) AS unique_customer
FROM olist_customers AS oc
INNER JOIN olist_orders AS oo
		ON oc.customer_id = oo.customer_id 
WHERE order_purchase_timestamp IS NOT NULL
;




-- How many customers placed more than one order?	GROUP BY, HAVING
SELECT customer_id, COUNT(customer_id) AS order_morethan_one
FROM olist_orders
GROUP BY customer_id
HAVING COUNT(customer_id) > 1
;



--What is the monthly revenue trend?	Date functions, GROUP BY
SELECT 
		EXTRACT(MONTH FROM oo.order_purchase_timestamp) AS month,
		SUM(oi.price) AS revenue
FROM olist_orders AS oo
INNER JOIN olist_order_items AS oi
		ON oi.order_id = oo.order_id
GROUP BY EXTRACT(MONTH FROM oo.order_purchase_timestamp)
ORDER BY month ASC
;






--Which order statuses have the highest cancellation counts?	GROUP BY, conditional analysis
SELECT 
		order_id,
		order_status,
		COUNT(order_status)		
FROM olist_orders AS oo
GROUP BY order_id , order_status
HAVING order_status = 'canceled'
ORDER BY COUNT(order_status) DESC
LIMIT 1
;

--Which products have never appeared in an order?	LEFT JOIN, IS NULL
SELECT 
    op.product_id, 
    op.product_category_name 
FROM olist_products AS op 
LEFT JOIN olist_order_items AS oi 
    ON op.product_id = oi.product_id 
WHERE oi.order_id IS NULL;








