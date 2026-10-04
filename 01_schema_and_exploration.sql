-- =============================================================================
-- OLIST BRAZILIAN E-COMMERCE: DATASET EXPLORATION & SCHEMA SANITY CHECKS
-- File: 01_schema_and_exploration.sql
-- Description: Initial table verification, row counts, and structural integrity.
-- =============================================================================

-- 1. Total Orders Count Verification
SELECT COUNT(*) AS total_orders 
FROM olist_orders_dataset;

-- 2. Executive Order Status Breakdown & Distribution (%)
SELECT 
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset), 2) AS status_percentage
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

-- 3. Geographic Concentration of Customers (State-wise)
SELECT 
    customer_state,
    COUNT(customer_id) AS total_customers,
    ROUND(COUNT(customer_id) * 100.0 / (SELECT COUNT(*) FROM olist_customers_dataset), 2) AS customer_percentage
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;

-- 4. Seller Ecosystem Sanity Check
SELECT 
    seller_state,
    COUNT(seller_id) AS total_sellers
FROM olist_sellers_dataset
GROUP BY seller_state
ORDER BY total_sellers DESC
LIMIT 5;
