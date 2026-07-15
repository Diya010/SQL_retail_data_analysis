# SQL_retail_data_analysis

A SQL project analyzing transactional retail sales data to uncover customer behavior, 
category performance, and sales trend insights — the kind of analysis a retail business 
would use to make pricing, staffing, and marketing decisions.

## Dataset

The dataset (`retail_sales.csv`) contains 2,000 transaction-level records with fields:

- `transactions_id` – unique transaction identifier
- `sale_date`, `sale_time` – when the sale occurred
- `customer_id`, `gender`, `age` – customer details
- `category` – product category (Clothing, Beauty, Electronics)
- `quantiy` – units sold *(note: this typo exists in the raw source column and is preserved for SQL compatibility)*
- `price_per_unit` – price per unit sold
- `cogs` – cost of goods sold
- `total_sale` – total transaction value

## Data Cleaning

- Checked for and removed rows with NULL values across all key columns 
  (`sale_date`, `customer_id`, `category`, `quantiy`, `price_per_unit`, `cogs`, `total_sale`, etc.)
- Verified no duplicate/NULL `transactions_id` values remained
- Confirmed distinct category values before analysis

## Business Questions Answered

1. Retrieve all sales made on a specific date
2. Find high-volume Clothing transactions in a given month
3. Total sales and order count per category
4. Average customer age for the Beauty category
5. High-value transactions (total_sale > 1000)
6. Transaction count by gender within each category
7. Best-selling month in each year (using window functions)
8. Top 5 customers by total spend
9. Unique customer count per category
10. Sales distribution across Morning / Afternoon / Evening shifts (using CTEs)

## Tools & Concepts Used

- SQL (MySQL)
- Aggregate functions (`SUM`, `COUNT`, `AVG`)
- Window functions (`RANK() OVER PARTITION BY`)
- CTEs (`WITH` clause)
- `CASE WHEN` logic
- Date/time functions (`YEAR()`, `MONTH()`, `EXTRACT(HOUR FROM ...)`)


## Key Insights

- **Electronics leads revenue, but only barely.** Electronics (₹3,11,445), Clothing 
  (₹3,09,995), and Beauty (₹2,86,790) are nearly tied — no single category dominates, 
  so category-level marketing spend should stay balanced rather than concentrated.
- **Evening is the peak shopping window.** Over half of all transactions (1,062 of 2,000) 
  happen in the Evening shift, far more than Morning (548) or Afternoon (377).
- **Customer base is small but valuable.** Only 155 unique customers generated all 2,000 
  transactions — averaging ~13 purchases per customer — meaning repeat-customer retention 
  matters more here than new customer acquisition.
- **Top 5 customers are disproportionately valuable.** The single highest-spending customer 
  contributed ₹38,440 — nearly 4.2% of total revenue.
- **Seasonality varies by year.** The best-performing month shifted from July in 2022 to 
  February in 2023, suggesting sales patterns aren't fixed to a single "peak season" and 
  should be re-evaluated periodically rather than assumed.
