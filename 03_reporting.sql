-- 1. Product revenue tier: High, Medium, or Low
SELECT
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(
        CASE
            WHEN o.status = 'Delivered' THEN o.amount_inr
            ELSE 0
        END
    ), 0) AS total_revenue,

    CASE
        WHEN COALESCE(SUM(
            CASE
                WHEN o.status = 'Delivered' THEN o.amount_inr
                ELSE 0
            END
        ), 0) >= 3000 THEN 'High'

        WHEN COALESCE(SUM(
            CASE
                WHEN o.status = 'Delivered' THEN o.amount_inr
                ELSE 0
            END
        ), 0) >= 1000 THEN 'Medium'

        ELSE 'Low'
    END AS revenue_tier

FROM products AS p
LEFT JOIN orders AS o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;


-- 2. Monthly revenue by category
SELECT
    p.category AS category,
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders AS o
INNER JOIN products AS p
ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY
    p.category,
    strftime('%Y-%m', o.order_date)
ORDER BY p.category, month;


-- 3. Compare category revenue with target
WITH category_revenue AS (
    SELECT
        p.category,
        SUM(o.amount_inr) AS total_revenue
    FROM orders AS o
    INNER JOIN products AS p
    ON o.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY p.category
)

SELECT
    ct.category,
    cr.total_revenue,
    ct.target_revenue_inr,
    ct.target_revenue_inr - cr.total_revenue AS variance,

    ((cr.total_revenue - ct.target_revenue_inr) * 100.0)
    / ct.target_revenue_inr AS percentage_variance,

    CASE
        WHEN cr.total_revenue >= ct.target_revenue_inr
            THEN 'Above Target'

        WHEN ((cr.total_revenue - ct.target_revenue_inr) * 100.0)
             / ct.target_revenue_inr >= -15
            THEN 'Below Target - Watch'

        ELSE 'Below Target - Critical'
    END AS performance_tag

FROM category_targets AS ct
INNER JOIN category_revenue AS cr
ON ct.category = cr.category
ORDER BY cr.total_revenue DESC;