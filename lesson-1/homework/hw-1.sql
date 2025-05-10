create database homework
use homework

/* 
1. EASY 
1.Define the following terms: data, database, relational database, and table.

 What is Data?
Data are facts and statistics collected for references and analysis. Data can be in the form of texts, numbers, 
images or other outputs that come from different measurements and experiments.

 What is Database?
Database is a collection of data stored electronically and designed for managing, updating, 
extracting and transforming data. Databases are commonly used for storing data.

 What is relational database?
A type of database that organizes data into one or more tables, which is divided into columns and rows. 
Data in the tables can be linked with keys. There are 2 types of keys in relational database. 
Primary and foreign keys. Primary keys are unique identifiers in one table, primary keys refer to primary keys in another 
table to establish a relation between the tables.

 What is table?
Table consisted of columns and rows, in which data are stored.

2. List five key features of SQL Server.

1. Relational Database management.
 SQL stores relational databases and gives a chance to querying, updating, inserting and managing data.

2. ETL
SQL Server integration service allows users to extract data from different sources, transform it and load it to SQL for analysis and reporting

3. Supports XML and JSON format
Which means SQL allows to transform data from web applications and APIs. 

4. Business Intelligence and Analytics Support.
SQL Server Reporting Service and SQL Server Analysis Service provides tools for creating dashboards and reports.

5. Backup and Restore capabilities.
It provides backup and restore options.

3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
 two types of SQL authentication modes:

Windows Authentication
It uses windows account to login, no need to create username and password and security is managed by Windows

SQL Server Authentication
Usernames and passwords are created manually and login is managed by SQL Server not with Windows.

2. MEDIUM */
/* 4.Create a new database in SSMS named SchoolDB.*/

create database SCHOOLDB
use SCHOOLDB

/* 5.Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).*/
create table students 
(Student_ID int, name varchar(50), age int)
select * from students

/* 6.Describe the differences between SQL Server, SSMS, and SQL.

SQL is a programming language that manages and manipulates relational database. 

SQL Server is the database program and it stores data.

SSMS is the tool for writing queries and SQL commands.

3. HARD
7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
Commands in SQL are divided into categories.

1.DQL (Data Query Language)
Command: Select;
Retrieves data from database
For example:
select name, age from students age > 18;  //Retrieves the name and age of students older than 18.

2. DML (Data Manipulation Language)
Manipulates data in the database.
Commands: insert, update, delete
For example
insert into students (name, age) values ('Odina', 19);
update students set age =20 where name = 'Odina';
delete from students where name = 'Odina';

3.DDL (Data Definition Language)
Defines and modifies the structure of database objects such tables and schemes
Commands: create, alter, drop, truncate
For example:
create table students (student_id int, name varchar(50), age int);
/* adds a new column to the table*/
alter table students add email varchar(100);
/* deletes table*/
drop table students;
/* deletes the data inside the table but keeps the structure*/
truncate table students;

4. DCL(Data Control Language)
DCL is a security guard of database, so who can do what:
Commands: grant - give permission;
revoke - take away permission
For example:
grant select on students to teacher_john;
revoke select on students from teacher_john;

5. TCL( Transactional Control Language)
Commands: savepoint - we need to set a checkpoint so that we can rollback it later;
rollback - undo changes if something goes wrong;
commit - saves the changes permanently
For example:
update students set age 25 where name ='Ali';
/* if the command in the above is wrong then we need to rollback, which means undo */
rollback ; 
update students set age 19 where name = 'Aziz';
/* we can set a checkpoint so at the end we can commit the changes or not */
savepoint step1 ; 
/* for final saving */
commit;
*/
/* 8.Write a query to insert three records into the Students table.*/
insert into students (Student_ID, name, age) values 
(1, 'Odina', '19')
, (2, 'Madina', '20')
, (3, 'Safiya', '18')
select*from students

/* 9.Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this 
link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak*/

/* First, I've downloaded the file through the link, then i moved it to the Local Disk C folder -> Program files -> Microsoft SQL Server -> MSSQL16.SQLEXPRESS -> MSSQL
->Backup and stored the file here
In order to restore it in sql, I opened SSMS and clicked to Database with right button -> restore files and file groups -> chose the
file from the above-mentioned desktop location ->and clicked add button and with that I restored the file.
*/

