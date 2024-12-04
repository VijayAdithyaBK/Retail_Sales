# Retail Sales Analysis

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `retail_sales`

This project showcases SQL skills and techniques commonly used by data analysts to explore, clean, and analyze retail sales data. It involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions using SQL queries. This project is ideal for those starting their journey in data analysis and aiming to build a solid foundation in SQL.

## Objectives

1. **Set Up a Retail Sales Database**: Create and populate a database with provided sales data.
2. **Data Cleaning**: Identify and remove records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic EDA to understand the dataset.
4. **Business Analysis**: Utilize SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project begins by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data, including columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out the number of unique customers in the dataset.
- **Category Count**: Identify all unique product categories.
- **Null Value Check**: Check for null values and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Retrieve all columns for sales made on '2022-11-05'**:
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

2. **Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in Nov-2022**:
```sql
SELECT * FROM retail_sales WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity >= 4;
```

3. **Calculate total sales (total_sale) for each category**:
```sql
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders FROM retail_sales GROUP BY category;
```

4. **Find the average age of customers who purchased items from the 'Beauty' category**:
```sql
SELECT ROUND(AVG(age), 2) AS avg_age FROM retail_sales WHERE category = 'Beauty';
```

5. **Find all transactions where the total_sale is greater than 1000**:
```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```

6. **Find total transactions made by each gender in each category**:
```sql
SELECT category, gender, COUNT(*) AS total_trans FROM retail_sales GROUP BY category, gender ORDER BY category;
```

7. **Calculate the average sale for each month and find the best-selling month in each year**:
```sql
SELECT year, month, avg_sale FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year, EXTRACT(MONTH FROM sale_date) AS month, AVG(total_sale) AS avg_sale,
           RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales GROUP BY year, month
) AS t1 WHERE rank = 1;
```

8. **Find the top 5 customers based on the highest total sales**:
```sql
SELECT customer_id, SUM(total_sale) AS total_sales FROM retail_sales GROUP BY customer_id ORDER BY total_sales DESC LIMIT 5;
```

9. **Find the number of unique customers who purchased items from each category**:
```sql
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_cs FROM retail_sales GROUP BY category;
```

10. **Create shifts and count the number of orders (Morning < 12, Afternoon 12-17, Evening > 17)**:
```sql
WITH hourly_sale AS (
    SELECT *, 
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders FROM hourly_sale GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had total sale amounts greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Vijay Adithya B K

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/vijayadithyabk/)
