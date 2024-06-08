-- CROSS JOIN (between users and groups table)
SELECT * FROM sql_cx_live.users1
CROSS JOIN sql_cx_live.groups;


-- INNER JOIN (between membership and users1 table)
-- NOTE: left_table and right_table just alias names for tables
SELECT * FROM sql_cx_live.membership AS left_table
INNER JOIN sql_cx_live.users1 AS right_table
ON left_table.user_id = right_table.user_id;

-- LEFT JOIN (between membership and users1 table)
SELECT * FROM sql_cx_live.membership AS left_table
LEFT JOIN sql_cx_live.users1 AS right_table
ON left_table.user_id = right_table.user_id;

-- RIGHT JOIN (between membership and users1 table)
SELECT * FROM sql_cx_live.membership AS left_table
RIGHT JOIN sql_cx_live.users1 AS right_table
ON left_table.user_id = right_table.user_id;


-- SQL Set Operations
-- UNION
SELECT * FROM sql_cx_live.person1
UNION 
SELECT * FROM sql_cx_live.person2;

-- UNION ALL
SELECT * FROM sql_cx_live.person1
UNION ALL
SELECT * FROM sql_cx_live.person2;

-- INTERSECT
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;


-- EXCEPT
SELECT * FROM sql_cx_live.person1
EXCEPT
SELECT * FROM sql_cx_live.person2;


-- SELF JOIN 
SELECT T1.user_id, T1.name AS emp_name, T1.emergency_contact,  T2.name AS contact_name FROM sql_cx_live.users1 T1
JOIN sql_cx_live.users1 T2
ON T1.emergency_contact = T2.user_id;


-- Joining on more than one cols
SELECT * FROM sql_cx_live.students AS A
RIGHT JOIN sql_cx_live.class AS B
ON A.class_id = B.class_id AND A.enrollment_year = B.class_year;

-- Join more than 2 tables

-- PRACTICE QUESTIONS
-- 1. Find all profitable orders
SELECT FO.order_id, SUM(FOD.profit) AS profitable_orders FROM flipkart.orders AS FO
JOIN flipkart.order_details AS FOD
ON FO.order_id = FOD.order_id
GROUP BY FO.order_id
HAVING SUM(FOD.profit) > 0;

-- 2. Find the customer who has placed max number of orders
SELECT FU.name, COUNT(*) AS num_of_orders FROM flipkart.orders AS FO
JOIN flipkart.users AS FU
ON FO.user_id = FU.user_id
GROUP BY FU.name
ORDER BY num_of_orders DESC LIMIT 1;


-- 3. which is the most profitable category
SELECT FC.category, SUM(profit) AS profitable_vertical FROM flipkart.order_details AS FOD
JOIN flipkart.category AS FC
ON FOD.category_id = FC.category_id
GROUP BY FC.category
ORDER BY profitable_vertical DESC LIMIT 5;


-- 4. which is the most profitable state
SELECT state, SUM(profit) AS profitable_state FROM flipkart.orders AS FO
JOIN flipkart.order_details AS FOD ON FO.order_id = FOD.order_id
JOIN flipkart.users AS FU ON FO.user_id = FU.user_id
GROUP BY state
ORDER BY profitable_state DESC;


-- 5. Find all categories woth profit higher than 5000
SELECT FC.category, SUM(profit) AS profitable_vertical FROM flipkart.order_details AS FOD
JOIN flipkart.category AS FC
ON FOD.category_id = FC.category_id
GROUP BY FC.category
HAVING profitable_vertical > 5000;

