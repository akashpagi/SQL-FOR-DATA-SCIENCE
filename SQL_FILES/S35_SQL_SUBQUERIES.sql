# SESSION 35 - SQL SUB QUERIES
USE campusx;

-- Example of subquery
SELECT * FROM movies
WHERE score = (SELECT MIN(score) FROM movies); 


# Independent Subquery - Scalar Subquery 

-- 1. Find the movie with highest profit (vs order by)
SELECT * FROM movies
WHERE (gross - budget) = (
	SELECT MAX(gross - budget) AS max_profit FROM movies
);
    

-- 2. Find how many movies avg a rating > the avg of all the movie rating (Find the count of above average movies)
SELECT COUNT(*) FROM movies
WHERE score > (
	SELECT AVG(score) FROM movies
);


-- 3. Find the highest rated movie of 2000
SELECT * FROM movies
WHERE year = 2000 AND score = (
	SELECT MAX(score) FROM movies
	WHERE year = 2000 		
);






-- 4. Find the highest rated among all movies whose number of voters as > the data avg votes
SELECT * FROM movies
WHERE score = (
	SELECT MAX(score) FROM movies
	WHERE votes > (
		SELECT AVG(votes) FROM movies
	)
);


# Independent Subquery - Row Subquery (one column and multiple rows)
USE zomato;

-- Ex1. find all users who never ordered
SELECT * FROM users
WHERE user_id NOT IN (
	SELECT DISTINCT(user_id) 
	FROM orders
);

-- Ex2. Find all the movies made by top 3 directors (in terms of total gross in income)
USE campusx;

/*
SELECT * FROM movies
WHERE director IN (
	SELECT director FROM movies
	GROUP BY director
	ORDER BY SUM(gross) DESC 
    LIMIT 3
);
*/



/* 
Explanation:
The subquery inside the parentheses (SELECT director FROM (SELECT director FROM movies GROUP BY director ORDER BY SUM(gross) DESC LIMIT 3) AS top_directors) selects the top 3 directors based on the sum of their gross earnings and forms a derived table top_directors.
The outer query selects all movies where the director is in the list of top directors obtained from the derived table.
*/

SELECT DISTINCT(director) FROM movies 
WHERE director IN (
    SELECT director 
    FROM (
        SELECT director FROM movies
        GROUP BY director
        ORDER BY SUM(gross) DESC
        LIMIT 3
    ) AS top_directors #derived table
);


-- Ex3. Find all movies of all those actors whose filmography's avg rating > 8.5 (take 25000 votes as cutoff)
SELECT * FROM movies
WHERE star IN (
	SELECT star FROM movies
	WHERE votes > 25000
	GROUP BY star
	HAVING AVG(score) > 8.5 
); 


# Independent Subquery - Table Subquery (Multiple column and multiple rows)


-- 1. Find the most profitable movie of each year
SELECT * FROM movies
WHERE (year, gross-budget) IN (
	SELECT year , MAX(gross-budget)
	FROM movies
	GROUP BY year
);

-- 2. Find the highest rated movie of each genre vote cutoff of 25000
/*
SELECT * 
FROM movies 
WHERE (genre, score) IN (
        SELECT genre, MAX(score) AS max_score
        FROM movies
        WHERE votes > 25000
        GROUP BY genre
) AND votes > 25000;
-- Error Code: 2013. Lost connection to MySQL server during query
*/

SELECT * 
FROM movies 
WHERE (genre, score) IN (
    SELECT genre, score 
    FROM (
        SELECT genre, MAX(score) AS max_score
        FROM movies
        WHERE votes > 25000
        GROUP BY genre
    ) AS temp # derived table
) AND votes > 25000;

-- 3. Find the highest grossing movies of top 5 actor/ director combo in terms of total gross income
-- CTE 
WITH top_duos AS (
	SELECT star, director, MAX(gross)
	FROM movies
	GROUP BY star, director
	ORDER BY SUM(gross) DESC LIMIT 5
)

