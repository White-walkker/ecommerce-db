USE ecommerce_db;

-- =====================================================
-- QUERY 1: Top 5 best selling products
-- What it does: counts how many times each product
-- was ordered and sorts by highest first
-- Joins: order_items + products
-- =====================================================
SELECT
    p.name                    AS product_name,
    SUM(oi.quantity)          AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_units_sold DESC
LIMIT 5;

-- =====================================================
-- QUERY 2: Revenue by category
-- What it does: shows which category makes most money
-- Joins: order_items + products + categories
-- =====================================================
SELECT
    c.name            AS category,
    COUNT(DISTINCT o.order_id)       AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products  p  ON oi.product_id  = p.product_id
JOIN categories c ON p.category_id  = c.category_id
JOIN orders     o ON oi.order_id    = o.order_id
WHERE o.status != 'cancelled'
GROUP BY c.category_id, c.name
ORDER BY total_revenue DESC;

-- =====================================================
-- QUERY 3: Customer lifetime value
-- What it does: total money each customer has spent
-- This is one of the most common business queries
-- =====================================================
SELECT
    u.name                        AS customer_name,
    u.email                       AS email,
    COUNT(o.order_id)             AS total_orders,
    SUM(o.total_amount)           AS lifetime_value
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.status != 'cancelled'
GROUP BY u.user_id, u.name, u.email
ORDER BY lifetime_value DESC;

-- =====================================================
-- QUERY 4: Orders paid but NOT yet shipped
-- What it does: finds orders stuck after payment
-- Real use: operations team uses this to find delays
-- =====================================================
SELECT
    o.order_id,
    u.name          AS customer_name,
    o.total_amount,
    o.status,
    p.paid_at,
    o.created_at
FROM orders o
JOIN users    u ON o.user_id   = u.user_id
JOIN payments p ON o.order_id  = p.order_id
WHERE o.status = 'paid'
  AND p.status = 'success';

-- =====================================================
-- QUERY 5: Low stock alert
-- What it does: finds products running out of stock
-- Real use: warehouse team gets notified to reorder
-- =====================================================
SELECT
    p.name          AS product_name,
    c.name          AS category,
    p.stock_qty     AS remaining_stock,
    p.price
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE p.stock_qty < 50
ORDER BY p.stock_qty ASC;

-- =====================================================
-- QUERY 6: Monthly revenue report
-- What it does: breaks down revenue month by month
-- Real use: shown on business dashboards
-- =====================================================
SELECT
    MONTHNAME(o.created_at)   AS month,
    YEAR(o.created_at)        AS year,
    COUNT(o.order_id)         AS total_orders,
    SUM(o.total_amount)       AS monthly_revenue
FROM orders o
WHERE o.status != 'cancelled'
GROUP BY YEAR(o.created_at), MONTH(o.created_at), MONTHNAME(o.created_at)
ORDER BY YEAR(o.created_at), MONTH(o.created_at);

-- =====================================================
-- QUERY 7: Most valuable customers (VIP list)
-- What it does: finds customers who spent over 50000
-- Real use: send them special offers / discounts
-- =====================================================
SELECT
    u.name                  AS customer_name,
    u.email,
    u.phone,
    SUM(o.total_amount)     AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.status != 'cancelled'
GROUP BY u.user_id, u.name, u.email, u.phone
HAVING total_spent > 50000
ORDER BY total_spent DESC;