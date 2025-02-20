-- Menu Analysis

Select * 
from menu_items;

-- Check for Duplicates 

Select menu_item_id, count(menu_item_id)
from menu_items
group by menu_item_id
having count(menu_item_id) > 1;

-- Total Number of Items on the Menu

Select count(item_name) as total_items
from menu_items;

-- Least and Most Expensive Items

select *
from menu_items
order by price;

select *
from menu_items
order by price desc;

-- Number of American Dishes 

Select category, count(category) as No_of_dishes
from menu_items
where category = 'American'
group by category;

-- Least and Most Expensive American Dish 

Select *
from menu_items	
where category = 'American'
order by price; 

Select *
from menu_items	
where category = 'American'
order by price desc; 

--  Dishes per Category

Select category, count(category) as No_of_dishes
from menu_items
group by category;

-- Average Price per Category 

Select category, avg(price)
from menu_items
group by category;

-- Order Analysis

Select *
from order_details;

-- Check for Duplicates 

Select order_details_id, count(order_details_id)
from order_details
group by order_details_id
having count(order_details_id) > 1;

-- Date Range of Orders

Select min(order_date), max(order_date)
from order_details;

-- Total Items Ordered

Select count(*) 
from order_details;

-- Items per Order and Total Number of Orders

Select order_id, count(order_id)
from order_details
group by order_id;

Select count(distinct order_id) as total_orders
from order_details;

-- or

with items_per_order as
(
	Select order_id, count(order_id) as item_per_order
	from order_details
	group by order_id
)
Select count(order_id) as total_orders
from items_per_order;

-- Order with the Most Items

Select order_id, count(order_id) as num_of_items
from order_details
group by order_id
order by count(order_id) desc;

-- Orders with more than 12 Items

Select order_id, count(order_id) as num_of_items
from order_details
group by order_id
having num_of_items > 12
order by count(order_id);

-- Number of Orders with more than 12 Items
    
with items_per_order as
(
	Select order_id, count(order_id) as num_of_items
	from order_details
	group by order_id
	having num_of_items > 12
)
Select count(order_id)
from items_per_order;

-- OR

Select count(*)
from
	(Select order_id, count(order_id) as num_of_items
	from order_details
	group by order_id
	having num_of_items > 12) AS num_orders;
    
-- Sales Analysis
-- Total Sales by Category 

Select * 
from menu_items as mi
join order_details as od
	on mi.menu_item_id = od.item_id;
    
with sales_per_category as
(
	Select * 
	from menu_items as mi
	join order_details as od
	on mi.menu_item_id = od.item_id
)
Select category, sum(price) as total_sales 
from sales_per_category
group by category
order by 2 desc;

-- Top 5 Most Mopular Items

with best_selling as
(
	Select * 
	from menu_items as mi
	join order_details as od
	on mi.menu_item_id = od.item_id
)
Select item_name, count(item_name) as num_of_orders
from best_selling
group by item_name
order by 2 desc
limit 5;

-- Daily Sales Trends

with sales_trend as
(
	Select * 
	from menu_items as mi
	join order_details as od
	on mi.menu_item_id = od.item_id
)
Select order_date, count(distinct order_id) as total_orders, sum(price) as total_revenue
from sales_trend
group by order_date
order by order_date;