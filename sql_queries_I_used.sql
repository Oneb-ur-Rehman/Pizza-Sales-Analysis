CREATE DATABASE Pizza_DB;
USE Pizza_DB;

USE Pizza_DB;

CREATE TABLE pizza_sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity TINYINT,
    order_date DATE,
    order_time TIME,
    unit_price DOUBLE,
    total_price DOUBLE,
    pizza_size VARCHAR(50),
    pizza_category VARCHAR(50),
    pizza_ingredients VARCHAR(200),
    pizza_name VARCHAR(50)
);

SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'C:/Users/hp/Desktop/MySQL/Pizza project/pizza_sales.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    pizza_id,
    order_id,
    pizza_name_id,
    quantity,
    @order_date,
    order_time,
    unit_price,
    total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name
)
SET order_date = STR_TO_DATE(@order_date, '%d-%m-%Y');

SELECT COUNT(*) AS total_rows
FROM pizza_sales;

SELECT * from pizza_sales;


DESCRIBE pizza_sales;

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

SELECT * from pizza_sales;

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales;

SELECT SUM(quantity) AS Toal_Pizza_Sold 
from pizza_sales;


SELECT COUNT(DISTINCT order_id) AS Total_orders 
from pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_order from pizza_sales;





SELECT DAYNAME(order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders 
from pizza_sales 
GROUP BY DAYNAME(order_date);


SELECT MONTHNAME(order_date) AS Month_Name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date)
ORDER BY total_orders DESC;

SELECT pizza_size, sum(total_price) as Total_Sales, sum(total_price) * 100 /
(SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS PCT
from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;


SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10,2)) as Total_Sales, CAST(sum(total_price) * 100 /
(SELECT sum(total_price) from pizza_sales WHERE QUARTER(order_date)=1) AS DECIMAL(10,2)) AS PCT
from pizza_sales
WHERE QUARTER(order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC;

SELECT pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;













