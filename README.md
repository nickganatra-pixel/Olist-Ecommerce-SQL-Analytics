# 📊 Olist E-Commerce SQL Analytics Portfolio

## 🚀 Executive Summary
This repository presents an end-to-end SQL data analysis of **Olist**, the largest e-commerce marketplace in Brazil (100k+ orders from 2016 to 2018). The project translates core e-commerce business requirements into production-ready SQL queries across **Logistics, Financial Revenue, Marketing Trends, and Product Performance**.

---

## 🛠️ Tech Stack & SQL Skills Demonstrated
* **Database Engine:** MySQL Server 8.0 / MySQL Workbench
* **SQL Constructs Used:** Multi-Table `INNER JOIN`, Aggregations (`COUNT`, `SUM`, `AVG`), Date Functions (`DATEDIFF`, `DATE_FORMAT`, `HOUR`), Conditional Logic (`CASE WHEN`), Data Filtering (`WHERE` vs `HAVING`), Subqueries.

---

## 📌 Key Business Insights & Findings

1. **Geographic Revenue Risk:**
   * **São Paulo (`SP`)** represents over **40% of overall delivered order volume** and total platform revenue. 
   * **Recommendation:** Expand fulfillment centers in the SP region while upgrading regional courier agreements in northern states (e.g., `AP`, `RR`) where delivery lead times average over 20 days.

2. **Payment Method Breakdown:**
   * **Credit Card** drives over **75% of total revenue**, with high reliance on installments (>3 terms).
   * **Recommendation:** Introduce targeted promotions for instant payment methods (Boleto/Debit) to improve platform cash flow.

3. **Peak Shopping Behavior:**
   * Peak order traffic occurs during **Afternoon (12 PM - 6 PM)** and **Evening (6 PM - 12 AM)** hours.
   * **Recommendation:** Schedule real-time promotional push notifications and ad campaigns between 2 PM and 8 PM for maximum ROI.

---

## 📁 Repository File Structure
* `01_schema_and_exploration.sql` — Database initialization, data integrity checks, and basic volume distributions.
* `02_business_analytics.sql` — Production-grade analytical queries categorized by business domains.

---
*Created by [Your Name] | Data Analyst Candidate*
