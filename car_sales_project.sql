-- using car_sales project data
USE car_sales

--Q1:  First, we will select everything to have a look at how our data looks
-- Note: We did not do joins or unions since this is only one table (car_sales_project). 
select * 
from car_sales_project;

-- From above, we see that some columns such as Engine_Size have inconsistent decimal places
--Q2: Write a query to round Engine_size, power_perf_factor, wheelbase, length, width, curb_weight, fuel_capacity to two decimals

SELECT
	ROUND(Engine_Size, 2) AS Engine_Size,
    ROUND(Power_Perf_Factor, 2) AS Power_Perf_Factor,
    ROUND(Wheelbase, 2) AS Wheelbase,
    ROUND(Width, 2) AS Width,
    ROUND(Length, 2) AS Length,
    ROUND(Curb_Weight, 2) AS Curb_Weight,
    ROUND(Fuel_Capacity, 2) AS Fuel_Capacity
FROM car_sales_project;

-- Q3: We updated the above, however, when we selected all(*) data again, it showed data was unchanged
-- The reason is that this was done for displaying purposes.
--We can either create a new table with updated data or directly update table
--we update the table, but be cautious if you have a real world project, this is irreversible, this project is for practice
UPDATE car_sales_project
SET 
	Engine_Size = ROUND(Engine_Size, 2),
	Power_Perf_Factor = ROUND(Power_perf_Factor, 2),
	Wheelbase = ROUND(Wheelbase, 2),
	Width = ROUND(Width, 2),
	Length = ROUND(Length, 2),
	Curb_Weight = ROUND(Curb_Weight, 2),
	Fuel_Capacity = ROUND(Fuel_Capacity, 2)

--Q4: Write a query to check for null values in all columns 
SELECT *
FROM car_sales_project
WHERE Manufacturer IS NULL OR Model IS NULL OR Unit_Sales IS NULL OR Price IS NULL OR Year_Resale_Value IS NULL 
OR Retention IS NULL OR Retention_Value IS NULL OR Engine_Size IS NULL OR Horsepower IS NULL 
OR HP_Level IS NULL OR Vehicle_type IS NULL OR Fuel_Efficiency IS NULL OR Power_Perf_Factor IS NULL
OR Wheelbase IS NULL OR Width IS NULL OR Length IS NULL OR Curb_Weight IS NULL 
OR Fuel_Capacity IS NULL OR Latest_Launch IS NULL;

-- Q5: Qrite a query to return not only null, but also EMPTY and SPACES in the column Manufacturer
-- ISNULL() function will return any spaces, empty or null values 
SELECT Manufacturer FROM car_sales_project
WHERE ISNULL(Manufacturer, '') = ''

-- Q6: Write a query to check for the length of data in a specified column which equals 0
-- the function will return ONLY no data rows, meaning EMPTY spaces

SELECT * FROM car_sales_project 
WHERE DATALENGTH(Model) = 0

--Q7: write a query to find any possible ZEROEs (0) in the calumns manufacturer, model, unit_sales and Price
-- Note: For manufacturer and model, we use "LIKE" since these are varchar and not int
SELECT Manufacturer, Model, Unit_Sales, Price
FROM car_sales_project
WHERE Manufacturer LIKE '0' OR Model LIKE '0' OR Unit_Sales = 0 OR Price = 0;

--Q8: write a new query to create new table customer_info with columns: customer_id, firt_name, last_name, city, state

CREATE TABLE customer_info (
customer_id INT PRIMARY KEY, 
first_name VARCHAR(50),
last_name VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50)
);

--Q9: Write a query to add some values to the table we created above, customer_info
-- Note: we can write more values as long we have right syntax and structure
INSERT INTO customer_info	
(customer_id, first_name, last_name, city, state)
VALUES
(1, 'Mike', 'Sema', 'Dallas','Texas'),
(2, 'Mira','Hiba','Sinjar','Ninevah');

-- 10: Write a query to update values in customer_info table, 'Mike', 'Sema' to 'Mola', 'Hamida' 

