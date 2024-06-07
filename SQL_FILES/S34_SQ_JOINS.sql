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








