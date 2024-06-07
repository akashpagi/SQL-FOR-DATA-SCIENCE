-- SQL TASK 32
-- CREATE DATABASE sql_tasks;
USE sql_tasks;
SELECT * FROM insurance;


-- 1.Show records of 'male' patient from 'southwest' region.
SELECT * FROM insurance 
WHERE gender='male' AND region='southeast';

-- 2.Show all records having bmi in range 30 to 45 both inclusive.
SELECT * FROM insurance
WHERE bmi BETWEEN 30 AND 45;

-- 3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
SELECT MAX(bloodpressure) AS 'MaxBP', MIN(bloodpressure) AS 'MaxBP'
FROM insurance 
WHERE diabetic='Yes' AND smoker='Yes' ;

-- 4. Find no of unique patients who are not from southwest region.
SELECT COUNT(DISTINCT(PatientID)) FROM insurance
WHERE region NOT IN ('southeast');

-- 5. Total claim amount from male smoker.
SELECT SUM(claim) FROM insurance 
WHERE gender='male' AND smoker='Yes';

-- 6. Select all records of south region.
SELECT * FROM insurance WHERE region LIKE 'south%';

-- 7. No of patient having normal blood pressure. Normal range[90-120]
SELECT COUNT(*) FROM insurance
WHERE bloodpressure BETWEEN 90 AND 120;

-- 8. No of pateint below 17 years of age having normal blood pressure as per below formula -
	-- BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)
	-- Note: Formula taken just for practice, don't take in real sense.
SELECT COUNT(*) FROM insurance
WHERE age < 17 
AND bloodpressure BETWEEN (80 + (age*2)) AND (100 + (age*2));

-- 9.What is the average claim amount for non-smoking female patients who are diabetic?
SELECT AVG(claim) FROM insurance
WHERE gender='female' AND smoker='No' AND diabetic='Yes';

-- 10.Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
UPDATE insurance
SET claim = 5000 
WHERE PatientID = 1234;
SELECT * FROM insurance WHERE PatientID = 1234;


-- 11.Write a SQL query to delete all records for patients who are smokers and have no children
DELETE FROM insurance 
WHERE children=0 AND smoker='Yes';








-------------------------------------------------------------------------------------------

-- SQL TASK 33


-- Sleep Efficiency Dataset
-- For questions 1-5, you can find the dataset and details about it from here.
-- ID a unique identifier for each test subject
-- Age age of the test subject
-- Gender male or female
-- Bedtime the time the test subject goes to bed each night
-- Wakeup time the time the test subject wakes up each morning
-- Sleep duration the total amount of time the test subject slept (in hours)
-- Sleep efficiency a measure of the proportion of time in bed spent asleep
-- REM sleep percentage the percentage of total sleep time spent in REM sleep
-- Deep sleep percentage the percentage of total sleep time spent in deep sleep
-- Light sleep percentage the percentage of total sleep time spent in light sleep
-- Awakenings the number of times the test subject wakes up during the night
-- Caffeine consumption the amount of caffeine consumed in the 24 hours prior to bedtime (in mg)
-- Alcohol consumption the amount of alcohol consumed in the 24 hours prior to bedtime (in oz)
-- Smoking status whether or not the test subject smokes
-- Exercise frequency the number of times the test subject exercises each week

-- Problem 1: Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5.

-- Problem 2: Show avg deep sleep time for both gender. Round result at 2 decimal places.
-- Note: sleep time and deep sleep percentage will give you, deep sleep time.

-- Problem 3:
-- Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45. Display age, light sleep percentage and deep sleep percentage columns only.

-- Problem 4: Group by on exercise frequency and smoking status and show average deep sleep time, average light sleep time and avg rem sleep time.
-- Note the differences in deep sleep time for smoking and non smoking status

-- Problem 5: Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for people who do exercise atleast 3 days a week. Show result in descending order awekenings

-- -------------------------------------------------------

-- Power Generation Dataset
-- For this question, you can find the details as well as the dataset from here.

-- Problem 6: Display those power stations which have average 'Monitored Cap.(MW)' (display the values) between 1000 and 2000 and the number of occurance of the power stations (also display these values) are greater than 200. Also sort the result in ascending order.
	-- Avg Cost of Undergrad College by State(USA) Dataset
	-- For this question, you can find the detailed dataset from here.
	-- Year The Digest year this information comes from
	-- State The U.S. State
	-- Type Type of University, Private or Public and in-state or out-of-state. 
	-- Private colleges charge the same for in/out of state Length Whether the college mainly offers 2-year (Associates) or 4-year (Bachelors) programs Expense The Expense being described, tuition/fees or on-campus living expenses Value The average cost for this particular expense, in USD ($)


-- Problem 7: Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 and type is 'Public In-State'. Also the number of occurance should be between 6 to 10. Display the average value upto 2 decimal places, state names and the occurance of the states.
-- Problem -8: Best state in terms of low education cost (Tution Fees) in 'Public' type university.
-- Problem 9: 2nd Costliest state for Private education in year 2021. Consider, Tution and Room fee both.
-- Problem 10: Display total and average values of Discount_offered for all the combinations of 'Mode_of_Shipment' (display this feature) and 'Warehouse_block' (display this feature also) for all male ('M') and 'High' Product_importance. Also sort the values in descending order of Mode_of_Shipment and ascending order of Warehouse_block.
















