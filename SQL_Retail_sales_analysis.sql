
create table retail_sales (
transactions_id	INT  Primary  key,
sale_date	DATE,
sale_time	TIME,
customer_id	INT,
gender	varchar(10),
age	INT,
category	VARCHAR(30),
quantiy	INT,
price_per_unit FLOAT,	
cogs	float,
total_sale float
);

select * from retail_sales
WHERE transactions_id is  null;

select * from retail_sales
WHERE transactions_id is  null
or sale_date is  null
or sale_time is null
or 	customer_id is null
or gender is null
or age is  null
or category is  null
or quantiy is  null
or price_per_unit is  null
or cogs is  null
or total_sale is  null;

-- coalesce(total_sale is  null  then 1  elase 0 ) as total_sale
-- coalesce(cogs is  null  then 1  elase 0 ) as total_sale

delete from retail_sales
WHERE transactions_id is  null
or sale_date is  null
or sale_time is null
or 	customer_id is null
or gender is null
or age is  null
or category is  null
or quantiy is  null
or price_per_unit is  null
or cogs is  null
or total_sale is  null;

-- How many sales we have?

SELECT count(*) as total_sale from retail_sales;

-- How many uniuque customers we have ?


select count(distinct customer_id) as unique_customer from  retail_sales;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * from  retail_sales
where  sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022


select 
*
from retail_sales 
where  
     category = 'clothing' 
     and 
     quantiy > 2
	 and 
	 TO_CHAR(sale_date , 'yyyy-mm')='2022-11';

Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,sum(total_sale) as  total_sales,count(*)
from  retail_sales
group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select ROUND(avg(age),0) as avg_age,customer_id,count(*)
from retail_sales
where  category= 'Beauty'
group by  2

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select transactions_id
from retail_sales 
where  total_sale>=1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select gender,
category,
count(transactions_id) as  totl_trans
from  retail_sales
group  by 1,2

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * FROM
(select 
EXTRACT (YEAR from sale_date) as year,
EXTRACT (month from sale_date) as month,
avg(total_sale) as avg_sale,
rank() over (partition by EXTRACT (YEAR from sale_date) order  by  avg(total_sale) desc  ) as rnk
FROM  retail_sales group  by 1,2 ) as t
where  rnk=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id,sum(total_sale) from retail_sales
group  by 1
order by 2 desc 
limit  5 ;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count (distinct customer_id) as customer
from  retail_sales
group  by category ;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales as 
(
select *,
case  
     when extract(hour  from sale_time ) <12 then  'Morning'
     when extract(hour  from sale_time ) <17 then   'After noon'
     else 'evening'
	 end  as shift
	 from  retail_sales )
	 select 
	 shift,count(*) as total_order
	 from  hourly_sales
	 group  by shift;





