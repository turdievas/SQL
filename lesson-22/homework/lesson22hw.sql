--Easy questions
--1.
select*,
SUM(total_amount) over(partition by customer_id order by sale_id) as running_total
from sales_data
--2.
select*,
count(*) over(partition by product_category ) as counted_orders
from sales_data
--3.
select*,
MAX(total_amount) over(partition by product_category) as max_total_amount
from sales_data
--4.
select*,
MIN(unit_price) over(partition by product_category) as min_unit_price
from sales_data
--5.
select*,
AVG(total_amount) 
over(order by order_date rows between 1 preceding and 1 following) as avg_total_amount
from sales_data
--6.
select*,
MAX(total_amount) over(partition by region) as max_total_amount_per_region
from sales_data
--7.
;with cte as (select*,
SUM(total_amount) over(partition by customer_id) as total_amount_per_customer
from sales_data),
 cte2 as(
select distinct customer_id, total_amount_per_customer from cte)
select *,
dense_rank() over(order by total_amount_per_customer desc) as d_rnk
from cte2
--8.
;with cte as (select*,
lag(total_amount) over(partition by customer_id order by order_date ) as prevSale
from sales_data)
select  customer_id, order_date, total_amount, prevSale, 
isnull(total_amount-prevSale, 0) as  difference_betweeen_prev_and_cur_sale from cte
--9.
;with cte as (select*,
row_number() over(partition by product_category order by unit_price desc) as ordered
from sales_data)
select*from cte
where  ordered<=3
--10.
select *,
SUM(total_amount) over(partition by region order by order_date) as cum_sum_of_sales
from sales_data
---Medium Questions
--11.
select*,
SUM(total_amount)
over(partition by product_category order by order_date) as cum_of_sales_per_category
from sales_data
--12.
select*,
SUM(ID) over(order by ID) as sum_of_prevID
from sample_ids
--13.
select*,
SUM(value) over(order by value) as sum_of_previous
from OneColumn
--14.
;with cte as (SELECT customer_id
FROM sales_data
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) > 1)
select s1.customer_id, s2.product_category from cte as s1
join  sales_data as s2
on s1.customer_id=s2.customer_id
--15.
;with cte as (select*,
avg(total_amount ) over(partition by region) as avg_spending
from sales_data
)
select *from cte
where total_amount>avg_spending
--16.
;with cte as (select customer_id, region 
, SUM(total_amount) as sum_amount
from sales_data
group by customer_id, region )
select *,
dense_rank() over(partition by region order by sum_amount desc) as d_rnk
from cte
--17.
select *,
SUM(total_amount) over(partition by customer_id order by order_date) as cum_total_amount
from sales_data
--18.
;with cte as (
select*,
lag(total_amount) over ( partition by MONTH(order_date) order by order_date) as prev_month_sales
from sales_data)
select*, ((total_amount-prev_month_sales)*1.0/prev_month_sales)*100 as sale_growth from cte
--19.
;with cte as (
select *,
lag(total_amount) over( partition by customer_id order by order_date) as prev_sale
from sales_data)
select * from cte
where total_amount>prev_sale
--Hard Questions
--20.
;with cte as (select *,
AVG(unit_price) over (partition by product_name ) as avg_price_per_product
from sales_data)
select * from cte
where unit_price>avg_price_per_product
--21.
select *,
row_number() over( partition by grp order by id) as rw,
case when row_number() over( partition by grp order by id)=1 then total
else NULL 
end as tot
from (select *,
SUM(val1+val2) over (partition by grp)  as total
from MyData)
as derived 
--22.
;with cte as (select ID, 
SUM(cost) as cost,
SUM(distinct quantity) as quantity
from TheSumPuzzle
group by ID)
select * from cte