SELECT * FROM movies
WHERE (star, director, gross) IN (
	SELECT * FROM top_duos
);



# Correlated subquery : Inner query depend on outer query
-- 1. Find all the movies that have rating higher than the average rating of movies in the same genre

SELECT * FROM movies AS M1
WHERE score > (
	SELECT AVG(score) 
    FROM movies AS M2 
    WHERE M2.genre = M1.genre
);


-- 2.Find the favourite food of each customer
USE zomato;
-- CTE
WITH fav_food AS (
	SELECT 
		ZO.user_id, 
        ZU.name, 
        ZF.f_name, 
        COUNT(ZF.f_name) AS freq_of_food
	FROM 
		users AS ZU
		JOIN orders AS ZO ON ZU.user_id = ZO.user_id
		JOIN order_details AS ZOD ON ZO.order_id = ZOD.order_id
		JOIN food AS ZF ON ZOD.f_id = ZF.f_id 
	GROUP BY  
		ZO.user_id, ZU.name, ZF.f_name 
)

SELECT * 
FROM fav_food AS F1
WHERE freq_of_food = (
	SELECT MAX(freq_of_food)
    FROM fav_food AS F2
    WHERE F2.user_id = F1.user_id
);


# Usage with SELECT
-- 1. Get the percentage of votes for each movie compared to the total number of votes
SELECT 
	name,
    (votes/(SELECT SUM(votes) FROM movies))*100 AS percentage
FROM 
	movies;

-- 2. Display all movie names, genre, score and avg(score) of genre
SELECT 
	name, genre, score,
    (
		SELECT AVG(score) 
		FROM movies M2 
		WHERE M2.genre = M1.genre 
    ) AS average_score
FROM 
	movies AS M1;



# Usage with FROM
-- 1. Display average rating of all the restaurants
USE zomato;

SELECT r_name, average_rating 
FROM (
	SELECT 
		r_id, AVG(restaurant_rating) AS average_rating
	FROM 
		orders
	GROUP BY r_id
) AS T1 
JOIN restaurants AS T2 ON T1.r_id = T2.r_id;



# Usage with HAVING
-- 1. Find enres having avg score greater than avg score of all the movies
USE campusx;

SELECT genre, AVG(score) AS average_score
FROM movies
GROUP BY genre
HAVING AVG(score) > (SELECT AVG(score) FROM movies) ;


# Subquery in INSERT
-- Populate a already created loyal_customers table with records of only those customers who have ordered food more than 3 times
USE zomato;
CREATE TABLE loyal_users
(
	user_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
    money INT
);

INSERT INTO loyal_users(user_id, name)
SELECT ZU.user_id, ZU.name
FROM orders AS ZO
JOIN users AS ZU ON ZO.user_id = ZU.user_id
GROUP BY ZU.user_id, ZU.name 
HAVING COUNT(*)  > 3;

# Subquery in UPDATE
-- Populate the money col of loyal _customer table using orders table. Provide a 10% app money to all customers based on teir order value 
# 1st way:
UPDATE loyal_users AS ZLU
SET money = ( 
    SELECT SUM(amount) * 0.1
    FROM orders AS ZO
    WHERE ZO.user_id = ZLU.user_id
);

# 2nd way:
UPDATE loyal_users AS ZLU
JOIN (
    SELECT user_id, SUM(amount) * 0.1 AS total_app_money
    FROM orders
    GROUP BY user_id
) AS ZO ON ZLU.user_id = ZO.user_id
SET ZLU.money = ZO.total_app_money;


# Subquery in DELETE
-- DELETE all the customers record who have never ordered
USE zomato;

DELETE FROM users
WHERE user_id IN (
	SELECT user_id
	FROM
		(
		SELECT user_id 
		FROM users
		WHERE user_id NOT IN (
			SELECT DISTINCT(user_id) 
			FROM orders
		)
	) AS most_inner_subquery
);









