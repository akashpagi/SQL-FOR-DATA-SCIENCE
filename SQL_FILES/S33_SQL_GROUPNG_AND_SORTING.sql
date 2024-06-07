-- SORTING DATA
SELECT * FROM campusx.smartphones;

-- 1. find the top 5 samsung pones with the biggest screen size
SELECT model, screen_size FROM campusx.smartphones
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC LIMIT 5;

-- 2.   Sort all the phones in descending order of number of total cameras
SELECT brand_name, model, num_rear_cameras + num_front_cameras AS 'total_cameras' 
FROM campusx.smartphones
ORDER BY total_cameras DESC;

-- 3.	Sort data on the basis of ppi in decreasing order
SELECT brand_name, model, 
ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size, 2) AS 'PPI'
FROM campusx.smartphones
ORDER BY PPI DESC;

-- 4.	Find the phone with 2nd largest battery
SELECT brand_name, model, battery_capacity  
FROM campusx.smartphones
ORDER BY battery_capacity DESC LIMIT 1, 1;

-- 4.1	Find the phone with 2nd lowest battery
SELECT model, battery_capacity  
FROM campusx.smartphones
ORDER BY battery_capacity ASC LIMIT 1, 1;

-- 5.	Find the name and rating of the worst rated apple phone
SELECT model, rating FROM campusx.smartphones
WHERE brand_name = 'apple'
ORDER BY rating ASC LIMIT 1;


-- 6.	Sort phones alphabetically and then on the basis of rating in desc order
SELECT brand_name, model, price, rating 
FROM campusx.smartphones
ORDER BY brand_name ASC, rating DESC;

-- 7.	Sort phones alphabetically and then on the basis of rating in asc order
SELECT brand_name, model, price, rating 
FROM campusx.smartphones
ORDER BY brand_name ASC, rating ASC;




-- GROUPING DATA
-- 1.	Group smartphones by brand and get the count, average price, mar rating, avg screen size and avg battery capacity
SELECT brand_name, COUNT(*) AS 'num_of_phones', 
ROUND(AVG(price),2) AS 'average_price',
MAX(rating) AS 'max_rating', 
ROUND(AVG(screen_size), 1) AS 'averae_screen_size',
ROUND(AVG(battery_capacity)) AS 'average_battery_capacity'
FROM campusx.smartphones 
GROUP BY brand_name
ORDER BY num_of_phones DESC LIMIT 5;

-- Order of Execution : F J W G H S D O



-- 2.	Group smartphones by whether they have on NFC and get average price and rating
SELECT has_nfc, AVG(price) AS 'price', 
AVG(rating) AS 'rating'
FROM campusx.smartphones 
GROUP BY has_nfc;


-- 3.	Group smartphones by the extended memory available and get the average price
SELECT extended_memory_available, AVG(price) AS 'price' 
FROM campusx.smartphones 
GROUP BY extended_memory_available;


-- 4.	Group smartphones by the brand and the processor brand and get the count of models and the average primary camera resolution (rear)
SELECT brand_name, processor_brand,
COUNT(*) AS 'num_of_phones',
AVG(primary_camera_rear) AS 'average_camera_resolution'
FROM campusx.smartphones
GROUP BY brand_name, processor_brand;

-- 5.	Find top 5 costly phones brands
SELECT brand_name, ROUND(AVG(price),2) AS 'average_price'
FROM campusx.smartphones
GROUP BY brand_name 
ORDER BY average_price DESC LIMIT 5;

-- 6.	Which brand makes the smallest screen smartphones
SELECT brand_name, ROUND(AVG(screen_size),2) AS 'average_screen_size'
FROM campusx.smartphones
GROUP BY brand_name 
ORDER BY average_screen_size ASC LIMIT 1;

-- 7.	Avg price of 5g phones vs avg price of non 5g phones


-- 8.	Group smartphones by the brand and find with the highest number of models that have both NFC and an IR blaster
SELECT brand_name, COUNT(*) AS 'count' FROM campusx.smartphones
WHERE has_nfc = 'TRUE' AND has_ir_blaster = 'TRUE'
GROUP BY brand_name ORDER BY count DESC LIMIT 1;


-- 9.	Find all samsung 5g enabled smartphones and find out the avg price for NFC and non NFC phones
SELECT has_nfc, AVG(price) AS 'average_price' FROM campusx.smartphones
WHERE brand_name = 'samsung'
GROUP BY has_nfc;









-- Having clause
-- filtering on aggregate functions

-- 1.	Find the avg rating of smartphones brands which have more than 20 phones
SELECT brand_name, COUNT(*) AS 'count',
AVG(price) AS 'average_price'
FROM campusx.smartphones
GROUP BY brand_name HAVING count > 40
ORDER BY average_price DESC;


-- 2.	Find the top 3 brands with the highest avg ram that have a refresh rate of a at least 90 Hz and fast charging available and don’t consider brands which have less than 10 phones
SELECT brand_name,
AVG(ram_capacity) AS 'average_ram'
FROM campusx.smartphones
WHERE refresh_rate > 90 AND fast_charging_available = 1
GROUP BY brand_name HAVING count(*) > 10
ORDER BY average_ram DESC LIMIT 3;


-- 3.	Find the avg price of all the phone brands with avg rating > 70 and num_phones more 10 among all 5g enabled phones
SELECT brand_name, AVG(price) AS 'average_price'
FROM campusx.smartphones WHERE has_5g = 'TRUE'
GROUP BY brand_name HAVING AVG(rating) > 70 AND count(*) > 10;


--  IPL
CREATE TABLE ipl
(
	ID INT,
    innings INT,
    overs INT,
    ballnumber INT,
    batter TEXT,
    bowler TEXT,
    non_striker TEXT,
    extra_type TEXT,
    batsman_run INT,
    extras_run INT,
    total_run INT,
    non_boundary INT,
    isWicketDelivery DOUBLE,
    player_out TEXT,
    kind TEXT,
    fielders_involved TEXT,
    BattingTeam TEXT
);

LOAD DATA INFILE 'IPL.csv' INTO TABLE ipl
FIELDS TERMINATED BY ','
IGNORE 1 LINES;	

SELECT * FROM campusx.ipl;
-- 1. Find the top 5 batsman in IPL
SELECT batter, SUM(batsman_run) AS 'runs'
FROM campusx.ipl
GROUP BY batter
ORDER BY runs DESC LIMIT 5;

-- 2. Find 2nd highest 6 hitters in IPL
SELECT batter, COUNT(*) AS 'num_sixes'
FROM campusx.ipl
WHERE batsman_run = 6
GROUP BY batter
ORDER BY num_sixes DESC LIMIT 1,1;

-- 3. Find virat kohli peformance against all the teams

-- 4. Find the top 10 batsman with centuries in IPL














-- 1. Find the top 5 batsman in IPL
SELECT batter, SUM(batsman_run) AS 'runs'
FROM campusx.ipl
GROUP BY batter
ORDER BY runs DESC LIMIT 5;

-- 2. Find 2nd highest 6 hitters in IPL
SELECT batter, COUNT(*) AS 'num_sixes'
FROM campusx.ipl
WHERE batsman_run = 6
GROUP BY batter
ORDER BY num_sixes DESC LIMIT 1,1;

-- 3. Find virat kohli peformance against all the teams

-- 4. Find the top 10 batsman with centuries in IPL

-- 5. Find the  top 5 batsman with highest strike rate who have played a minimum 1000 balls











