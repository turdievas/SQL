--Easy Level
--1.
select concat(Employee_ID, '-', First_name, ' ' , Last_name) from Employees 
--2.
Update employees set phone_number= replace(phone_number, '124', '999' )
--3.
select first_name, len(first_name) as length_of_first_name 
from Employees where 
FIRST_NAME like 'A%' or FIRST_NAME like 'J%' or FIRST_NAME like 'M%'
--4.
select MANAGER_ID, SUM(Salary) as totalSalary from Employees
group by MANAGER_ID
--5.
select year1,
case when Max1>Max2 and Max1>Max3 then Max1
     when Max2>Max1 and Max2>Max3 then Max2
	 else Max3 end as highest_among_rows
from TestMax
--6.
select * from cinema where id%2=1 and description<>'boring'
--7.
SELECT * FROM SingleOrder
ORDER BY CASE WHEN id = 0 THEN 1 ELSE 0 END, id DESC;
--8.
select COALESCE(id, ssn, passportid, itin) as first_non_null from person

--Medium Level
--1.
select *,
substring(fullname,1,charindex(' ',fullname)-1) as first_name,
substring(FullName,charindex(' ',fullname,
charindex(' ',fullname)+1)+1,len(Fullname)) as last_name,
SUBSTRING(FullName,CHARINDEX(' ',Fullname),charindex(' ',
fullname,charindex(' ',fullname)+1)-CHARINDEX(' ',Fullname)) as middle_name
from Students

--2.
select t.customerID, COUNT(t.orderID) from orders
as c
join orders as t on c.CustomerID=t.CustomerID
where c.DeliveryState='CA' and t.DeliveryState='TX'
group by t.customerID
having Count(t.orderID)>=1
--3. 
select  STRING_AGG(string, ' ') as sql_query from DMLTable
--4.
select concat(FIRST_NAME,' ',LAST_NAME) as full_name from Employees
where patindex('%a%a%a%',concat(FIRST_NAME,' ',LAST_NAME))<>0
select concat(FIRST_NAME,' ',LAST_NAME) as full_name,
replace(concat(FIRST_NAME,' ',LAST_NAME),'a','') from Employees
where len(concat(FIRST_NAME,' ',LAST_NAME))-
len(replace(concat(FIRST_NAME,' ',LAST_NAME),'a',''))>=3

--5.
select Department_id, 
COUNT(case when DATEDIFF(YEAR, Hire_Date, GETDATE()) > 3 then 1 end )
as  Employees3PlusYear
--, COUNT(EMPLOYEE_ID) as employeesInEachDepartment
from Employees
group by Department_id
--6.
select  jobdescription, MAX(MissionCount) as max, min(MissionCount) as min 
from personal
group by jobdescription
--Difficult tasks
--1.
DECLARE @input NVARCHAR(100) = 'tf56sd#%OqH';
DECLARE @i INT = 1;
DECLARE @len INT = LEN(@input);
DECLARE @char NCHAR(1);

DECLARE @uppercase NVARCHAR(100) = '';
DECLARE @lowercase NVARCHAR(100) = '';
DECLARE @numbers   NVARCHAR(100) = '';
DECLARE @others    NVARCHAR(100) = '';
WHILE @i <= @len
BEGIN
    SET @char = SUBSTRING(@input, @i, 1);
    IF @char COLLATE Latin1_General_CS_AS LIKE '[A-Z]'
        SET @uppercase += @char;
    ELSE IF @char COLLATE Latin1_General_CS_AS LIKE '[a-z]'
        SET @lowercase += @char;
    ELSE IF @char LIKE '[0-9]'
        SET @numbers += @char;
    ELSE
        SET @others += @char;

    SET @i += 1;
END
SELECT 
    @uppercase AS UppercaseLetters,
    @lowercase AS LowercaseLetters,
    @numbers   AS Numbers,
    @others    AS OtherCharacters;
--2.
select*from Students
--3.
--4.
select Birthday, COUNT(*) from Student
group by Birthday
HAVING COUNT(*) > 1
--5.
SELECT
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
  SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END
ORDER BY Player1, Player2;
