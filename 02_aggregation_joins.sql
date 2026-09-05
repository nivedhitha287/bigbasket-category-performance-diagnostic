-- 1. Revenue by category for Delivered orders only
SELECT
    p.category,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders AS o
INNER JOIN products AS p
ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
HAVING SUM(o.amount_inr) > 10000
ORDER BY total_revenue DESC;


-- 2. Order count for every product, including products with zero orders
SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(o.order_id) AS total_orders
FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_orders ASC, p.product_name ASC;