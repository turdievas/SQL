use homework
--Basic-Level Task(10)
create database sql_hw_2
use sql_hw_2
create table Employees (EmpID int, Name varchar(50), Salary decimal(10,2));
select *from Employees
INSERT INTO  Employees (EmpID, Name, salary) VALUES 
(1, 'Aziz', '3.000')
, (2, 'Alima', '2.500')
, (3, 'Nozima', '1.500')
TRUNCATE TABLE Employees
INSERT INTO  Employees (EmpID, Name, salary) VALUES 
(1, 'Aziz', '3.000')
, (2, 'Alima', '2.500')
, (3, 'Nozima', '1.500')
UPDATE Employees SET salary=7.000 WHERE EmpID=1

DELETE FROM Employees WHERE EmpID=2
/*DROP removes the table from the database
DELETE removes one or more records from the table
TRUNCATE removes all the rows from the existing table*/
ALTER TABLE Employees ALTER COLUMN Name varchar(100);
ALTER TABLE Employees ADD Department varchar(60);
ALTER TABLE Employees ALTER COLUMN Salary FLOAT;

CREATE TABLE Departments (DpeartmentID int, DpeartmentName varchar(50))
select * from Departments

TRUNCATE TABLE Employees;

--Intermediate-Level Tasks(6)
INSERT INTO Departments SELECT 1, 'Sales'
INSERT INTO Departments SELECT 2, 'Business'
INSERT INTO Departments SELECT 3, 'Hospital'
INSERT INTO Departments SELECT 4, 'Education'
INSERT INTO Departments SELECT 5, 'Marketing'

--12 Update the Department of all employees where Salary > 5000 to 'Management'.
INSERT INTO  Employees (EmpID, Name, salary) VALUES 
(1, 'Aziz', '5000')
, (2, 'Alima', '4000')
, (3, 'Nozima', '7500')
, (3, 'Nodira', '10000')
, (3, 'Karima', '3000')
select *from Employees
UPDATE Employees SET Department='Management' WHERE salary>5000 AND Department IS NULL 
DELETE from Employees
select * from Employees
ALTER TABLE Employees
DROP COLUMN Department
--renaming employees table to StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers'
DROP table Departments

--Advanced-Level Task
create table products (productID int, productName varchar(60),
price int check(price>0))
--forgot to add category column
ALTER TABLE products ADD category varchar(40);
select *from products
alter table products add  StockQuantity int default 50;
--rename category
EXEC sp_rename 'products.category',  'productCategory', 'COLUMN';

insert into products (productID, productName, price, StockQuantity, productCategory) values 
(1, 'Apple', 1200, 120, 'telephone') 
,(2, 'Samsung', 800, 90, 'telephone')
,(3, 'Airpods', 50, 100, 'Electronics') 
,(4, 'iWatch',400, 70, 'Electronics') 
,(5, 'AI Glasses', 295, 400, 'Wearable Technology') 

--creating backup schema
SELECT * INTO ProductsBackup FROM products;
--renaming the table
EXEC sp_rename 'products', 'Inventory'
select *from Inventory
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
