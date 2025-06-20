SELECT
    p.category,
    SUM(oi.amount) AS total_sales,
    ROUND(SUM(oi.amount) / COUNT(DISTINCT o.id), 2) AS avg_per_order,
    ROUND(SUM(oi.amount) * 100.0 / (SELECT SUM(amount) FROM order_items), 2) AS category_share
FROM
    products p
        JOIN
    order_items oi ON p.id = oi.product_id
        JOIN
    orders o ON oi.order_id = o.id
GROUP BY
    p.category
ORDER BY
    total_sales DESC;
