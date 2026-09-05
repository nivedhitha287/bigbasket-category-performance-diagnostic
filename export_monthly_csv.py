import sqlite3
import csv

conn = sqlite3.connect("bigbasket_capstone.db")
cur = conn.cursor()

query = """
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
"""

rows = cur.execute(query).fetchall()

with open("monthly_category_revenue.csv", "w", newline="") as file:
    writer = csv.writer(file)
    writer.writerow(
        ["category", "month", "order_count", "total_revenue", "avg_revenue"]
    )
    writer.writerows(rows)

total_revenue = sum(row[3] for row in rows)

print("monthly_category_revenue.csv created.")
print("Number of rows:", len(rows))
print("Grand total revenue:", total_revenue)

conn.close()