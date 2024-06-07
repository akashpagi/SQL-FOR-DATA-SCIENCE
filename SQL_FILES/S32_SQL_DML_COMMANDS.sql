CREATE DATABASE campusx;
USE campusx;
CREATE TABLE users(
	user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
SELECT * FROM users;

INSERT INTO users(user_id, name, email, password) VALUES (NULL, 'Aakash', 'aakash@gmail.com', '@#$%@');

INSERT INTO users(name, email) VALUES('Akash', 'akash@gmail.com');

INSERT INTO users VALUES (NULL, 'vivek', 'vivek@gmail.com', '@##$4');

INSERT INTO users(name, password, email) VALUES ('Mukesh', '%4467');


SELECT * FROM campusx.smartphones;

SELECT brand_name AS 'brands', model, os AS 'operating system'
FROM campusx.smartphones;

SELECT model, 
SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size AS 'PPI'
FROM campusx.smartphones;


SELECT model, 'smartphone' AS 'type' FROM campusx.smartphones;

SELECT DISTINCT brand_name AS 'All brands' 
FROM campusx.smartphones;

SELECT DISTINCT processor_brand AS 'all processors' 
FROM campusx.smartphones;

SELECT DISTINCT brand_name, processor_brand  
FROM campusx.smartphones;

SELECT brand_name, model, price FROM campusx.smartphones
WHERE brand_name = 'samsung';

SELECT brand_name, model, price FROM campusx.smartphones
WHERE price <= 30000;

-- BETWEEN operator 
-- Ex 1
SELECT  brand_name, model, price FROM campusx.smartphones
WHERE price BETWEEN 10000 AND 20000;

SELECT brand_name, model, rating, price, processor_brand 
FROM campusx.smartphones 
WHERE price < 15000 AND rating > 80 AND processor_brand = 'snapdragon';








