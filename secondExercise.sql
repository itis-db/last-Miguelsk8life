WITH customer_stats AS (
    SELECT
        o.customer_id,
        o.id AS order_id,
        o.order_date,
        SUM(oi.amount) AS order_total,
        AVG(SUM(oi.amount)) OVER (PARTITION BY o.customer_id) AS avg_order_amount,
        SUM(SUM(oi.amount)) OVER (PARTITION BY o.customer_id) AS total_spent
    FROM
        orders o
            JOIN
        order_items oi ON o.id = oi.order_id
    GROUP BY
        o.customer_id, o.id, o.order_date
)
SELECT
    customer_id,
    order_id,
    order_date,
    order_total,
    total_spent,
    ROUND(avg_order_amount, 2) AS avg_order_amount,
    ROUND(order_total - avg_order_amount, 2) AS difference_from_avg
FROM
    customer_stats
ORDER BY
    customer_id, order_date;