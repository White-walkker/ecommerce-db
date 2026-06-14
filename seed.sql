USE ecommerce_db;

-- =====================
-- categories (insert first, products depend on it)
-- =====================
INSERT INTO categories (name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen'),
('Sports');

-- =====================
-- users
-- =====================
INSERT INTO users (name, email, phone) VALUES
('Rahul Sharma',   'rahul.sharma@gmail.com',  '9876543210'),
('Priya Patel',    'priya.patel@gmail.com',   '9123456780'),
('Amit Verma',     'amit.verma@gmail.com',    '9988776655'),
('Sneha Iyer',     'sneha.iyer@gmail.com',    '9871234560'),
('Rohan Mehta',    'rohan.mehta@gmail.com',   '9765432109'),
('Anjali Singh',   'anjali.singh@gmail.com',  '9654321098'),
('Vikram Nair',    'vikram.nair@gmail.com',   '9543210987'),
('Pooja Gupta',    'pooja.gupta@gmail.com',   '9432109876'),
('Arjun Das',      'arjun.das@gmail.com',     '9321098765'),
('Neha Joshi',     'neha.joshi@gmail.com',    '9210987654');

-- =====================
-- products
-- =====================
INSERT INTO products (category_id, name, price, stock_qty) VALUES
(1, 'Samsung Galaxy S24',        65000.00, 50),
(1, 'OnePlus Nord 4',            28000.00, 80),
(1, 'Sony WH-1000XM5 Headphones',29000.00, 30),
(1, 'Apple iPad Air',            60000.00, 25),
(2, 'Nike Dri-FIT T-Shirt',        999.00, 200),
(2, 'Levi\'s 511 Slim Jeans',     3499.00, 150),
(2, 'Adidas Running Shoes',       4999.00, 100),
(3, 'Clean Code - Robert Martin', 799.00, 120),
(3, 'System Design Interview',    899.00,  90),
(4, 'Prestige Pressure Cooker',  2499.00,  60),
(4, 'Philips Air Fryer',         6999.00,  40),
(5, 'Skipping Rope',              499.00, 300),
(5, 'Yoga Mat',                  1299.00, 180);

-- =====================
-- orders
-- =====================
INSERT INTO orders (user_id, total_amount, status) VALUES
(1,  65000.00, 'delivered'),
(2,   4498.00, 'delivered'),
(3,  29000.00, 'shipped'),
(4,   3499.00, 'delivered'),
(5,  60000.00, 'paid'),
(6,   1698.00, 'delivered'),
(7,  28000.00, 'shipped'),
(8,   6999.00, 'pending'),
(9,  65999.00, 'delivered'),
(10,  2499.00, 'paid'),
(1,   4999.00, 'delivered'),
(2,  29000.00, 'cancelled'),
(3,   1299.00, 'delivered'),
(4,  60000.00, 'shipped'),
(5,    999.00, 'pending');

-- =====================
-- order_items
-- =====================
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1,  1, 1, 65000.00),
(2,  5, 2,   999.00),
(2,  6, 1,  3499.00),
(3,  3, 1, 29000.00),
(4,  6, 1,  3499.00),
(5,  4, 1, 60000.00),
(6,  8, 1,   799.00),
(6,  9, 1,   899.00),
(7,  2, 1, 28000.00),
(8, 11, 1,  6999.00),
(9,  1, 1, 65000.00),
(9,  8, 1,   799.00),
(10,10, 1,  2499.00),
(11, 7, 1,  4999.00),
(12, 3, 1, 29000.00),
(13,12, 1,  1299.00),
(14, 4, 1, 60000.00),
(15, 5, 1,   999.00);

-- =====================
-- payments
-- =====================
INSERT INTO payments (order_id, amount, method, status, paid_at) VALUES
(1,  65000.00, 'card',       'success', '2024-01-15 10:30:00'),
(2,   4498.00, 'upi',        'success', '2024-01-20 14:15:00'),
(3,  29000.00, 'netbanking', 'success', '2024-02-01 09:00:00'),
(4,   3499.00, 'upi',        'success', '2024-02-10 11:45:00'),
(5,  60000.00, 'card',       'success', '2024-02-14 16:20:00'),
(6,   1698.00, 'cod',        'success', '2024-02-20 12:00:00'),
(7,  28000.00, 'card',       'success', '2024-03-01 10:10:00'),
(9,  65999.00, 'card',       'success', '2024-03-10 13:30:00'),
(10,  2499.00, 'upi',        'success', '2024-03-15 15:00:00'),
(11,  4999.00, 'upi',        'success', '2024-03-20 09:45:00'),
(13,  1299.00, 'cod',        'success', '2024-04-01 11:00:00');