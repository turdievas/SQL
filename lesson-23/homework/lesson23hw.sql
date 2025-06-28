--1.
select *, 
case when month(dt)<10 then concat('0', month(Dt))
else cast(month(dt) as varchar(50)) end as monthPrefixedWithZero
from dates
--2.
select COUNT(distinctID)as distinct_ids, MAX(rID) as rID, SUM(maxx)  as totalOfMaxValues
from (select id, COUNT(distinct id) as distinctID, MAX(rID) as rID,
MAX(vals) as maxx
from MyTabel
group by id) as derived
--3.
select * from TestFixLengths
where len(vals) between 6 and 10
--4.
select a.ID, a.item, b.vals from TestMaximum as a
join(
select id, MAX(vals) as vals from TestMaximum
group by id ) as b
on a.vals=b.vals and a.id=b.id
--5.
select Id, SUM(highest) as SumOfMax from (select ID, detailedNumber, MAX(vals) as highest  from SumOfMax
group by ID, detailedNumber) as derived
group by ID
--6.
select id, a, b,
case when dif=0 then replace(dif, '0', ' ')
else dif end as output
from (select *, cast(a-b as varchar(50)) as dif from TheZeroPuzzle)
as derived
--7.
select 
SUM(QuantitySold*UnitPrice) as totalRevenue
from sales
--8.
select 
avg(UnitPrice)  as avgUnitPrice
from sales
--9.
select 
count(*) as transactionsRecorded
from sales
--10.
select 
MAX(QuantitySold) as highestUnitPrice
from sales
--11.
select category, count(Product) as counted from sales
group by Category
--12.
select region  ,
SUM(QuantitySold*UnitPrice) as totalRevenue
from sales
group by region 
--13.
select top 1 product, 
sum(quantitySold*UnitPrice) as totalRevenue
from sales
group by Product
order by totalRevenue
--14.
select sum(QuantitySold*UnitPrice) over(order by saleDate) as runningTotal
from sales
--15.
;with cte as (
select *,
SUM(QuantitySold*UnitPrice) over() as totalRev,
SUM(QuantitySold*UnitPrice) over(partition by category) as categoryTotal
from sales)
select *,     CAST(1.0 * categoryTotal / totalRev * 100 AS DECIMAL(10,2)) 
AS contributionPercentage
 from cte
 --17.
 select c.CustomerName, s.* from customers as c
 join sales as s
 on c.CustomerID=s.CustomerID
 --18.
  select * from customers as c
 left join sales as s
 on c.CustomerID=s.CustomerID
 where s.CustomerID is null
 --19.
 select customerID, 
 SUM(QuantitySold*UnitPrice) as total_rev_each_cust
 from sales
 group by CustomerID
 --20.
select top 1 customerID,
SUM(QuantitySold*UnitPrice) as revenue
from sales
group by CustomerID
order by revenue desc
--21.
select CustomerID, 
SUM(QuantitySold*UnitPrice) as total_sales
from sales
group by CustomerID
--22.
select  p.ProductName, s.quantitySold from Products as p
join sales as s
on  p.ProductName=s.Product
where s.QuantitySold>=1
--23.
select * from products where
costPrice= (select MAX(CostPrice) as highest
from products)
--24.
select * from products as a
where SellingPrice>(select AVG(SellingPrice) from Products as b
where a.Category=b.Category)
