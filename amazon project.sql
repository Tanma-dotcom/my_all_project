create database amazon_caption_project;
use amazon_caption_project;
select * from amazondata;
									# BUSINESS  QUESTIONS 
select count(*) as count_of_database from amazondata;
 
select count(Product_line) as count_Product_line,Product_line from amazondata group by Product_line;

select Product_line,count(Quantity) as count_of_quantity from amazondata  group by Product_line;

# what is the count of distinct city in dataset?
 select distinct count(distinct city) as count_of_city from amazondata;
 
 # For each branch, what is the corresponding city?

SELECT DISTINCT Branch, city
FROM amazondata;

# What is the count of distinct product lines in the dataset?

SELECT COUNT(DISTINCT Product_line) AS distinct_product_line_count
FROM amazondata;


# Which payment method occurs most frequently?

SELECT Payment, COUNT(*) AS frequency FROM amazondata
GROUP BY Payment
ORDER BY frequency DESC
LIMIT 1;


  # Which product line has the highest sales?

SELECT Product_line , SUM(Quantity) AS total_sales
FROM amazondata
GROUP BY Product_line
ORDER BY total_sales DESC
LIMIT 1;

 # How much revenue is generated each month?
select * from amazondata;
SELECT MONTH(Date) AS month,
YEAR(Date) AS year, SUM(gross_income) AS total_revenue
FROM 
amazondata
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY year, month;



   #In which month did the cost of goods sold reach its peak?

SELECT EXTRACT(YEAR FROM Date) AS year,
EXTRACT(MONTH FROM Date) AS month,
SUM(cogs) AS total_cogs
FROM amazondata
GROUP BY year, month
ORDER BY total_cogs DESC
LIMIT 1;

    #.Which product line generated the highest revenue?

SELECT Product_line,
SUM(gross_income) AS total_revenue
FROM 
amazondata
GROUP BY Product_line
ORDER BY total_revenue DESC
LIMIT 1;


    #In which city was the highest revenue recorded?
 
 
SELECT 
city,
SUM(gross_income) AS total_revenue FROM amazondata
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;

  #Which product line incurred the highest Value Added Tax

SELECT 
Product_line,
SUM(cogs) AS total_vat FROM amazondata
GROUP BY Product_line
ORDER BY total_vat DESC
LIMIT 1;
 
 
 #For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

SELECT  Product_line, Total,
    CASE
    WHEN Total >AVG(Total) OVER (PARTITION BY product_line) THEN 'GOOD'
    ELSE 'BAD'
    END AS SALES_STATUS
    FROM amazondata;
   
   
   #Identify the branch that exceeded the average number of products sold.
   
   SELECT Branch , COUNT(*) AS num_products_sold
FROM amazondata 
GROUP BY Branch
HAVING COUNT(*) > (SELECT AVG(num_products_sold) FROM (SELECT COUNT(*) AS num_products_sold FROM amazondata GROUP BY Branch) AS avg_table);



 #Which product line is most frequently associated with each gender?

SELECT Gender, Product_line, COUNT(*) AS frequency FROM  amazondata 
GROUP BY Gender ,Product_line  
ORDER BY Gender , frequency DESC;

    
  #Calculate the average rating for each product line.
    
    
SELECT Product_line, AVG(Rating) AS average_rating
FROM amazondata
GROUP BY Product_line;
    
    #Count the sales occurrences for each time of day on every weekday.

  SELECT 
    DAYNAME(Date) AS weekday,
    HOUR(Time) AS hour_of_day,
    COUNT(*) AS sales_occurrences
FROM amazondata
GROUP BY 
    weekday, hour_of_day
ORDER BY 
    weekday, hour_of_day;
    
    
    
      #Identify the customer type contributing the highest revenue

SELECT Customer_type, SUM(gross_income) AS total_revenue
FROM amazondata
GROUP BY customer_type
ORDER BY total_revenue DESC
LIMIT 1;



   #Determine the city with the highest VAT percentage.
select * from amazondata;
SELECT
    City,
    Tax
FROM amazondata order by 
    Tax DESC
LIMIT 1;

 # identify the customer type with the highest VAT payments
select * from amazondata;
SELECT Customer_type,SUM(cogs) AS total_VAT_payments
FROM amazondata 
GROUP BY Customer_type
ORDER BY total_VAT_payments DESC
LIMIT 1;

  


#.What is the count of distinct payment methods in the dataset?


SELECT COUNT(DISTINCT Payment) AS distinct_payment_methods_count
FROM amazondata;

    #Which customer type occurs most frequently?
 SELECT Customer_type,
    COUNT(*) AS occurrence_count FROM amazondata
GROUP BY Customer_type
ORDER BY occurrence_count DESC
LIMIT 1;


   #Identify the customer type with the highest purchase frequency.
SELECT 
Customer_type, COUNT(*) AS purchase_frequency
FROM amazondata
GROUP BY Customer_type
ORDER BY purchase_frequency DESC
LIMIT 1;


	#Determine the predominant gender among customers.

SELECT Gender, COUNT(*) AS gender_count
FROM amazondata
GROUP BY Gender
ORDER BY gender_count DESC
LIMIT 1;


#Examine the distribution of genders within each branch.


SELECT Branch, Gender,COUNT(*) AS gender_count
FROM amazondata
GROUP BY Branch, Gender
ORDER BY Branch, gender_count DESC;

  # Identify the time of day when customers provide the most ratings.

SELECT EXTRACT(HOUR FROM Time) AS HourOfDay,
    COUNT(*) AS rating_count
FROM amazondata
GROUP BY HourOfDay
ORDER BY rating_count DESC
LIMIT 1;




   #Determine the time of day with the highest customer ratings for each branch.

SELECT Branch,
    EXTRACT(HOUR FROM Time) AS HourOfDay,
    COUNT(*) AS rating_count
FROM amazondata
GROUP BY Branch, HourOfDay
ORDER BY Branch, rating_count DESC;
    
    
    #Identify the day of the week with the highest average ratings.
    
    SELECT 
    EXTRACT(Day from Date) AS Dayin,
     EXTRACT( week from Date) AS Weekin,
    AVG(Rating) AS average_rating
FROM amazondata
GROUP BY Dayin, Weekin
ORDER BY average_rating DESC
LIMIT 1;


      #Determine the day of the week with the highest average ratings for each branch.


SELECT 
    Branch,
    EXTRACT(day FROM Date) AS Dayoff,
    EXTRACT(week FROM Date) AS OfWeek,
    AVG(Rating) AS average_rating
FROM amazondata
GROUP BY Branch, Dayoff ,OfWeek
ORDER BY Branch, average_rating DESC;


    

