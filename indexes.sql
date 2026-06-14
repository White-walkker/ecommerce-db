USE ecommerce_db;

-- =====================================================
-- WHY INDEXES?
-- Without index: MySQL scans EVERY row (slow)
-- With index: MySQL jumps directly to the row (fast)
-- Think of it like a book index vs reading every page
-- =====================================================

-- Index on users.email
-- WHY: every login query searches by email
-- Without this, MySQL scans all 10 (or 10 million) users
CREATE INDEX idx_users_email ON users(email);

-- Index on orders.user_id
-- WHY: "show my orders" is the most common query in any app
-- This makes JOIN between users and orders fast
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Index on orders.status
-- WHY: ops team constantly filters by status
-- "show all pending orders", "show all shipped orders"
CREATE INDEX idx_orders_status ON orders(status);

-- Index on order_items.order_id
-- WHY: every time you open an order, it fetches all its items
-- This JOIN is called millions of times in a real app
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Index on order_items.product_id
-- WHY: "how many times was this product ordered?" needs this
-- Used in sales reports and inventory checks
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Index on products.category_id
-- WHY: "show all electronics" filters by category_id
-- Every product listing page uses this
CREATE INDEX idx_products_category_id ON products(category_id);

-- Index on payments.order_id
-- WHY: checking payment status for an order is very frequent
-- "was this order paid?" runs on every order detail page
CREATE INDEX idx_payments_order_id ON payments(order_id);

-- Verify all indexes were created
SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'ecommerce_db'
  AND INDEX_NAME != 'PRIMARY'
ORDER BY TABLE_NAME;