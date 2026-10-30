# Brazilian E-Commerce SQL Analysis

## Project Overview

This project analyzes the Brazilian E-Commerce Public Dataset by Olist using PostgreSQL. The goal is to understand order performance, product revenue, customer behavior, and sales trends through SQL queries.

## Business Objectives

- Measure overall order and delivery performance.
- Identify high-revenue products and product categories.
- Analyze customer and geographic patterns.
- Examine monthly revenue trends.
- Identify products that have never been ordered.
- Check data quality and validate relationships between tables.

## Dataset

Source: [Brazilian E-Commerce Public Dataset by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains anonymized e-commerce records, including orders, customers, products, and order items.

## Tools Used

- PostgreSQL
- pgAdmin
- GitHub

## Data Validation

Validation checks included:

- Table row counts
- Missing values
- Duplicate identifiers
- Unmatched records between related tables
- Order status and date range
- Suspicious prices and freight values

**Results:** Replace this sentence with the actual results of your validation checks.

## SQL Business Analysis

The project investigates 15 business questions, including:

1. Total orders
2. Delivered orders
3. Delivery rate
4. Total product revenue from delivered orders
5. Total freight value
6. Average order value
7. Revenue by product category
8. Top 10 products by revenue
9. Revenue by customer state
10. Top cities by customer count
11. Number of unique customers who ordered
12. Repeat customers
13. Monthly revenue trend
14. Order counts by status
15. Products never ordered

## Key Business Insights

Add 3–5 findings based on your actual query results.

- **Finding 1:** Add your measured result and explain what it means.
- **Finding 2:** Identify an important product or category trend.
- **Finding 3:** Describe a customer or geographic pattern.
- **Finding 4:** Summarize the monthly revenue trend.
- **Finding 5:** Record any meaningful data-quality finding.

## Repository Contents

- `01_data_validation.sql` — data-quality checks
- `02_business_analysis.sql` — business analysis queries
- `data_quality_notes.md` — validation findings
- `data_validation_result.png` — selected query and result screenshots
- `business_analysis_result.png` — selected query and result screenshots

## How to Run

1. Download and extract the dataset from Kaggle.
2. Create a PostgreSQL database.
3. Import the required CSV files into tables.
4. Update table names in the SQL scripts if necessary.
5. Run `01_data_validation.sql`.
6. Run `02_business_analysis.sql`.

## Limitations

This project analyzes the supplied dataset and does not establish causal relationships. Product revenue is not the same as profit, because complete business cost data is not available in the selected tables.

## Author

Add your name and your LinkedIn profile link here.
