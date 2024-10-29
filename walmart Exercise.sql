-- 		Basic SQL functions
-- 		Change Column header name 
-- 		Customer type -> Customer_Type
ALTER TABLE walmart_sales RENAME COLUMN `Customer type` to `Customer_Type`;
-- 		Product line -> Product_Line
ALTER TABLE walmart_sales RENAME COLUMN `Product line` to `Product_Line`;
-- 		Unit Price -> Unit_Price
ALTER TABLE walmart_sales RENAME COLUMN `Unit price` to `Unit_Price`;
--      Delete one record from walmart_branch
-- DELETE FROM walmart_branch
-- WHERE walmart_branch.Branch = 'B' AND walmart_branch.City = 'Mandalay'
-- 	    Check how many uniques are there in Invoice ID column
--      All Invoice ID are unique
SELECT COUNT(DISTINCT(walmart_sales.`Invoice ID`)) as 'No. of Unique Values'
FROM sql_walmart.walmart_sales;


--       Basic SQL Queries
--       Basic overview of the entire dataset
SELECT * 
FROM sql_walmart.walmart_sales;

-- ---------------------------------------------------------------------------------------------------------------
--        Data Exploration:
--        How many unique stores are in the dataset?
SELECT walmart_sales.city as "City",
		walmart_sales.Branch, 
        count(walmart_sales.Branch) as "No. of Transactions" 
FROM walmart_sales
GROUP BY walmart_sales.city, 
walmart_sales.Branch;

-- 		   Display the name of all the product lines
SELECT DISTINCT walmart_sales.Product_Line as 'Product Line' 
FROM sql_walmart.walmart_sales;

--         Display the number of transaction for each Product Line
SELECT walmart_sales.Product_Line as 'Product Line' ,count(walmart_sales.`Invoice ID`) as 'No. of Transactions'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.Product_Line
--         Bonus: Only display the product line with at least 160 transactions
HAVING count(walmart_sales.`Invoice ID`) >= 160;

--         What is the total number of sales transactions?
SELECT count(walmart_sales.`Invoice ID`) as 'Total No. of Records'
FROM sql_walmart.walmart_sales;

--         What is the average sales (in 2 d.p.) per store, sorted in descending order?
SELECT walmart_sales.Branch, walmart_sales.City , ROUND(AVG(walmart_sales.`Total`), 2) as 'Average Sales'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.Branch, walmart_sales.City
ORDER BY ROUND(AVG(walmart_sales.`Total`), 2) DESC;

--         What is the total revenue generated (in 2 d.p.) for each store?
SELECT walmart_sales.Branch, walmart_sales.City ,ROUND(SUM(walmart_sales.`Total`),2) as 'Total Sales'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.Branch, walmart_sales.City
ORDER BY ROUND(SUM(walmart_sales.`Total`), 2) DESC;

-- ---------------------------------------------------------------------------------------------------------------
--     Filtering and Sorting:
--         Find the top 5 best-selling products.
SELECT walmart_sales.`Product_Line`, ROUND(SUM(walmart_sales.`Total`),2) as 'Total Sales'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`
ORDER BY ROUND(SUM(walmart_sales.`Total`),2) DESC
LIMIT 5;
--         Retrieve all sales from a specific store - {C, Naypyitaw}.
SELECT *
FROM sql_walmart.walmart_sales
WHERE (walmart_sales.Branch = 'C' AND walmart_sales.City = 'Naypyitaw');

--         List all products sold in the month of March 2019.
-- SELECT DISTINCT walmart_sales.`Date`
-- FROM sql_walmart.walmart_sales
-- ORDER BY walmart_sales.`Date` ASC

SELECT count(*)
FROM sql_walmart.walmart_sales
WHERE (walmart_sales.`Date` BETWEEN '2019-03-01' AND '2019-03-20');

--         Find the total sales for each product line.
SELECT walmart_sales.`Product_Line`, ROUND(SUM(walmart_sales.`Total`),2) as 'Total Sales'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`
-- HAVING ROUND(SUM(walmart_sales.`Total`),2) >= 50000
ORDER BY ROUND(SUM(walmart_sales.`Total`),2) DESC;

