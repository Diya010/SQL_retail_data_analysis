-- Active: 1783158560845@@127.0.0.1@3306@retail_db
CREATE DATABASE IF NOT EXISTS Retail_DB;
USE Retail_DB;

SELECT * FROM retail
LIMIT 10;

SELECT COUNT(*) FROM retail;

--data cleaning
SELECT * FROM retail
WHERE transactions_id IS NULL;

SELECT * FROM retail
WHERE sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

--
DELETE FROM retail
WHERE transactions_id IS NULL 
OR 
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

--data exploration

--how many sales we have?
SELECT COUNT(*) AS total_sale FROM retail; 

--how many unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail;

SELECT DISTINCT category FROM retail;

--data analysis & business key problems & answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail
WHERE category = 'Clothing'
AND 
DATE_FORMAT(sale_date, 'YYYY-MM') = '2022-11'
AND 
quantiy >= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) and total orders for each category.
SELECT category,
       SUM(total_sale) AS total_purchase,
       COUNT(*) AS total_orders
FROM retail
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) AS average_age
FROM retail
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender,
    COUNT(*) AS 'total_transaction'
FROM retail
GROUP BY category, gender
ORDER BY category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT year, month, avg_sale
FROM
(
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS monthly_rank
FROM retail
GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1
WHERE monthly_rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,
       SUM(total_sale) AS total_sales
FROM retail
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) AS count_of_unique_customers
FROM retail
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales
AS
(
SELECT *,
       CASE
       WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
       WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 15 AND 17 THEN 'Afternoon'
       ELSE 'Evening'
       END AS shift
FROM retail
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;