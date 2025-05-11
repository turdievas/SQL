use tasks

--Easy-Level Tasks (10)
--1.Define and explain the purpose of BULK INSERT in SQL Server.
/*A "bulk insert" refers to a process or method used 
by database management systems (DBMS) to efficiently load a 
large number of rows of data into
a database table in a single operation, rather than inserting them one by one.*/

/*2.List four file formats that can be imported into SQL Server.
XML, CSV, JSON, TXT, 
3.Create a table Products with columns: ProductID
(INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
 */

 drop table products  --deleted the existing table in order to create a new one with this name
 create table products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))
 select * from products
 /*4.Insert three records into the Products table using INSERT INTO. */
 insert into products(productID, productname, price) values
 (15,'headphone', '200'),
  (16,'smartpone', '1200'),
   (17,'airpods', '100')
/*5.Explain the difference between NULL and NOT NULL. 
NULL is set by default, NOT NULL is set by manually and NULL means Unknown
6.Add a UNIQUE constraint to the ProductName column in the Products table.
*/
ALTER TABLE products ADD CONSTRAINT added_unique UNIQUE(productname);
/*7.Write a comment in a SQL query explaining its purpose.
UNIQUE constraint is added so the inserted value should be unique, not repeated. It is commonly used in ID
8.Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
 */
 create table categories ( CategoryID int primary key, CategoryName varchar(70) unique)
 /*9.Explain the purpose of the IDENTITY column in SQL Server.
Identity constraint is used for incrementing. For example: IDENTITY(1,1) adds 1. The sequence will be like this: 1,2,3,4,5...
 Medium-Level Tasks (10)
 */
bulk insert [tasks].[dbo].[products]
from 'C:\Users\hp\Desktop\products.csv'
with(
firstrow=2,
fieldterminator = ',',
rowterminator='\n')

select* from products
/*11.Create a FOREIGN KEY in the Products table that references the Categories table.
 */
 alter table products add  categoryname varchar(70) foreign key references categories(categoryname)

 /* 12.Explain the differences between PRIMARY KEY and UNIQUE KEY.
 The main difference between a primary key vs unique key is that
 a primary key is a key that uniquely identifies each record in
 a table but cannot store NULL values. In contrast,
 a unique key prevents duplicate values in a column and can store NULL values

 13.Add a CHECK constraint to the Products table ensuring Price > 0.
*/
 ALTER TABLE products ADD CONSTRAINT added_check CHECK(price>0)
 
 /*14.Modify the Products table to add a column Stock (INT, NOT NULL).
 */;
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
/* 15.Use the ISNULL function to replace NULL values in Price column with a 0.*/
select isnull(price, 0) from products
/* 16.Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.*/
/*FOREIGN KEY is used in another table to refer to its primary usage. 
It prevents from entering the duplicate values
Hard-Level Tasks (10)
17.Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
*/
drop table customers --there was a table with the same name so i deleted to create a new one
create table customers (customerID int, customerName varchar(60), customerAge int check (customerAge >=18));
select * from customers

/*18.Create a table with an IDENTITY column starting at 100 and incrementing by 10. */
create table info (id int identity(100,10), name varchar(60));
insert into info(name) values ( 'Odina')
insert into info(name) values ( 'Madina')
insert into info(name) values ( 'Dilfuza')
select * from info
/*19.Write a query to create a composite PRIMARY KEY in a new table OrderDetails. */
drop table Orderdetails -- deleted the existing table to create a new one with the same name
create table Orderdetails(orderID int, OrderName varchar(60), OrderQuantity int, 
PRIMARY KEY(orderID, OrderQuantity))
select * from OrderDetails
/*20.Explain the use of COALESCE and ISNULL functions for handling NULL values.
ISNULL gives us a chance to replace 
NULL values with an alternative value. So it checks
the value whether it is null or not. If it is NULL it replaces with the alternative
Sytnax: ISNULL(expression, replacement_value);
COALESCE is different from 
ISNULL because we can give 2 or more expressions and it returns the first non-null value
20.Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
 */
 DROP TABLE employees
 create table employees (EmpID int PRIMARY KEy, EmpEmail varchar(70) UNIQUE)
 select * from employees

 /*22.Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.*/


 create table haridorlar(
 haridorID int PRIMARY KEY IDENTITY(1,1),
 haridorIsmi varchar(60))
 select * from haridorlar

 insert into haridorlar(haridorIsmi ) values
 ('Aziza'),
 ('Madina'), ('Feruza'), ('Marjona'), ('Muxlisa')

 create table orders(orderID int, orderName varchar(60),
 customerID int FOREIGN KEY(customerID) references haridorlar(haridorID)
 ON UPDATE cascade
 ON DELETE cascade);

 select * from orders

 insert into orders(orderID, orderName, customerID) values
 (1, 'FA1232', 1),
  (2, 'FB1232', 3),
   (3, 'FC1232', 4),
    (4, 'FD1232', 4),
	 (5, 'FE1232', 3)
