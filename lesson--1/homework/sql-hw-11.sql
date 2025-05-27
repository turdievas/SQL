--Easy Level
--1.
select o.OrderID, cust.firstName, cust.lastName, o.orderDate
from customers  as cust 
inner join orders as o on cust.CustomerID=o.CustomerID
where YEAR(o.OrderDate)>2022
--2.
select emp.Name, dep.DepartmentName
from Employees as emp
inner join Departments as dep on dep.DepartmentID=emp.DepartmentID 
and dep.DepartmentName='Sales' or dep.DepartmentName='Marketing'
--3.
select dep.DepartmentName, MAX(emp.Salary) as MaxSalary
from Employees as emp
inner join Departments as dep on dep.DepartmentID=emp.DepartmentID
group by dep.DepartmentName
--4.
select cust.FirstName, cust.LastName, o.OrderID, o.OrderDate
from customers as cust
inner join orders as o on cust.CustomerID=o.CustomerID
where YEAR(o.OrderDate)=2023 and cust.Country='USA'
--5.
select c.firstName, SUM(o.Quantity) as TotalOrders
from customers as c 
inner join Orders as o on o.CustomerID=c.CustomerID
group by c.FirstName
--6.
select p.ProductName, s.SupplierName
from products as p 
inner join Suppliers as s on p.SupplierID=s.SupplierID
where s.SupplierName='Gadget Supplies' or  s.SupplierName='Clothing Mart'
--7.
select cust.CustomerID,  cust.FirstName, MAX(o.OrderDate) as MostRecentOrder
from customers as cust
left join orders as o on o.CustomerID=cust.CustomerID
group by cust.FirstName, cust.CustomerID
order by MAX(o.OrderDate) desc

--Medium Level
--8.
select cust.CustomerID, cust.FirstName, MAX(o.TotalAmount) as OrderTotal
from customers as cust
inner join orders as o on o.CustomerID=cust.CustomerID
group by cust.CustomerID, cust.FirstName
having MAX(o.TotalAmount)>500
--9.
select p.ProductName, s.SaleDate, s.SaleAmount
from products as p 
inner join sales as s on p.ProductID=s.ProductID
where YEAR(SaleDate)=2022 or s.SaleAmount>400
--10.
select p.ProductID, p.ProductName, MAX(s.SaleAmount) as TotalSalesAmount
from products as p 
inner join sales as s on p.ProductID=s.ProductID
group by p.ProductID, p.ProductName
--11.
select e.Name, dep.DepartmentName, e.Salary
from Employees as e
inner join Departments as dep on dep.DepartmentID=e.DepartmentID
where dep.DepartmentName='HR' and e.Salary>60000
--12.
select p.ProductName, s.SaleDate, p.StockQuantity
from products as p 
inner join sales as s on s.ProductID=p.ProductID
where YEAR(s.SaleDate)=2023 and p.StockQuantity>100
--13.
select e.Name, dep.DepartmentName, e.HireDate
from Employees as e 
inner join Departments as dep on dep.DepartmentID=e.DepartmentID
where dep.DepartmentName='Sales' or YEAR(e.HireDate)>2022

--Hard Level
--14.
select cust.FirstName, o.OrderID, cust.Address, o.OrderDate
from customers as cust
inner join orders as o on o.CustomerID=cust.CustomerID
where cust.Country='USA' and cust.Address like '[0-9][0-9][0-9][0-9]%'
--15.
select p.ProductName, p.Category, s.SaleAmount 
from products as p 
inner join sales as s on p.ProductID=s.ProductID
where p.Category='Electronics' or s.SaleAmount>350
--16.
select c.CategoryName, COUNT(p.ProductName) as ProductCount
from products as p 
inner join Categories as c on c.CategoryName=p.Category
group by  c.CategoryName
--17.
select c.FirstName, c.City, o.OrderID, o.TotalAmount
from customers as c
inner join orders as o  on o.CustomerID=c.CustomerID
where c.City='Los Angeles' and o.TotalAmount>300
--18.

select e.Name, dep.DepartmentName
from Employees as e
inner join Departments as dep on dep.DepartmentID=e.DepartmentID
where dep.DepartmentName='HR' or dep.DepartmentName='Finance' 
 OR (
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'a', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'e', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'i', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'o', ''))) +
        (LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'u', '')))
    ) >= 4;

--19.
 select e.Name, d.DepartmentName, e.Salary
 from Employees as e
 inner join 
 departments as d on  d.DepartmentID=e.DepartmentID
 where d.DepartmentName='Sales' or d.DepartmentName='Marketing'
 and e.Salary>60000 
