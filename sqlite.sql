--download file from kaggle https://www.kaggle.com/datasets/afranur/web-analytics-dataset 
--load csv file
.MODE CSV
.LOAD "Web Analytic_Dataset.csv" wanalytics
ALTER TABLE wanalytics ADD COLUMN tdate;
SELECT * FROM wanalytics;
UPDATE wanalytics
SET tdate = Year||'-'||CASE WHEN LENGTH("Month of the year")==2 THEN "Month of the year" ELSE "0" || "Month of the year" END ;

--chart 1, 2, 3
SELECT 
tdate, 
sum(REPLACE("Users",',','')) "Users", 
sum(REPLACE("New Users",',','')) "New Users", 
sum(REPLACE("Sessions",',','')) "Sessions", 
avg(REPLACE("Bounce Rate",'%','')) "Bounce Rate",
sum(REPLACE("Pageviews",',','')) "Pageviews", 
avg(REPLACE("Conversion Rate (%)",',','')) "Conversion Rate (%)",
sum(REPLACE("Transactions",',','')) "Transactions", 
sum(REPLACE("Revenue",',','')) "Revenue",
sum(REPLACE("Quantity Sold",',','')) "Quantity Sold" 
FROM wanalytics
GROUP BY tdate  
ORDER BY tdate;

--chart 4
SELECT
"Source / Medium", 
sum(REPLACE("Revenue",',','')) "Revenue"
FROM wanalytics
GROUP BY "Source / Medium" ORDER BY 2 DESC;

--chart 5
SELECT  
"Source / Medium", 
AVG(CAST("Conversion Rate (%)"AS FLOAT))
FROM wanalytics
GROUP BY "Source / Medium" ORDER BY 2 DESC;

--other sql that u may find useful
WITH cte1 as (
SELECT  tdate,"Source / Medium",Revenue,
row_number() OVER (PARTITION BY tdate ORDER BY CAST(REPLACE("Revenue",',','') AS INT) DESC ) AS rn
FROM wanalytics )
;