UPDATE customer_info 
SET first_name = 'Mola', last_name = 'Hamida' 
WHERE first_name = 'Mike' AND last_name = 'Sema';

-- Q11: write a query to selecta and retrieve everything in the new table we created, customer_info

SELECT * FROM customer_info

--Q12: The table above, customer_info, we created it for practice purposes, we will now write queries to delete it
-- write a query to delete column first_name

ALTER TABLE customer_info
DROP COLUMN first_name

-- Q13: write a query to delete table customer_info (we had created this table for practice purposes).
-- Note: be careful when executing the below statement as it will permanently remove table and all it is contents

DROP TABLE customer_info

-- Q14: Write a query to rerieve info from columns: manufacturer, model, engine_size and retention
SELECT DISTINCT Manufacturer, Model, Engine_Size, Retention 

FROM car_sales_project;

-- Q15: write a query to retrieve only BMW and retention over 70%, limit results to 8
-- Note: limit is NOT supported in standard SQL SERVER, so we will use TOP AND ORDER BY 

SELECT TOP 8 *
FROM car_sales_project
WHERE Manufacturer = 'BMW' AND Retention > '70%'
ORDER BY Retention DESC;

-- Q16: Write a query to retrieve data where unit sales are at least 20000, retention_value is Good and Engine_size is at least 1
SELECT DISTINCT Unit_Sales, Retention_Value, Engine_Size
FROM car_sales_project
WHERE Unit_Sales >= 20000 AND Retention_Value = 'GOOD' AND Engine_Size >= 1
ORDER BY Engine_Size;

-- Q17: write a query to return data of cars where horsepower is at least 210, vehicle type is car and fuel ifficiency is at least 15

SELECT Horsepower, Vehicle_type, Fuel_Efficiency
FROM car_sales_project
WHERE Horsepower >= 210 AND Vehicle_type = 'Car' AND Fuel_Efficiency >= 15
ORDER BY Fuel_Efficiency;

-- Q18: write a query to get data of cars as follow: retention value is poor and hp level is at least medium 
SELECT Retention_Value, HP_Level
FROM car_sales_project 
WHERE Retention_Value = 'POOR' AND (HP_Level = 'Medium HP' OR HP_Level = 'High HP');

-- Q19: write a query to return all car details but only when after date 12/30/2011

SELECT *
FROM car_sales_project
WHERE Latest_Launch >  '2011-12-30'
ORDER BY Latest_Launch;

--Q20: Write a query to show all car data where year_resale_value is more than 26000 and vehicle type is car

SELECT * 
FROM car_sales_project
WHERE Year_Resale_Value > 26000 AND Vehicle_type = 'Car'
ORDER BY Year_Resale_Value;

--Q21: write a query to show all car details where Model is M-Class or RX300 

SELECT * 
FROM car_sales_project
WHERE Model = 'M-Class' OR Model = 'RX300'; 

--Q22: write a query to retrieve info where Power factor is at least 70 and wheelbase is at least 100

SELECT Power_Perf_Factor, Wheelbase
FROM car_sales_project
WHERE Power_Perf_Factor >= 70 AND Wheelbase >= 100
GROUP BY Power_Perf_Factor, Wheelbase;

--Q23: Write a query to return car data but only of models Quest, RL and C70

SELECT * 
FROM car_sales_project 
WHERE Model = 'Quest' OR Model = 'RL' OR Model = 'C70'
ORDER BY Model;

--Q24: write a query and show data of cars as follow: wheel at least 80, Width at least 65 and Length more than 160

SELECT Wheelbase, Width, Length
FROM car_sales_project WHERE Wheelbase >= 80 AND Width >= 65 AND Length > 160
ORDER BY Wheelbase;

--Q25: Write a query to show data of Curb weight of cars is less than 3 and fuel capacity of cars is more than 16

SELECT * 
FROM car_sales_project 
WHERE Curb_Weight < 3 AND Fuel_Capacity > 16;