--Easy Tasks
--1.
;with cte as(
select 1 as num
union all
select num+1 as num from cte 
where num<1000
)
select * from cte
option (maxrecursion 1000)
--2.
select emp.FirstName, emp.LastName, emp.EmployeeID, totalSalePerEmployee from Employees as emp
join 
(select s.employeeID, sum(s.SalesAmount) as totalSalePerEmployee from Sales as s
group by s.employeeID)
as totals
on totals.EmployeeID=Emp.EmployeeID
--3.
;with cte as (
select avg(salary) as avg_salary_of_employees from Employees 
)
select*from cte;
--4.
select *from Products as p
join 
(select s.productID, max(s.SalesAmount) as maxSaleAmount from Sales as s
group by s.productID) as maxSales
on p.ProductID=maxSales.ProductID
--5.
;with cte as(
select 1 as num
union all
select num*2 as num from cte 
where num<=100000
)
select * from cte
option (maxrecursion 0)
--6.
;with cte as (
select e.FirstName, numberOfSales from employees as e
 join 
 (select s.EmployeeID, count(s.SalesAmount) as numberOfSales from Sales as s 
 group by s.EmployeeID
 having count(s.SalesAmount)>5 ) as morethan5
 on e.EmployeeID=morethan5.EmployeeID
)
select*from cte
--7.
;with cte as (
select p.ProductName, sumOfSale from Products as p 
join
(
select s.productID, sum(SalesAmount) as sumOfSale from Sales as s
group by s.ProductID
having sum(SalesAmount)>500
) as result
on result.ProductID=p.ProductID 
)
select*from cte
--8.
;with cte as (
select*from Employees where Salary>
(select avg(salary) as avgSalary from Employees)
)
select*from cte

--Medium Tasks
--1.
select TOP 5 e.FirstName, numberOfSales from employees as e
 join 
 (select s.EmployeeID, count(s.SalesAmount) as numberOfSales from Sales as s 
 group by s.EmployeeID) as smt
 on e.EmployeeID=smt.EmployeeID
 order by smt.numberOfSales desc;
 --2.
 select p.CategoryID, sum(saleOfProducts) as SalesPerCategory  from Products as p 
 join 
 (
 select s.productID, sum(s.SalesAmount) as saleOfProducts from Sales as s
 group by s.ProductID
 ) as perProduct
on p.ProductID=perProduct.ProductID
group by  p.CategoryID
--3.
;WITH max_cte AS (
    SELECT MAX(number) AS max_number FROM Numbers1
),
cte AS (
    SELECT 1 AS num, 1 AS factorial
    UNION ALL
    SELECT cte.num + 1, cte.factorial * (cte.num + 1)
    FROM cte
    CROSS JOIN max_cte
    WHERE cte.num < max_cte.max_number
)
SELECT Numbers1.number, cte.factorial
FROM cte
JOIN Numbers1 ON cte.num = Numbers1.number
OPTION (MAXRECURSION 0);
--4.
;with cte as(
select SUBSTRING(String,1,1) as letter, 1 as checker,
string as full_string from Example
union all
select SUBSTRING(full_string,checker+1,1) as letter,
checker+1, full_string  from cte
where checker<len(full_string)
)
select*from  cte
option (maxrecursion 0)
--5.
;with cte as (
select YEAR(SaleDate) as SaleYear,
 MONTH(SaleDate) as SaleMonth,
 sum(SalesAmount) as totalSales
 from Sales
 group by YEAR(SaleDate) , MONTH(SaleDate)
)
SELECT 
  curr.SaleYear,
  curr.SaleMonth,
  curr.totalSales AS CurrentSales,
  prev.totalSales AS PreviousSales,
  curr.totalSales - prev.totalSales AS SalesDifference
from cte as curr
join cte as prev
on (curr.SaleYear=prev.SaleYear and curr.SaleMonth=prev.SaleMonth+1)
or 
(  curr.SaleYear = prev.SaleYear + 1 AND curr.SaleMonth = 1 
AND prev.SaleMonth = 12
)
--6.
select EmployeeID, Count(*) from 
(select EmployeeID, Year(s.SaleDate) as SaleYear,
Datepart(quarter, s.SaleDate) as quarterDate,
sum(s.SalesAmount) as totalSale
from Sales as s
group by EmployeeID, Year(s.SaleDate), Datepart(quarter, s.SaleDate)) AS result
where  totalSale>45000
group by EmployeeID
having Count(*)=4

--Difficult Tasks
--2.
select*, replace(vals,substring(vals, 1,1),'') as smt from FindSameCharacters
where len(vals)>1 and len(replace(vals,substring(vals, 1,1),''))=0
--3.
DECLARE @n INT = 5;
WITH nums AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(MAX)) AS result
    UNION ALL
    SELECT num + 1, result + CAST(num + 1 AS VARCHAR)
    FROM nums
    WHERE num < @n
)
SELECT result
FROM nums
OPTION (MAXRECURSION 0);
--4.
SELECT e.EmployeeID, e.firstName, topSales.TotalSales
FROM Employees AS e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS topSales
ON e.EmployeeID = topSales.EmployeeID
WHERE topSales.TotalSales = (
    SELECT MAX(SalesSum)
    FROM (
        SELECT SUM(SalesAmount) AS SalesSum
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID
    ) AS totals
);
--5.
