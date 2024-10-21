-- SQL Retail Sales Analysis
CREATE DATABASE retail_sales;

-- Drop TABLE if exists
DROP TABLE IF EXISTS retail_sales;

-- Create TABLE
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Note: Use the 'SQL - Retail Sales Analysis_utf .csv' file to import the data into the database.
