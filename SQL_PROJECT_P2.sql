-- SQL Retail Sales Analysis -P1
-- CREATE DATABASE SQL_PROJECT_P2 NAME
	CREATE DATABASE SQL_PROJECT_P2;

-- CREATE TABLE retail_sales
-- USE DROP COMMAND BECAUSE IF TABLE EXIST THEN IT WILL DELET 
-- THEN AFTER CREATE TEBLE "retail_sales"
 	DROP TABLE IF EXISTS retail_sales;
 	CREATE TABLE retail_sales
		(
			transactions_id	INT,
			sale_date DATE,	
			sale_time TIME,	
			customer_id	INT,
			gender VARCHAR(15),
			age	INT,
			category VARCHAR(25),	
			quantiy	INT,
			price_per_unit INT,	
			cogs FLOAT,	
			total_sale FLOAT
		);

-- SHOW ALL DATA
	SELECT * FROM retail_sales;


-- SHOW ONLY 10 ROWS
	SELECT * FROM retail_sales
	limit 10;

-- COUNT THE NUMBER OF ROWS IN THIS CSV FILE 
	SELECT
		COUNT(*)
	FROM retail_sales;

-- FIND THE NULL VALUE IN transitions_id column
	SELECT * FROM retail_sales
	WHERE transactions_id IS NULL;

-- FIND THE NULL VALUE IN sale_date column
	SELECT * FROM retail_sales
	WHERE sale_date IS NULL;
	
-- FIND THE NULL VALUE IN sale_time column
	SELECT * FROM retail_sales
	WHERE sale_time IS NULL;
	
-- FIND THE NULL VALUE IN customer_id column
	SELECT * FROM retail_sales
	WHERE customer_id IS NULL;
	
-- FIND THE NULL VALUE IN gender column
	SELECT * FROM retail_sales
	WHERE gender IS NULL;

-- FIND THE NULL VALUE IN age column
	SELECT * FROM retail_sales
	WHERE age IS NULL;
	
-- FIND THE NULL VALUE IN category column
	SELECT * FROM retail_sales
	WHERE category IS NULL;
	
-- FIND THE NULL VALUE IN quantity column
	SELECT * FROM retail_sales
	WHERE quantiy IS NULL;

-- FIND THE NULL VALUE IN price_per_unit column
	SELECT * FROM retail_sales
	WHERE price_per_unit IS NULL;

-- FIND THE NULL VALUE IN cogs column
	SELECT * FROM retail_sales
	WHERE cogs IS NULL;

-- FIND THE NULL VALUE IN total_sale column
	SELECT * FROM retail_sales
	WHERE total_sale IS NULL;

-- FIND THE NULL VALUE IN transitions_id or age column
	SELECT * FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR 
		age IS NULL ;

-- FIND THE NULL VALUE IN ANY COLUMN transitions_id, sale_date, sale_time, customer_id, gender, age, category, quantiy, price_per_unit, cogs, total_sale column
	SELECT * FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time Is NUll
		OR
		customer_id IS NULL
		OR
		gender IS NULL
		OR
		age IS NULL
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

-- DATA CLEANING
-- DELETE THE NULL VALUES IF ANY COLUMN 
	DELETE FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR
		sale_date IS NULL
		OR
		sale_time Is NUll
		OR
		customer_id IS NULL
		OR
		gender IS NULL
		OR
		age IS NULL
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

-- DATA EXPLORATION 

-- HOW MANY SALES WE HAVE ?
	SELECT COUNT(*) AS total_sale FROM retail_sales; 
	
-- HOW MANY UNIQUE CUSTOMERS WE HAVE ?
	SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales;

-- HOW MANY UNIQUE CATEGORY WE HAVE ?
	SELECT COUNT(DISTINCT category) AS total_sale FROM retail_sales;

-- DATA ANALYSIS & BUSSINESS KEY PROBLEMS AND ANSWERS
-- MY ANALYSIS AND FINDINGS

-- Q1. WRITE A SQL QUERY TO RETREIEVE ALL COLUMN FOR SALES MADE ON '2022-11-05'.
	SELECT * 
	FROM retail_sales
	WHERE sale_date = '2022-11-05';

