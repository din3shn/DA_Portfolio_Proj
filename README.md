# Portfolio_Projects
Projects based on SQL, Excel, PowerBI, Tableau etc

Welcome to My Portfolio.
I'm a new data analyst learning the process.
Take a look at some of the projects I've been working on while learning.

Data used in these projects was provided mostly from the course I did and Kaggle.


## SQL - Data Cleansing and Exploration

- **Intro** : The data used in this dataset is the sales data of a store for a period of time with multiple platforms and segments.
Added a few columns to the dataset to simplify the exploration process. Exploration is based on a few questions which you can find below 👇🏻.

- **Functions used** :
CREATE, INSERT, UPDATE, SELECT, LIMIT, SUM, COUNT, MOD, AVG, GROUP BY, LIKE, CTE, SUBQUERIES, REGEXP ETC.

- **Schema Used**: weekly_data_sales  

            Column | Data type
      
         week_date | date
            region | varchar(20)
          platform | varchar(20)
           segment | varchar(10)
          customer | varchar(20)
      transactions | int
             sales | int

- ### Data Cleansing Problem: 

In a single query, generate a new table in 
the data_mart schema named clean_weekly_sales and perform the following operations: 

**1**. Add a week_number as the second column for each week_date value.

**2**. Add a month_number with the calendar month for each week_date value as the 3rd column.

**3**. Add a calendar_year column as the 4th column.

**4**. Add a new column called age_band based on the segment column data as follows :  

       segment | age_band
   
             1 | Young Adults
             2 | Middle Aged
        3 or 4 | Retirees   
        
**5**. Add a new demographic column using the following mapping for the first letter in the segment values:

       segment | demographic
   
             C | Couples 
             F | Families 
             
**6**. Ensure all null string values return "unknown".

**7**. Generate a new avg_transaction column rounded to 2 decimal places.


- ### Data Exploration Problems : 

**1**. Which week numbers are missing from the dataset?

**2**. How many total transactions were there for each year in the dataset?

**3**. What are the total sales for each region for each month?

**4**. What is the total count of transactions for each platform.

**5**. What is the percentage of sales for Retail vs Shopify for each month?

**6**. What is the percentage of sales by demographic for each year in the dataset?

**7**. Which age_band and demographic values contribute the most to Retail sales?
