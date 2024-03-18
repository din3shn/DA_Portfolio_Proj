select * from weekly_sales;

### DATA CLEANSING ###

create table clean_weekly_sales as
select
  week_date,
  week(week_date) as week,
  month(week_date) as month,
  year(week_date) as year,
  region, platform,
  case
    when segment = 'null' then 'Unknown'
    else segment
    end as segment,
  case
    when right(segment, 1) = '1' then 'Young Adults'
    when right(segment, 1) = '2' then 'Middle Aged'
    when right(segment, 1) in ('3', '4') then 'Retirees'
    else 'Unknown'
    end as age_band,
  case
    when left(segment, 1) = 'C' then 'Couples'
    when left(segment, 1) = 'F' then 'Families'
    else 'Unknown'
    end as demographic,
  customer_type, transactions, sales,
  round((sales / transactions),2) as avg_transaction
from weekly_sales;

select * from clean_weekly_sales limit 1000;

### DATA EXPLORATION ###

#1. Find out week nunbers missing from clean_weekly_sales table.
create table seq100 (x int not null auto_increment primary key);
DELIMITER $$
create procedure insert_seq100()
begin
declare counter int default 1;
while counter <= 52 do
insert into seq100 (x) values (counter);
set counter = counter + 1;
end while;
end $$
DELIMITER ;
call insert_seq100();
select distinct x as missing_weeks from seq100 
where x not in(select distinct week_number from clean_weekly_sales); 

#2. Total transactions for each year in the dataset?
select year, sum(transactions) as total_transactions
from clean_weekly_sales 
group by year;

#3 .Total sales for each region for each month?
select month, region, sum(sales) as total_sales
from clean_weekly_sales
group by month, region order by month, region;

#4. What is the total count of transactions for each platform
select platform, sum(transactions) as total_transactions
from clean_weekly_sales group by platform;

#5. What is the percentage of sales for Retail vs Shopify for each month?
	-- Using CTE
with cte_monthly_platform_sales as (
  select month,year, platform, sum(sales) as monthly_sales
  from clean_weekly_sales
  group by month, year, platform
)
select month, year,
round(100 * max(case when platform = 'Retail' then monthly_sales else null end)/sum(monthly_sales),2) as retail_percentage, 
round(100 * max(case when platform = 'Shopify' then monthly_sales else null end)/sum(monthly_sales),2) as shopify_percentage
FROM cte_monthly_platform_sales
group by month,year
order by year, month;

	-- Using Partiton By
select month, platform, sum(sales) as monthly_sales, 
(100 * sum(sales)) / sum(sum(sales)) over (partition by platform) as percent
from clean_weekly_sales group by month, platform;

#6. What is the percentage of sales by demographic for each year in the dataset?
-- Using Partition By - in a single column
select year, demographic, sum(sales) as yearly_sales, 
round((100 * sum(sales))/sum(sum(sales)) over (partition by demographic),2) as percentage
from clean_weekly_sales
group by demographic, year
order by year, demographic;

-- Using CTE - New Columns from Case When
with cte_yds as (
select year, demographic, sum(sales) as yearly_sales from clean_weekly_sales
group by year, demographic)
select year, 
round((100* max(case when demographic = 'couples' then yearly_sales else null end)/sum(yearly_sales)),2) as couples_sales,
round((100* max(case when demographic = 'families' then yearly_sales else null end)/sum(yearly_sales)),2) as family_sales,
round((100* max(case when demographic = 'unknown' then yearly_sales else null end)/sum(yearly_sales)),2) as unknown_sales
from cte_yds group by year;

#7. Which age_band and demographic values contribute the most to Retail sales?
select age_band, demographic, sum(sales) as total_sales
from clean_weekly_sales
where platform = 'Retail'
group by age_band, demographic
order by total_sales desc;

