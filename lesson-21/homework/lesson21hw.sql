--1.
select*, 
row_number() over(order by SaleDate) as rw
from ProductSales
--2.
select ProductName, sum(Quantity) as totalQty,
dense_rank()  over(order by sum(Quantity)) as orderedByTotalQty
from ProductSales
group by ProductName
--3.
;with cte as (select*, 
dense_rank() over (partition by customerID order by SaleAmount desc) as rnk
from ProductSales)
select*from cte 
where rnk =1
--4.
select*, 
lead(saleAmount) over (order by SaleDate) as next
from ProductSales
--5.
select*, 
lag(saleAmount) over (order by SaleDate) as previous
from ProductSales
--6.
;with cte as (select*, 
lag(saleAmount) over (order by SaleDate) as previous
from ProductSales)
select*from cte where SaleAmount>previous
--7.
;with cte as (select*, 
lag(saleAmount) over ( partition by ProductName order by SaleDate) as previous
from ProductSales)
select SaleAmount-previous as difference from cte
select*from ProductSales
--8.
;with cte as (select*, 
lead(saleAmount) over ( order by SaleDate) as next
from ProductSales)
select (next-SaleAmount)*100 as difference from cte
--9.
;with cte as (select*, 
lag(saleAmount) over ( partition by ProductName order by SaleDate) as previous
from ProductSales)
select SaleAmount*1.0/Previous from cte
--10.
;with cte as (select*, 
FIRST_VALUE(SaleAmount) over (partition by ProductName order by SaleDate) as first
from ProductSales)
select *,  SaleAmount-first as difference from cte 
--11.
;with cte as (select*, 
lag(SaleAmount) over(partition by ProductName order by SaleDate) as previous 
from ProductSales
)
select*from cte
where SaleAmount>previous
--12.
;with cte as (select*,
SUM(SaleAmount) over(order by SaleAmount) as closingBalance
from ProductSales)
select* from cte
--13.
select*,
AVG(SaleAmount) 
over(order by SaleDate rows between 2 preceding and current row ) as avgOfAbove3Sales
from ProductSales
--14.
;with cte as (select*, 
AVG(SaleAmount) over() as AvgSale
from ProductSales)
select SaleAmount-avgSale  as differenceBetweenAVGandSale from cte
--15.
;with cte as (select*,
dense_rank() over(order by Salary desc ) as rnk
 from Employees1)
 select*from cte as cte1
 join (
  select rnk ,count(*)as counted from cte 
 group by rnk 
 having count(*)>1) as cte2
 on cte1.rnk=cte2.rnk
 --16.
;with cte as ( select*,
 rank() over(partition by department order by Salary desc) as rankedbyHighestSalary
 from Employees1
)
select *from cte 
where rankedbyHighestSalary<=2
--17.
;with cte as (select*,
rank() over (partition by department  order by Salary asc) as rankedbyLowestSalary
from Employees1)
select*from cte
where rankedbyLowestSalary=1
--18.
select*,
sum(salary) over(partition by department order by Salary desc) as RunningTotalSalary
from Employees1
--19.
select *,
SUM(Salary) over(partition by department) as avgSalaryinEachDep
from Employees1
--20.
select *,
AVG(Salary) over(partition by department) as avgSalaryinEachDep
from Employees1
--21.
;with cte as (select *,
AVG(Salary) over(partition by department) as avgSalaryinEachDep
from Employees1)
select *, Salary-avgSalaryinEachDep  as differenceBetweenEmpSalaryandAvgSalaryByDep
from cte
--22.
select*,
AVG(Salary) 
over(order by EmployeeID  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as avgOfAbove3Sales
from Employees1
--23.
select SUM(Salary) as totalSalary from
(select top 3 salary from employees1 order by HireDate desc) as last3
