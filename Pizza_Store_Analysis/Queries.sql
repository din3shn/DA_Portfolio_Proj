use pizza_storeDB;

-- Retrieve the total number of orders placed.

SELECT 
  COUNT(order_id) AS Total_Orders 
FROM 
  orders;


-- Calculate the total revenue generated from pizza sales.

SELECT 
  ROUND(SUM(p.price * od.quantity), 2) AS Total_Sales 
FROM 
  pizzas AS p 
  INNER JOIN order_details AS od ON p.pizza_id = od.pizza_id;


-- Identify the highest-priced pizza.

SELECT 
  TOP (1) pt.name, ROUND(MAX(p.price), 2) AS price 
FROM 
  pizza_types AS pt 
  INNER JOIN pizzas AS p ON pt.pizza_type_id = p.pizza_type_id 
GROUP BY 
  pt.name 
ORDER BY 
  price DESC;


-- Identify the most common pizza size ordered.

SELECT 
  pizzas.size, 
  COUNT(order_details.order_id) AS Orders 
FROM 
  pizzas 
  INNER JOIN order_details ON pizzas.pizza_id = order_details.pizza_id 
GROUP BY 
  pizzas.size;


-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
  TOP (5) pt.name, 
  SUM(od.quantity) AS Qty 
FROM 
  pizzas p
  INNER JOIN order_details od ON p.pizza_id = od.pizza_id 
  INNER JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id 
GROUP BY 
  pt.name 
ORDER BY 
  Qty DESC;


-- Total quantity of each pizza category ordered.

SELECT 
  pt.category, 
  SUM(od.quantity) AS Qty 
FROM 
  pizzas p
  INNER JOIN order_details od ON p.pizza_id = od.pizza_id 
  INNER JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id 
GROUP BY 
  pt.category 
ORDER BY 
  Qty DESC


-- Distribution of orders by hour of the day.

SELECT 
  DISTINCT DATEPART(hour, time) AS hour, 
  COUNT(order_id) AS orders 
FROM 
  orders 
GROUP BY 
  DATEPART(hour, time) 
ORDER BY 
  hour;


-- Find the category-wise distribution of pizzas.

SELECT 
  category, 
  COUNT(name) AS Pizzas 
FROM 
  pizza_types 
GROUP BY 
  category;


-- Group the orders by date and calculate the average number of pizzas ordered per month.

SELECT 
  DATENAME(MONTH, dt) AS month, 
  AVG(qt) AS average_quantity 
FROM 
  ( SELECT o.date AS dt, SUM(od.quantity) AS qt 
    FROM orders AS o INNER JOIN order_details AS od ON o.order_id = od.order_id 
    GROUP BY o.date
    ) AS sub 
GROUP BY 
  DATENAME(MONTH, dt)


-- Determine the top 5 most ordered pizza types based on revenue.

SELECT 
  TOP (5) pt.name AS pizza_type, 
  ROUND( SUM(od.quantity * p.price), 0 ) AS Total_Revenue 
FROM 
  pizza_types AS pt 
  INNER JOIN pizzas AS p ON pt.pizza_type_id = p.pizza_type_id 
  INNER JOIN order_details AS od ON od.pizza_id = p.pizza_id 
GROUP BY 
  pt.name 
ORDER BY 
  Total_Revenue DESC

 

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
  pt.category AS pizza_type, 
  ROUND( SUM(od.quantity * p.price) / ( SELECT SUM(od.quantity * p.price) 
  FROM order_details AS od INNER JOIN pizzas AS p ON od.pizza_id = p.pizza_id) * 100, 2) AS percentage 
FROM 
  pizza_types AS pt 
  INNER JOIN pizzas AS p ON pt.pizza_type_id = p.pizza_type_id 
  INNER JOIN order_details AS od ON od.pizza_id = p.pizza_id 
GROUP BY 
  pt.category 
ORDER BY 
  percentage DESC;

-- With CTE

WITH total_sales AS (
  SELECT 
    SUM(od.quantity * p.price) AS tot_sales 
  FROM 
    order_details AS od 
    INNER JOIN pizzas AS p ON od.pizza_id = p.pizza_id
) 
SELECT 
  pt.category AS pizza_type, 
  ROUND((SUM(od.quantity * p.price) / 
  ( SELECT tot_sales FROM total_sales)) * 100, 2) AS revenue_share 
FROM 
  pizza_types AS pt 
  INNER JOIN pizzas AS p ON pt.pizza_type_id = p.pizza_type_id 
  INNER JOIN order_details AS od ON od.pizza_id = p.pizza_id 
GROUP BY 
  pt.category 
ORDER BY 
  revenue_share DESC;


-- Analyze the cumulative revenue generated over time.

with sales as (
  select 
    o.date as date, 
    round(sum(od.quantity * p.price), 0) as revenue 
  from 
    orders o 
    join order_details od on od.order_id = o.order_id 
    join pizzas p on p.pizza_id = od.pizza_id 
  group by date
) 
select 
  date, sum(revenue) over( order by date) as cumulative_sales 
from 
  sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select 
  category, name, Revenue, rnk as Rank_per_Category 
from 
  (
    select category, name, Revenue, rank() over 
	(partition by category order by Revenue desc) as rnk 
    from 
      (
        select pt.category, pt.name as name, round(sum((od.quantity)*(p.price)), 0) as Revenue 
        from 
          pizza_types pt 
          join pizzas p on pt.pizza_type_id = p.pizza_type_id 
          join order_details od on od.pizza_id = p.pizza_id 
        group by 
          category, 
          name
      ) as sub1
  ) as sub2 
where 
  rnk <= 3;
