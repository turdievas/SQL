--Task1.
alter proc usp_tempTable  @employeeID int, 
@firstName varchar(100), @lastName varchar(100), @department varchar(60) ,
@salary decimal(10,2), 
@bonusPercentage decimal(10, 2)
as 
begin
declare @fullName varchar(100);
declare @bonusAmount decimal(10,2);
set @bonusAmount=@salary*@bonusPercentage/100
set @fullName = @firstName+ ' '+ @lastName
create table #EmployeeBonus (employeeID int, 
firstName varchar(100), lastName varchar(100), department varchar(60) ,
salary decimal(10,2),  bonusPercentage decimal(10,2), bonusAmount decimal(10,2))
insert into #EmployeeBonus values(@employeeID, @firstName, @lastName, @department, 
@salary,@bonusPercentage, @bonusAmount)
select *from #EmployeeBonus 
end
execute usp_tempTable 1, 'Odina', 'Turdiyeva', 'IT', 3400, 2
--Task2.
create proc ups_UpdateSalarybyDepartment @department varchar(50), 
@percentage decimal(5,2)
as 
begin
UPDATE Employees
set salary=salary*(1+@percentage/100)
where Department=@department
select*from Employees 
where Department=@department
end
---Part 2 Merge Tasks
--Task3
MERGE INTO Products_current as Target
USING Products_New as source
on Target.ProductID=source.ProductID
--If employee exists, update their details
WHEN MATCHED and Target.Price<>Source.Price and
target.productName<>source.ProductName then
	Update set Target.Price=source.Price , Target.ProductName=source.ProductName
	--If emp does not exists insert records
when not matched then 
insert(productID, ProductName,Price) 
values (source.productID, source.ProductName, source.Price)
-- if employee exists in target table but not exists in source table then delete
when not matched by source then
delete;
select*from Products_Current
--Task4.
select distinct tree1.id, tree2.p_id, 
case when tree2.p_id is null then 'Leef'
     when tree1.p_id is not null then 'Inner'
	 when tree1.p_id is null then 'Root'
	end as Node
from Tree as tree1
left join tree as tree2
on tree1.id=tree2.p_id
--Task5.
select s.user_id,
count(case
     when action='confirmed' then 1
	 end )as confirmed,
count(action) as total,
	 CASE 
  WHEN count(action) = 0 THEN 0.00
  ELSE
  CAST(count(case when action = 'confirmed' then 1 end) * 1.0 / count(action) 
  AS DECIMAL(5,2))
END AS confirmation_rate
from Signups as s
left join confirmations as c 
on s.user_id=c.user_id
group by s.user_id
--Task6.
select*from Employees
where salary in (select min(salary) from Employees)
--Task7.
create proc usp_GetProductSalesSummary  @ProductID int
as 
begin
select p.ProductName, SUM(s.quantity) as totalQuantitySold, SUM(s.Quantity*p.Price) as totalSalesAmount,
min(SaleDate) as firstSaleDate, max(SaleDate) as lastSaleDate
from Products as p 
left join Sales as s 
on p.ProductID=s.ProductID
where p.ProductID=@ProductID
group by p.ProductName
end
