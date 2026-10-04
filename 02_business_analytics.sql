-- =============================================================================
-- OLIST BRAZILIAN E-COMMERCE: END-TO-END BUSINESS ANALYTICS
-- File: 02_business_analytics.sql
-- Modules Covered: Logistics, Revenue, Marketing, Product & Reviews
-- =============================================================================

-- =============================================================================
-- MODULE 1: LOGISTICS & SUPPLY CHAIN ANALYTICS
-- =============================================================================

-- Requirement 1.1: Top 5 States with Most Delayed Deliveries
-- Business Value: Identifies regional courier bottlenecks where actual delivery > estimated delivery.
SELECT 
    c.customer_state,
    COUNT(o.order_id) AS late_deliveries_count
FROM olist_customers_dataset c
INNER JOIN olist_orders_dataset o 
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY c.customer_state
ORDER BY late_deliveries_count DESC
LIMIT 5;

-- Requirement 1.2: State-wise Average Delivery Lead Time (in Days)
-- Business Value: Helps Operations team establish SLA benchmarks per region.
SELECT 
    c.customer_state,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)), 1) AS avg_delivery_days
FROM olist_customers_dataset c
INNER JOIN olist_orders_dataset o 
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC
LIMIT 10;


-- =============================================================================
-- MODULE 2: REVENUE, PAYMENTS & FINANCIAL METRICS
-- =============================================================================

-- Requirement 2.1: Revenue and Average Order Value (AOV) by Payment Type
-- Business Value: Evaluates payment method performance and financial share.
SELECT 
    payment_type,
    COUNT(order_id) AS total_transactions,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS avg_order_value
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Requirement 2.2: High Installment Orders Revenue (Risk & Finance Analysis)
-- Business Value: Tracks consumer financing reliance (>3 installments) on high-volume methods.
SELECT 
    payment_type,
    COUNT(order_id) AS high_installment_orders,
    ROUND(SUM(payment_value), 2) AS total_installment_revenue
FROM olist_order_payments_dataset
WHERE payment_installments > 3
GROUP BY payment_type
HAVING high_installment_orders > 1000
ORDER BY total_installment_revenue DESC;

-- Requirement 2.3: Top 5 Revenue Generating States (3-Table JOIN)
-- Business Value: Pinpoints high-value geographic markets for strategic expansion.
SELECT 
    c.customer_state,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM olist_customers_dataset c
INNER JOIN olist_orders_dataset o 
    ON c.customer_id = o.customer_id
INNER JOIN olist_order_payments_dataset p 
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 5;


-- =============================================================================
-- MODULE 3: MARKETING, SEASONALITY & CUSTOMER BEHAVIOR
-- =============================================================================

-- Requirement 3.1: Peak Order Purchase Time Slot (Day Part Categorization)
-- Business Value: Guides marketing team on optimal ad campaign delivery windows.
SELECT 
    CASE 
        WHEN HOUR(order_purchase_timestamp) BETWEEN 6 AND 11 THEN 'Morning (6 AM - 12 PM)'
        WHEN HOUR(order_purchase_timestamp) BETWEEN 12 AND 17 THEN 'Afternoon (12 PM - 6 PM)'
        WHEN HOUR(order_purchase_timestamp) BETWEEN 18 AND 23 THEN 'Evening (6 PM - 12 AM)'
        ELSE 'Night (12 AM - 6 AM)'
    END AS day_part,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY day_part
ORDER BY total_orders DESC;

-- Requirement 3.2: Monthly Order Volume & Sales Trend
-- Business Value: Uncovers seasonality spikes for inventory planning.
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY order_month
ORDER BY order_month ASC;


-- =============================================================================
-- MODULE 4: PRODUCT CATEGORIES & SELLER PERFORMANCE
-- =============================================================================

-- Requirement 4.1: Top 10 Revenue Generating Product Categories (Multi-Table JOIN)
-- Business Value: Focuses category management efforts on primary GMV drivers.
SELECT 
    t.product_category_name_english AS category_name,
    COUNT(oi.order_id) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS total_category_revenue
FROM olist_order_items_dataset oi
INNER JOIN olist_products_dataset p 
    ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation t 
    ON p.product_category_name = t.product_category_name
GROUP BY category_name
ORDER BY total_category_revenue DESC
LIMIT 10;

-- Requirement 4.2: Low Customer Rating Analysis by Category (<3.5 Avg Score)
-- Business Value: Flags high-risk product categories for quality control audits.
SELECT 
    t.product_category_name_english AS category_name,
    COUNT(r.review_id) AS review_count,
    ROUND(AVG(r.review_score), 2) AS avg_rating
FROM olist_order_items_dataset oi
INNER JOIN olist_products_dataset p 
    ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation t 
    ON p.product_category_name = t.product_category_name
INNER JOIN olist_order_reviews_dataset r 
    ON oi.order_id = r.order_id
GROUP BY category_name
HAVING review_count >= 100 AND avg_rating < 3.8
ORDER BY avg_rating ASC;
