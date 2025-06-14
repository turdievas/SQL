

--1.
SELECT d.distributor, r.region, 
isnull(
(select sum(s.sales) from #RegionSales as s
where s.Distributor=d.Distributor and s.Region=r.region
),0
) as total_sales
FROM 
    (SELECT DISTINCT distributor FROM #RegionSales) AS d
CROSS JOIN 
    (SELECT DISTINCT region FROM #RegionSales) AS r
ORDER BY d.distributor;
--2.
select emp2.id, emp2.name--, count(emp1.managerid) 
from Employee as emp1
join Employee as emp2
on emp2.id=emp1.managerId
group by emp2.id ,emp2.name
having count(emp1.managerid)>=5
--3.
select * from Products
JOIN(
select product_id, sum(unit) as Total_unit from Orders
where year(order_date)=2020 and month(order_date)=2
group by product_id
having sum(unit)>=100
) as Total_sales
on Products.product_id=Total_sales.product_id
--4.
;with cte as(
select *, (select sum([COUNT]) from Orders as ord2 where
ord1.CustomerID=ord2.CustomerID and ord1.Vendor=ord2.Vendor) as Total
from Orders as ord1
)
select distinct customerID, vendor from cte
where Total=(select Max(Total) 
from cte as cte1 where cte.CustomerID=cte1.CustomerID)
--5.
DECLARE @Check_Prime INT = 91;
declare @i int =2;
declare @isPrime int =1;
while @i<@Check_Prime 
begin
if @Check_Prime%@i=0
begin 
 set @isPrime=0;
end
set @i+=1;
end
if @isPrime=1
print cast(@check_Prime as varchar) + 'is prime number';
else 
 print cast(@check_Prime as varchar) + ' is not a prime number';
--6.
with cte as(
select *, 
(Select count(locations) from
device as dev where dev.Device_id=device.Device_id 
and dev.Locations=device.Locations) as cnt_loc
from Device
)
select distinct cte.Device_id,cte.Locations, 
aggregated.cnt_locs,aggregated.cnt_distc_loc from cte

JOIN (select Device_id, count(Locations) as cnt_locs,
count(distinct locations) as cnt_distc_loc  
from Device group by Device_id) as aggregated
on cte.Device_id=aggregated.Device_id
where cnt_loc=(select max(cnt_loc) 
from cte as cte1 where cte.Device_id=cte1.Device_id)
--7.
select *, (select avg(salary) from Employee as emp2 where emp2.DeptID=emp1.deptid)
as avg_salary from Employee as emp1
where Salary>(select avg(salary) from Employee as emp2 where 
emp2.DeptID=emp1.deptid)
--10
WITH DeGrouped AS (
  SELECT Product, Quantity, 1 AS Counter
  FROM Grouped
  WHERE Quantity > 0
  UNION ALL
  SELECT Product, Quantity, Counter + 1
  FROM DeGrouped
  WHERE Counter + 1 <= Quantity
)
SELECT Product, 1 AS Quantity
FROM DeGrouped
ORDER BY Product
OPTION (MAXRECURSION 1000);


