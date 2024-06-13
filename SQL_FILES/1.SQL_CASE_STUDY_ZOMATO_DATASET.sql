# SQL CASE STUDY 1 : ZOMATO DATASET

-- CREATE DATABASE IF NOT EXISTS zomato;
-- USE zomato;

-- 1. Select a particular database
USE zomato;

-- 2. Count number of rows
SELECT COUNT(*) FROM food;

-- 3. return and random records
# Replicated sample function form panads
SELECT * FROM users ORDER BY rand() LIMIT 5;

-- 4. find null values
-- Find rows with NULL values 
# SELECT * FROM orders WHERE restaurant_rating IS NULL;
SELECT * FROM orders WHERE restaurant_rating = '';

-- Find rows with not NULL values
/* 
SELECT * FROM orders 
WHERE restaurant_rating IS NOT NULL;
*/

SELECT * FROM orders WHERE restaurant_rating <> '';

-- To replace NULL values with 0
/* 
UPDATE orders SET restarunt_rating = 0 
WHERE restaurant_rating <> ''; 
*/


-- 5. find number of orders placed by each customer
SELECT 
	ZU.name, 
    COUNT(*) AS number_of_orders 
FROM 
	orders AS ZO 
JOIN 
	users AS ZU ON ZO.user_id = ZU.user_id 
GROUP BY 
	ZU.user_id, ZU.name;

-- 6. find restarunt with most number of menu items
/*
SELECT r_name, COUNT(*) AS 'number_of_menu_items' FROM restaurants AS ZR 
JOIN menu AS ZM ON ZR.r_id = ZM.r_id
GROUP BY ZM.r_id;
*/
SELECT 
	ZR.r_name, 
    COUNT(*) AS number_of_menu_items 
FROM 
	restaurants AS ZR 
JOIN 
	menu AS ZM ON ZR.r_id = ZM.r_id 
GROUP BY 
	ZR.r_id, ZR.r_name;



-- 7. find number of voters and avg rating for all the restarunts
SELECT ZR.r_name,         
       COUNT(*) AS 'number_of_menu_items',         
       ROUND(AVG(ZO.restaurant_rating), 2) AS 'avg_rating'  
FROM orders AS ZO  
JOIN restaurants AS ZR  
ON ZO.r_id = ZR.r_id   
WHERE restaurant_rating <> ''  
GROUP BY ZO.r_id, ZR.r_name;


-- 8. find the food that's being sold at most number of restarunts
SELECT ZF.f_name, 
	   COUNT(*) AS 'most_sold_food' FROM menu AS ZM
JOIN food AS ZF 
ON ZM.f_id = ZF.f_id
GROUP BY ZF.f_name
ORDER BY most_sold_food DESC LIMIT 1;

-- 9. find restarunt with max revenue in a give month
# SELECT MONTHNAME(DATE(date)), date FROM orders;
SELECT 
	ZR.r_name, 
	SUM(amount) AS 'revenue' 
FROM 
	orders AS ZO 
JOIN 
	restaurants AS ZR ON ZO.r_id = ZR.r_id
WHERE 
	MONTHNAME(DATE(date)) = 'May'
GROUP BY 
	ZO.r_id, ZR.r_name
ORDER BY 
	revenue DESC LIMIT 1;

-- Month by Month  revenue for a particular restaurtant
SELECT 
	MONTHNAME(DATE(date)), 
	SUM(amount) AS 'revenue' 
FROM 
	orders AS ZO
JOIN 
	restaurants AS ZR ON ZO.r_id = ZR.r_id
WHERE 
	ZR.r_name = 'kfc'
GROUP BY 
	MONTHNAME(DATE(date)), MONTH(DATE(date))
ORDER BY 
	MONTH(DATE(date));

-- 10. find restarunt with sales > x
# JOIN between orders & restaurants
SELECT 
	ZR.r_name, 
	SUM(amount) AS 'revenue'  
FROM 
	orders AS ZO
