create database homework7
use homework7

--Easy Level
--1.Write a query to find the minimum (MIN) price of a product in the Products table.
select MIN(price) from products
--2.Write a query to find the maximum (MAX) Salary from the Employees table.
select MAX(salary) from employees
--3.Write a query to count the number of rows in the Customers table.
select COUNT(*) from Customers
--4.Write a query to count the number of unique product categories from the Products table.
select  COUNT(distinct category) from products
--5.Write a query to find the total sales amount for the product with id 7 in the Sales table.
select SUM(SaleAmount) from sales where ProductID=7
--6.Write a query to calculate the average age of employees in the Employees table.
select AVG(age) from employees
--7.Write a query to count the number of employees in each department.
select departmentName, COUNT(employeeid) as Employees
from Employees
group by DepartmentName, firstName
--8.Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.
select Min(Price) as min_price, Max(Price) as max_price, category as category
from products
group by category
--9.Write a query to calculate the total sales per Customer in the Sales table.
select customerID, SUM(SaleAmount) as totalSales
from sales
group by customerID
/*10.Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
*/
select  departmentName as department, COUNT(firstName) as name
from employees
group by departmentName
having COUNT(firstName)>5


--Medimum Level
/*11.Write a query to calculate the total sales and average sales for each product category from the Sales table.
*/
select productID as productID,  SUM(SaleAmount) as total, AVG(SaleAmount) as avg_sales
from  sales
group by productID
--12.Write a query to count the number of employees from the Department HR.
select  departmentName as department, COUNT(firstName) as name
from employees
group by departmentName
having departmentName='HR'
/*13.Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).
*/
select departmentName as department, MAX(salary) as max_salary, MIN(salary) as min_salary
from employees
group by departmentName
--14.
select departmentName as department, AVG(salary) as avg_salary
from employees
group by departmentName
--15.
select departmentName as department, AVG(salary) as avg_salary, COUNT(FirstName) as number_of_employees
from employees
group  by departmentName
--16.
select category as category, AVG(price) as avg_price
from products
group by category
having AVG(price)>400
--17.
select Year(saleDate) as saleDate, SUM(saleAmount) total_sales
from sales
group by Year(saleDate)
--18.
select customerID as customerid, COUNT(quantity) as quantity
from orders
group by customerID
having COUNT(quantity)>=3
--19.
select departmentName as department, AVG(salary) as avg_salary
from employees
group by departmentName
having AVG(salary)>60000

--Hard Level
--20.
select category as category, AVG(price) as avg_price
from products
group by category
having AVG(price)>150
--21.
select customerID as customerid, SUM(SaleAmount) as total_sales
from sales
group by customerID
having SUM(SaleAmount)>1500
--22.
select departmentName as department, AVG(salary) as avg_salary, SUM(salary) as total_salary
from employees
group by departmentName
having AVG(salary)>65000
--23.
select SUM(CASE WHEN SaleAmount > 50 THEN SaleAmount ELSE 0 END) AS total_sales_over_50,
MIN(SaleAmount) as leastPurchase
from sales 
group by customerID
--24.
SELECT 
    YEAR(orderDate) AS year,
    MONTH(orderDate) AS month,
    SUM(TotalAmount) AS total_sales,
    COUNT(DISTINCT productID) AS unique_products_sold
FROM 
    Orders
GROUP BY 
    YEAR(orderDate), MONTH(orderDate)
HAVING 
    COUNT(DISTINCT productID) >= 2;
--25.
select YEAR(orderDate) as year, 
MIN(quantity) as min,
max(quantity) as max
from orders
group by YEAR(orderDate)
