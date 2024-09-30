USE ZOMATO_ANALYSIS;

ALTER TABLE DATA
MODIFY COLUMN Date DATE;

SELECT * FROM DATA;

/*1. Which countries have potential for expansion for Zomato, and how can it grow in these markets?*/
 
 SELECT COUNTRY AS Country, COUNT(RESTAURANTID) AS "No. of Restaurants"
 FROM DATA 
 GROUP BY COUNTRY;
 
 /*2. How have restaurant opening trends varied across countries over time?*/
 
 SELECT COUNTRY AS Country, YEAR(DATE) AS Year, QUARTER(DATE) AS Quarter, MONTH(DATE) AS Month, COUNT(RESTAURANTID) AS "No. of Restaurants"
 FROM DATA 
 GROUP BY COUNTRY, YEAR(DATE), QUARTER(DATE), MONTH(DATE)
 ORDER BY YEAR(DATE), QUARTER(DATE), MONTH(DATE);
 
 /*3. How Zomato can increase the adoption rate of online delivery among restaurants?*/
 
 SELECT HAS_ONLINE_DELIVERY AS "Has Online Delivery",
 CONCAT(ROUND(COUNT(HAS_ONLINE_DELIVERY)/100,2), "%") AS Percentage
 FROM DATA 
 GROUP BY HAS_ONLINE_DELIVERY;
 
 /*4. How do average dining costs and ratings differ across various countries?*/
 
 SELECT COUNTRY AS Country, ROUND(AVG(IN_DOLLARS$),1) AS "Avg. Cost for 2 in Dollars", ROUND(AVG(RATING),1) AS "Avg. Ratings"
 FROM DATA 
 GROUP BY COUNTRY;
 
 /*5. Which countries have the most and least diverse range of popular cuisines based on user votes?*/
 
 SELECT COUNTRY AS Country, CUISINES AS Cuisines, VOTES AS "Total Votes" 
FROM (SELECT
        COUNTRY AS Country,
        CUISINES AS Cuisines,
        SUM(VOTES) AS "Votes",
        ROW_NUMBER() OVER (PARTITION BY COUNTRY ORDER BY SUM(VOTES) DESC) AS R
		FROM DATA
		GROUP BY COUNTRY, CUISINES
) AS Ranked
WHERE R <= 3
ORDER BY VOTES DESC;

/*Total Restaurants*/
SELECT COUNT(RESTAURANTID) AS "TOTAL RESTAURANTS"
FROM DATA;

/*Total Cuisines*/
SELECT COUNT(DISTINCT CUISINES) AS "Total Cuisines"
FROM DATA;

/*Total Votes*/
SELECT SUM(VOTES) AS "Total Votes"
FROM DATA;

/*Average Cost for 2 in Dollars*/
SELECT CONCAT("$",ROUND(AVG(IN_DOLLARS$),2)) AS "Average Cost for 2"
FROM DATA;

/*Average Rating*/
SELECT ROUND(AVG(RATING),2) AS "Average Rating"
FROM DATA;

/*Total Countries*/
SELECT DISTINCT COUNTRY AS Country
FROM DATA;

/*Years*/
SELECT DISTINCT YEAR(DATE) AS Years
FROM DATA
ORDER BY YEAR(DATE);