JOIN 
	restaurants AS ZR ON ZO.r_id = ZR.r_id
GROUP BY 
	ZO.r_id, ZR.r_name
HAVING
	revenue > 3000;

-- 11. find customers who have nerver ordered
# JOIN between users & orders
SELECT
    ZU.user_id, ZU.name
FROM
    users AS ZU
LEFT JOIN
    orders AS ZO ON ZU.user_id = ZO.user_id
WHERE
    ZO.user_id IS NULL;

-- 12. show order details of a particular customer in a given date range
# JOIN between order, order_details & food
SELECT 
	ZO.order_id, ZF.f_name, date
FROM 
	orders AS ZO
JOIN 
	order_details AS ZOD ON ZO.order_id = ZOD.order_id
JOIN 
	food AS ZF ON ZOD.f_id = ZF.f_id
WHERE 
	user_id = 1 AND date BETWEEN '2022-05-15' AND '2022-06-15';


-- 13. customer faovrite food
SELECT 
	ZU.user_id, ZU.name AS customer_name, 
    ZOD.f_id AS favorite_food_id, 
    ZF.f_name AS favorite_food_name, 
    COUNT(*) AS num_orders
FROM 
	users AS ZU
JOIN 
	orders AS ZO ON ZU.user_id = ZO.user_id
JOIN 
	order_details AS ZOD ON ZO.order_id = ZOD.order_id
JOIN
	food AS ZF ON ZOD.f_id = ZF.f_id
GROUP BY 
	ZU.user_id, ZU.name, ZOD.f_id, ZF.f_name
ORDER BY
	num_orders DESC;


-- 14. find the most costly restarunt (avg price/dish)
SELECT 
    ZR.r_name,
    ROUND(SUM(price)/COUNT(*),2) AS 'average_price'
FROM
    menu AS ZM
JOIN
    restaurants AS ZR ON ZM.r_id = ZR.r_id
GROUP BY
	ZM.r_id, ZR.r_name
ORDER BY 
	average_price DESC LIMIT 1;


-- 15. find delivery partner compensation using the formula 
# (#deliveries * 100 + 1000*avg_rating)
SELECT 
	ZO.partner_id, 
    ZDP.partner_name,
    COUNT(*) * 100 + AVG(delivery_rating) * 1000 AS delivery_partner_compensation
FROM 
	orders AS ZO
JOIN 
	delivery_partner AS ZDP ON ZO.partner_id = ZDP.partner_id
GROUP BY
	ZO.partner_id, ZDP.partner_name
ORDER BY 
	delivery_partner_compensation DESC;

-- 16. find revenue per month for a restaurant
# Already done Q9

-- 17. find coorelation between delivery_time and total rating
# Not Solved CORR() not support in MySQL
/*
co relation between 2 numerical columns, corelation value alwasy between -1 to 1
1 : Highly positivly corelated (if 1st increase then 2nd also increase)
-1 : Highly neatively corelated (if 1st increase then 2nd decrease)
0 : Not co-related (not effect on any value)
*/

-- 18. find coorelation between #orders and avg price for all restaurtants
# # Not Solved CORR() not support in MySQL

-- 19. find all the veg restaurants
-- [Not correct query]
SELECT 
	DISTINCT(ZR.r_name)
FROM 
	menu AS ZM
JOIN 
	food AS ZF ON ZM.f_id = ZF.f_id
JOIN 
	restaurants AS ZR ON ZM.r_id = ZR.r_id
GROUP BY
	 ZR.r_name
HAVING 
 	MAX(ZF.type = 'Non-veg') = 0; 

    
-- 20. find min and max order value for all the cutomers
SELECT 
	ZU.name, 
    MIN(amount) AS minimum_order_value,
    MAX(amount) AS maximum_order_value,
    ROUND(AVG(amount),2) AS average_order_value
FROM 
	orders AS ZO 
JOIN 
	users AS ZU ON ZO.user_id = ZU.user_id 
GROUP BY 
	ZU.user_id, ZU.name;




