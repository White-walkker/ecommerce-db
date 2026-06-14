# E-Commerce Order Management — MySQL Database

![MySQL](https://img.shields.io/badge/MySQL-9.6-blue)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow)

A production-style relational database designed for an e-commerce platform.  
This covers everything from schema design to business intelligence queries — built to demonstrate real-world database engineering skills.

## What This Covers

- Designed a normalized relational schema from scratch with 6 interconnected tables
- Enforced data integrity using foreign keys, constraints, and CHECK rules
- Wrote 7 real business queries used by operations, finance, and product teams
- Added strategic indexes with documented reasoning for every single one
- Seeded realistic data simulating 10 customers, 13 products, and 15 orders

## Schema Design
users
└── orders
└── users
└── order_items
└── products
└── categories
orders
└── payments

### Table Overview

| Table | Purpose | Key Columns |
|---|---|---|
| `users` | Customer accounts | user_id, email (UNIQUE), phone |
| `categories` | Product groupings | category_id, name (UNIQUE) |
| `products` | Product catalog | product_id, price, stock_qty |
| `orders` | Order headers | order_id, user_id, status, total_amount |
| `order_items` | Line items per order | order_id, product_id, quantity, unit_price |
| `payments` | Payment records | order_id (UNIQUE), method, status, paid_at |

### Design Decisions

**Why is `unit_price` stored in `order_items`?**  
Product prices change over time. Storing the price at time of purchase in `order_items` ensures historical accuracy — a critical requirement in any real e-commerce system.

**Why does `payments.order_id` have a UNIQUE constraint?**  
One order should only ever have one payment record. The UNIQUE constraint enforces this at the database level, not just the application level.

**Why `InnoDB` engine?**  
InnoDB is the only MySQL engine that supports foreign keys and transactions — both essential for financial data integrity.

## Business Queries

### 1. Top 5 Best Selling Products
Ranks products by units sold and revenue generated.  
Used by: product and inventory teams.

### 2. Revenue by Category
Shows which product categories generate the most money.  
Used by: business and merchandising teams.

### 3. Customer Lifetime Value
Total amount spent per customer across all orders.  
Used by: marketing teams to identify loyal customers.

### 4. Orders Paid but Not Shipped
Finds orders where payment succeeded but shipping hasn't started.  
Used by: operations teams to catch fulfillment delays.

### 5. Low Stock Alert
Products with fewer than 50 units remaining.  
Used by: warehouse teams to trigger reorders.

### 6. Monthly Revenue Report
Month-by-month revenue breakdown.  
Used by: finance teams and executive dashboards.

### 7. VIP Customer List
Customers who have spent over ₹50,000 in total.  
Used by: CRM teams to send special offers.

## Indexes

Every index here has a documented reason.

| Index | Table | Column | Why |

| `idx_users_email` | users | email | Every login query searches by email |
| `idx_orders_user_id` | orders | user_id | "My Orders" page runs this JOIN millions of times |
| `idx_orders_status` | orders | status | Ops team constantly filters pending/shipped/delivered |
| `idx_order_items_order_id` | order_items | order_id | Fetching items per order is the most frequent query |
| `idx_order_items_product_id` | order_items | product_id | Sales reports group by product |
| `idx_products_category_id` | products | category_id | Every product listing page filters by category |
| `idx_payments_order_id` | payments | order_id | Payment status is checked on every order detail page |

---

## Sample Data

| Entity | Count |
| Users | 10 |
| Categories | 5 |
| Products | 13 |
| Orders | 15 |
| Order Items | 18 |
| Payments | 11 |

### Prerequisites
- MySQL 8.0 or above
- MySQL CLI or SQLTools extension in VS Code


**Schema Design**
- Third normal form (3NF) normalization
- One-to-many and one-to-one relationships
- Referential integrity via foreign keys

**Data Integrity**
- NOT NULL on all required fields
- UNIQUE constraints on emails and payment records
- CHECK constraints on prices, quantities, and status values
- DEFAULT values for status fields and timestamps

**Query Writing**
- INNER JOIN across 3-4 tables
- GROUP BY with aggregate functions (SUM, COUNT)
- HAVING clause for post-aggregation filtering
- ORDER BY and LIMIT for ranking

**Performance**
- Indexes on all foreign key columns
- Indexes on columns used in WHERE and GROUP BY clauses

## File Structure
ecommerce-db/
├── schema.sql      ← Table definitions with all constraints
├── seed.sql        ← Realistic dummy data
├── queries.sql     ← 7 business queries with comments
├── indexes.sql     ← Indexes with documented reasoning
└── README.md       ← This file