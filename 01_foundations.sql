-- 1. WHERE: delivered orders from Bengaluru
SELECT o.*
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.city = 'Bengaluru'
AND o.status = 'Delivered';


-- 2. DISTINCT: list every category
SELECT DISTINCT category
FROM products;


-- 3. ORDER BY + LIMIT: top 5 highest-value orders
SELECT order_id, amount_inr, status
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;


-- 4. AS: count all orders
SELECT COUNT(*) AS total_orders
FROM orders;


-- 5. IN: UPI or Credit Card orders
SELECT *
FROM orders
WHERE payment_mode IN ('UPI', 'Credit Card');


-- 6. BETWEEN: orders from INR 100 to INR 300
SELECT *
FROM orders
WHERE amount_inr BETWEEN 100 AND 300;


-- 7. NOT BETWEEN: orders outside INR 100 to INR 300
SELECT *
FROM orders
WHERE amount_inr NOT BETWEEN 100 AND 300;


-- 8. IS NULL: orders without ratings
SELECT *
FROM orders
WHERE rating IS NULL;