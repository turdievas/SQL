--Easy Level 
--1.
select emp.Name, Emp.Salary, dep.DepartmentName
from employees as emp
inner join departments as dep on dep.DepartmentID=emp.DepartmentID
where Emp.Salary>50000
--2.
select cust.FirstName, cust.LastName, ord.OrderDate
from customers as cust
inner join orders as ord on ord.CustomerID=cust.CustomerID
where YEAR(ord.OrderDate)=2023
--3.
select emp.Name, dep.DepartmentName
from employees as emp
left join departments as dep on dep.DepartmentID=emp.DepartmentID
--4.
select sp.SupplierName, pr.ProductName
from products as pr
right join suppliers as sp on sp.SupplierID=pr.SupplierID
--5.
select o.OrderID, o.OrderDate, pay.PaymentDate, pay.Amount
from orders as o 
left join Payments as pay on pay.OrderID=o.OrderID
--6.
select emp.name as emp_name, m.name as m_name
from employees as emp
left join Employees as m on Emp.ManagerID=m.EmployeeID
--7.
select st.Name, c.courseName
from students as st
inner join enrollments as en on en.StudentID=st.StudentID
inner join courses as c on en.CourseID=c.CourseID
where c.CourseName='Math 101'
--8.
select c.FirstName, c.LastName, o.Quantity
from customers as c
inner join orders as o on o.CustomerID=c.CustomerID
where o.Quantity>3
--9.
select emp.Name, dep.DepartmentName
from Employees as emp
inner join Departments as dep on emp.DepartmentID=dep.DepartmentID
where dep.DepartmentName='Human Resources'

--Medium Level
--10.
select dep.DepartmentName, COUNT(emp.Name) as EmployeeCount
from Departments as dep
inner join Employees as emp on dep.DepartmentID=emp.DepartmentID
group by dep.DepartmentID, dep.DepartmentName
having COUNT(emp.Name)>5
--11.
select p.ProductID, p.ProductName
from products as p
left join sales as s on s.ProductID=p.ProductID
where p.ProductID<>s.ProductID
--12.
select cust.firstName, cust.LastName 
from customers as cust
inner join orders as o on cust.CustomerID=o.CustomerID
--13.
select emp.Name, dep.departmentName
from employees as emp
inner join Departments as dep on emp.DepartmentID=dep.DepartmentID
--14.
SELECT 
  e1.Name AS Employee1,
  e2.Name AS Employee2,
  e1.ManagerID
FROM Employees e1
JOIN Employees e2 
  ON e1.ManagerID = e2.ManagerID 
  AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL;
--15.
select o.orderID, o.OrderDate, cust.FirstName, cust.LastName
from customers as cust
inner join orders as o on o.CustomerID=cust.CustomerID
where YEAR(o.OrderDate)=2022
--16.
select emp.Name, emp.Salary, dep.DepartmentName
from employees as emp
inner join Departments as dep on dep.DepartmentID=emp.DepartmentID
where dep.DepartmentName='Sales' and emp.Salary>60000
--17.
select o.orderID, o.orderDate, p.paymentdate, p.amount
from orders as o
inner join payments as p on o.OrderID=p.OrderID
--18.
select p.ProductID, p.ProductName
from products as p 
left join orders as o on o.productID=p.ProductID
where o.OrderDate is null

--Hard Level
--19.
SELECT DISTINCT e1.Name, e1.Salary
FROM Employees e1
JOIN Employees e2 
  ON e1.DepartmentID = e2.DepartmentID
GROUP BY e1.Name, e1.Salary
HAVING e1.Salary > AVG(e2.Salary);
--20.
select o.OrderID, o.OrderDate
from orders as o 
left join payments as p on o.OrderID=p.OrderID
where YEAR(o.OrderDate)<2020 and p.PaymentDate is null
--21.
select p.ProductID, p.ProductName
from products as p 
left join categories as ctg on p.Category=ctg.CategoryName
where ctg.CategoryName is null
--22.
SELECT 
  e1.Name AS Employee1,
  e2.Name AS Employee2,
  e1.ManagerID,
  e1.Salary
FROM Employees e1
JOIN Employees e2 
  ON e1.ManagerID = e2.ManagerID 
WHERE e1.Salary>60000
--23.
select emp.Name, dep.DepartmentName
from employees as emp
inner join Departments as dep on emp.DepartmentID=dep.DepartmentID
where dep.DepartmentName like 'M%'
--24.
select s.SaleID, p.ProductName, s.SaleAmount
from Products as p 
inner join sales as s on s.ProductID=p.ProductID
where s.SaleAmount>500
--25.
select s.StudentID, s.Name, c.CourseName
 from students as s 
 left join enrollments as en on en.StudentID=s.StudentID
 left join Courses as c on c.CourseID=en.CourseID and  c.CourseName = 'Math 101'
 where c.courseID is null
--26.
select o.OrderID, o.OrderDate, p.PaymentID 
from orders as o
left join payments as p on o.OrderID=p.OrderID
where p.PaymentID is null
--27.
select p.ProductID, p.ProductName, c.CategoryName
from products as p 
inner join categories as c on c.CategoryName=p.Category
where p.Category='Furniture' or p.Category='Electronics'
