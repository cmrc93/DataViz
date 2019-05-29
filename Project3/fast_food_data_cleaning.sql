CREATE DATABASE restaurant_data;

USE restaurant_data;

-- check that data was uploaded (1st fast food CSV)
SELECT*FROM fast_food_restaurants;

-- upload second CSV and check that its uploaded
SELECT*FROM zip_demos;

-- join tables
SELECT
fast_food_restaurants.text_id,
fast_food_restaurants.name,
fast_food_restaurants.latitude,
fast_food_restaurants.longitude,
fast_food_restaurants.postalCode,
zip_demos.pct_College_Degree_or_more,
zip_demos.pct_AA,
zip_demos.pct_Hispanic,
zip_demos.Hispanic_and_AA_Pops,
Median_HH_Income,
zip_demos.Total_Pops
FROM fast_food_restaurants
LEFT JOIN zip_demos ON zip_demos.Zip = fast_food_restaurants.postalCode
ORDER BY fast_food_restaurants.text_id;

-- creating new table from joined query
CREATE TABLE merged_table AS
SELECT
fast_food_restaurants.text_id,
fast_food_restaurants.name,
fast_food_restaurants.latitude,
fast_food_restaurants.longitude,
fast_food_restaurants.postalCode,
zip_demos.pct_College_Degree_or_more,
zip_demos.pct_AA,
zip_demos.pct_Hispanic,
zip_demos.Hispanic_and_AA_Pops,
Median_HH_Income,
zip_demos.Total_Pops
FROM fast_food_restaurants
LEFT JOIN zip_demos ON zip_demos.Zip = fast_food_restaurants.postalCode
ORDER BY fast_food_restaurants.text_id;

-- looking at new table
SELECT * FROM merged_table;

-- deleting duplicates
-- DELETE p1 FROM merged_table p1
-- INNER JOIN merged_table p2 
-- WHERE p1.unique_id < p2.unique_id AND p1.text_id = p2.text_id;
 
-- delete worked 9333 of 9988 values left

 -- DELETE NULL VALUES
 DELETE FROM merged_table WHERE Median_HH_Income IS NULL;
 
 -- check whats left
 SELECT * FROM merged_table;
 
 -- count values make sure we have a large enough sample size
 SELECT COUNT(*)
 FROM merged_table;
 
 -- 6,779 values remain

    






    
    