-- ---------------------------------------------------------------------------------------------------------------
--     Aggregation:
--         Calculate the total sales for each day of the week.

--         Find the average sales price per product.
SELECT walmart_sales.`Product_Line`, ROUND(AVG(walmart_sales.`Total`),2) as 'Average Sale'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`
ORDER BY ROUND(AVG(walmart_sales.`Total`),2) DESC;

--         Determine the maximum and minimum sales amounts.
SELECT walmart_sales.`Product_Line`, MAX(walmart_sales.`Total`) as 'Highest Sale', MIN(walmart_sales.`Total`) as 'Lowest Sale'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`;

--         Group product lines by branch & city and calculate the total sales for each product line.
SELECT walmart_sales.Branch as 'Branch', walmart_sales.City as 'City', walmart_sales.`Product_Line` as 'Product Line',
ROUND(SUM(walmart_sales.`Total`),2) as 'Total Sales'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.Branch, walmart_sales.City, walmart_sales.`Product_Line`
ORDER BY walmart_sales.Branch, walmart_sales.City;

-- Intermediate SQL Queries
-- ---------------------------------------------------------------------------------------------------------------
--     Joins:
--         Join the sales table with a address table to get the branch's address.

SELECT walmart_sales.Branch, walmart_sales.City, walmart_branch.Postal_Code, walmart_branch.Unit_Number 
FROM sql_walmart.walmart_sales
INNER JOIN sql_walmart.walmart_branch
ON walmart_sales.Branch = walmart_branch.Branch AND walmart_sales.City = walmart_branch.City
GROUP BY walmart_sales.Branch, walmart_sales.City;

--         Find the total sales for each store, including the store name and address.
SELECT walmart_sales.Branch, walmart_sales.City, ROUND(SUM(walmart_sales.`Total`),2) as 'Total Sales($)' ,
walmart_branch.Postal_Code, walmart_branch.Unit_Number 
FROM sql_walmart.walmart_sales
INNER JOIN sql_walmart.walmart_branch
ON walmart_sales.Branch = walmart_branch.Branch AND walmart_sales.City = walmart_branch.City
GROUP BY walmart_sales.Branch, walmart_sales.City;

-- ---------------------------------------------------------------------------------------------------------------
--     Window Functions:
--         Display all the necessary columns to make sense of the running total
SELECT walmart_sales.`Invoice ID`, walmart_sales.`Date`, walmart_sales.`Product_Line`, walmart_sales.`Total`  
FROM sql_walmart.walmart_sales
WHERE (walmart_sales.`Date` LIKE '2019-01%' AND walmart_sales.`Product_Line` = 'Electronic accessories')
ORDER BY walmart_sales.`Date` ASC;

-- 			Checks the total sales 
SELECT walmart_sales.`Product_Line`, ROUND(SUM(`Total`),2) as 'Total Sales'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`
ORDER BY SUM(`Total`) DESC;

--         Calculate the running total of sales for each product line over time.
-- 		   Appends a column of the running totals for each product line to every record of the associated product line
SELECT walmart_sales.`Invoice ID`, walmart_sales.`Product_Line`, walmart_sales.`Date`, walmart_sales.`Total`, 
ROUND(SUM(walmart_sales.`Total`) OVER (PARTITION BY walmart_sales.`Product_Line` ORDER BY walmart_sales.`Date`, walmart_sales.`Invoice ID`),2) as 'Rolling Total Sales Per Invoice'
FROM sql_walmart.walmart_sales;

--         Find the rank of each product based on total sales.
SELECT walmart_sales.`Product_Line`, ROUND(SUM(walmart_sales.`Total`),2) as 'Total Sales ($)',
DENSE_RANK() OVER (ORDER BY SUM(walmart_sales.`Total`) DESC) as 'Sales Ranking'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`;

