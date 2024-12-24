SELECT * FROM PIZZAS;

SELECT * FROM PIZZA_TYPES;

SELECT * FROM ORDERS;

SELECT * FROM ORDER_DETAILS;

-- Retrieve the total number of orders placed.

SELECT COUNT(ORDER_ID) AS TOTAL_ORDERS FROM ORDERS;

--Calculate the total revenue generated from pizza sales.

SELECT 
ROUND(SUM(PIZZAS.PRICE * ORDER_DETAILS.QUANTITY), 2) AS totaL_Revenue_generated
FROM PIZZAS JOIN ORDER_DETAILS ON PIZZAS.PIZZA_ID = ORDER_DETAILS.PIZZA_ID;

--Identify the highest-priced pizza.

SELECT PIZZA_TYPES.name , PIZZAS.PRICE
FROM PIZZA_TYPES 
JOIN PIZZAS
ON PIZZA_TYPES.PIZZA_TYPE_ID = PIZZAS.pizza_type_id
ORDER BY PIZZAS.PRICE  DESC 

-- Identify the most common pizza size ordered.

select pizzas.size , count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count


--List the top 5 most ordered pizza types 
--along with their quantities.

SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC;

-- Join the necessary tables to find the 
-- total quantity of each pizza category ordered.

select pizza_types.category,
sum(order_details.quantity) as total_quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details
on order_details.pizza_id = pizzas.pizza_id
Group by pizza_types.category
order by total_quantity desc;



-- Join relevant tables to find the 
--category-wise distribution of pizzas.

select category , count(pizza_type_id) as number from pizza_types
group by category;


-- Group the orders by date and calculate the average
--  number of pizzas ordered per day.

select avg(pizzas_ordered_per_day) as avg_pizzas_ordered_per_day
from
(select orders.order_date , sum(order_details.quantity) as pizzas_ordered_per_day
from orders join order_details
on orders.order_id = order_details.order_id 
group by orders.order_date ) as order_quantity;


--Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name , sum(order_details.quantity * pizzas.price) as pizza_types_based_on_revenue
from  pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name 
order by pizza_types_based_on_revenue desc;










