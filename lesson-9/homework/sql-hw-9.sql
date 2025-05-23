--Easy Level
--1.
select ProductName, SupplierName from products
cross join
suppliers
--2.
select DepartmentName, Name from employees
cross join
Departments
--3.
SELECT s.SupplierName, p.ProductName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
--4.
select c.FirstName, o.OrderID
from customers as c
inner join Orders o on c.CustomerID=o.CustomerID
--5.
select*from students
cross join courses
--6.
select p.ProductName, o.orderID
from products as p
inner join orders  o on p.ProductID=o.ProductID
--7.
select e.Name, d.DepartmentName
from employees as e
inner join Departments as d on e.DepartmentID=d.DepartmentID
--8.
select s.Name, e.EnrollmentID
from students as s
inner join Enrollments as e on s.StudentID=e.StudentID
--9.
select o.OrderID, p.PaymentID
from payments as p
inner join Orders as o on o.OrderID=p.OrderID
--10.
select o.OrderID, p.ProductName, p.Price
from orders as o
inner join Products as p on o.ProductID=p.ProductID
where p.Price>100

--Medium Level
--11.
select e.Name, d.DepartmentName
from employees as e
cross join Departments as d
where e.DepartmentID<>d.DepartmentID
--12.
select o.orderID, p.ProductName
from products as p
inner join orders as o on p.ProductID=o.ProductID
where o.Quantity>p.StockQuantity
--13.
select c.FirstName, s.ProductID
from customers as c
inner join Sales as s on c.CustomerID=s.CustomerID
where s.SaleAmount>=500
--14.
select s.Name, c.CourseName
from students as s
inner join enrollments as e on e.StudentID=s.StudentID
inner join courses as c on c.CourseID=e.CourseID
--15.
select p.ProductName, s.SupplierName
from products as p
inner join Suppliers as s on p.SupplierID=s.SupplierID
where s.SupplierName like '%Tech%'
--16.
select o.OrderID, p.PaymentID
from orders as o
inner join Payments as p on p.OrderId=o.OrderID
where p.Amount<o.TotalAmount
--17.
select e.Name, d.departmentName
from employees as e
inner join departments as d on e.DepartmentID=d.DepartmentID
--18.
select p.ProductName, c.CategoryName
from products as p
inner join Categories as c on p.Category=c.CategoryName
where c.CategoryName='Electronics' or c.CategoryName='Furniture'
--19.
select s.*, c.FirstName, c.Country
from sales as s
inner join Customers as c on c.CustomerID=s.CustomerID
where Country='USA'
--20.
select o.*, c.FirstName, c.country, o.TotalAmount
from orders as o 
inner join Customers as c on c.CustomerID=o.CustomerID
where c.Country='Germany' and o.TotalAmount>100

--Hard Level
--21.
select e1.Name, e2.departmentID
from
employees as e1
inner join Employees as e2 on e1.EmployeeID <>e2.EmployeeID
WHERE e1.DepartmentID <> e2.DepartmentID;
--22.
select p.* 
from payments as p 
inner join orders as o on o.OrderID=p.OrderID
inner join products as pr on pr.ProductID=o.ProductID
where p.Amount<>(o.Quantity*pr.Price)
--23.
select s.Name, c.courseName
from students as s
left join enrollments as e on e.StudentID=s.StudentID
left join Courses as c on c.CourseID=e.CourseID
where c.courseName is null
--24.
select e1.Name, e2.ManagerID
from employees as e1
inner join employees as e2 on e1.EmployeeID=e2.ManagerID
where e2.Salary<=e1.Salary
--25.
select c.FirstName 
from customers as c
left join orders as o on o.CustomerID=c.CustomerID
left join payments as pay on o.OrderId=pay.OrderID
where pay.PaymentID is null 