--         Determine the percentage of total sales each product contributes and its ranking.
SELECT walmart_sales.`Product_Line`, ROUND(SUM(walmart_sales.`Total`),2) as 'Product Total Sales',
ROUND(SUM(SUM(walmart_sales.`Total`)) OVER (),2) as 'Overall Gross Sales',
Round((SUM(walmart_sales.`Total`)/SUM(SUM(walmart_sales.`Total`)) OVER ()) * 100,2) as 'Contribution of Overall Gross Sales(%)',
DENSE_RANK() OVER(ORDER BY ROUND(SUM(walmart_sales.`Total`),2) DESC) as 'Rankings'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`
ORDER BY ROUND(SUM(walmart_sales.`Total`),2) DESC;

-- ---------------------------------------------------------------------------------------------------------------
-- Advanced SQL Queries - Subqueries & CTEs

--     Subqueries:
--         Find the average sales per day for each store that has total sales greater than the average sales for all stores.
-- 		   Breaking this question up, let's find the total sale for each store first - {A: 106,200.37, B: 110,568.71, C:106,197.67}.
SELECT walmart_sales.`Branch`, walmart_sales.`City`, ROUND(SUM(walmart_sales.`Total`),2) as 'Total Store Sales'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Branch`, walmart_sales.`City`; 

-- The Grand Avg Sales is $107,655.58, only {C, Naypyitaw} is above the average with 110,568.71 total sales
-- sales_table returns the total sales for each store
 WITH sales_table AS (
 SELECT walmart_sales.`Branch` as 'Branch', walmart_sales.`City` as 'City', 
 ROUND(SUM(walmart_sales.`Total`),2) as 'Total Store Sales'
 FROM sql_walmart.walmart_sales
 GROUP BY walmart_sales.`Branch`, walmart_sales.`City`), 
 avg_sales AS (
	SELECT ROUND(AVG(sales_table.`Total Store Sales`),2) AS 'Grand Avg Sales'
    FROM sales_table)
    
-- this outer query gets the running average across all three stores
SELECT sales_table.`Branch`, sales_table.`City`,  sales_table.`Total Store Sales`, avg_sales.`Grand Avg Sales`
FROM sales_table 
JOIN avg_sales ON 1 = 1
WHERE sales_table.`Total Store Sales` < avg_sales.`Grand Avg Sales`;

--     Common Table Expressions (CTEs):
SELECT * FROM sql_walmart.walmart_sales;

--         Use CTEs to calculate the total sales for each product line and then find the top 3 categories with the highest sales.
--         Write a CTE to find the total sales for each product line
WITH product_sales_cte AS (
SELECT walmart_sales.`Product_Line` AS 'Product Line', ROUND(SUM(walmart_sales.`Total`)) as 'Total Product Sales' 
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`
ORDER BY ROUND(SUM(walmart_sales.`Total`),2) DESC)
-- 		  Outer SQL query to find the top three product lines with the highest sale
SELECT * 
FROM product_sales_cte
LIMIT 3;

--         Create a CTE to rank products line by sales and then select only the top 4 product lines.
--         Use DENSE_RANK() to not skipping a rank when ranks are tied
WITH product_rank AS (
SELECT walmart_sales.`Product_Line` AS 'Product Line',
ROUND(SUM(walmart_sales.`Total`),2) as 'Total Product Sales', 
DENSE_RANK() OVER( ORDER BY SUM(walmart_sales.`Total`) DESC) as 'Total Product Sales Rank'
FROM sql_walmart.walmart_sales
GROUP BY walmart_sales.`Product_Line`)

SELECT *
FROM product_rank
WHERE product_rank.`Total Product Sales Rank` <= 4

--     Recursive Queries:
--         If you have a hierarchical structure (e.g., product categories), use a recursive query to find all child categories for a given category.

--     Performance Optimization:
--         Explain how you would optimize a slow-running query.
--         Discuss the importance of indexing and how to create appropriate indexes for your dataset.