-- Q2.a. WRITE A SQL QUERY TO RETIEVE ALL TRANSCATIONS WHER THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THEN 10 IN THE MONTH OF NOV-2022.
	SELECT *
	FROM retail_sales
	WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM0') = '2022-11'
	AND quantiy >= 10;

-- Q2.b. WRITE A SQL QUERY TO RETIEVE ALL TRANSCATIONS WHER THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS LESS THEN 10 IN THE MONTH OF NOV-2022.

	SELECT *
	FROM retail_sales
	WHERE category = 'Clothing'
	  AND quantiy < 10
	  AND sale_date >= '2022-11-01' 
	  AND sale_date <= '2022-11-30';

-- Q3. WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES (total_sale) FOR EACH CATEGORY.
	SELECT 
	    category,
	    SUM(total_sale) AS net_sale, -- Comma added here
	    COUNT(*) AS total_transactions -- Renamed for clarity
	FROM retail_sales
	GROUP BY 1;
	
-- Q4. WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEM FROM THE 'BEAUTY' CATEGORY.
	SELECT 
		AVG(age) AS avg_age
	FROM retail_sales
	WHERE category = 'Beauty';

	SELECT 
		ROUND(AVG(age),2) AS avg_age
	FROM retail_sales
	WHERE category = 'Beauty';
	
-- Q5. WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE total_sales is greater then 1000.
	SELECT * FROM retail_sales
	WHERE total_sale > 1000

-- Q6. WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTION (transation_id) MADE BY EACH GENDER IN EACH CATEGORY.
	SELECT 
		category,
		gender,
		COUNT(*) AS total_trans
	FROM retail_sales
	GROUP BY
		category,
		gender
	ORDER BY 1;
		
			
-- Q7. WRITE A SQL QUERY TO CALCUALTE THE AVERAGE SALE FOR EACH MONTH, FIND OUT BEST SELLING MONTH IN EACHN YEAR.
	SELECT 
	    EXTRACT(YEAR FROM sale_date) as YEAR,
	    EXTRACT(MONTH FROM sale_date) as MONTH,
	    AVG(total_sale) AS average_sales  -- Added alias and removed extra FROM
	FROM retail_sales
	GROUP BY 1, 2
	ORDER BY 1, 2;
-- Q8. WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMER BASED ON THE HEIGHEST TOTAL SALES.
	SELECT
	    customer_id,
	    SUM(total_sale) AS total_spent
	FROM retail_sales
	GROUP BY customer_id
	ORDER BY total_spent DESC
	LIMIT 5;
-- Q9. WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEM FROM EACH CATEGORY.
	SELECT
	    category,
	    COUNT(DISTINCT customer_id) AS unique_customers
	FROM retail_sales
	GROUP BY category
	ORDER BY unique_customers DESC;

-- Q10. WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING<=12, AFTERNOON BETWEEN 12&17, EVENING >17)
		SELECT
		    CASE
		        WHEN sale_time < '12:00:00' THEN 'Morning'
		        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
		        ELSE 'Evening'
		    END AS time_shift,
		    COUNT(*) AS number_of_orders
		FROM retail_sales
		GROUP BY time_shift
		ORDER BY number_of_orders DESC;

-- Q11. Write a SQL query to find the second highest total_sale value from the sales table. (Avoid using the LIMIT clause, as it won't work if there are ties for first place. Use a subquery or window function).
	SELECT MAX(total_sale) AS second_highest_sale
	FROM retail_sales
	WHERE total_sale < (SELECT MAX(total_sale) FROM retail_sales);


-- Q12. Write a SQL query to find all customers who have made purchases in at least 3 different product categories.
	SELECT
	    customer_id,
	    COUNT(DISTINCT category) AS unique_categories_purchased
	FROM retail_sales
	GROUP BY customer_id
	HAVING COUNT(DISTINCT category) >= 3
	ORDER BY unique_categories_purchased DESC;
-- Q13. Write a SQL query to show each category, its total sales, and the percentage of the overall total sales it represents.
	SELECT
	    category,
	    SUM(total_sale) AS category_sales,
	    ROUND( (SUM(total_sale) / SUM(SUM(total_sale)) OVER () ) * 100, 2) AS sales_percentage
	FROM retail_sales
	GROUP BY category
	ORDER BY sales_percentage DESC;

	








		