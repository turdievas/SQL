--1.
select*from #Sales as s
where exists (select 1 from #Sales as s2 
where s.customerName=s2.customerName and  YEAR(SaleDate)=2024 and Month(SaleDate)=03
)
--2.
select Product, Total from
(select Product, SUM(Quantity*Price) as Total 
from #Sales
group by Product) as RevenuePerProduct
where Total=(select MAX(Total)
from (select Product, SUM(Quantity*Price) as Total 
from #Sales
group by Product) as MaxRevenue
)
--3.
select MAX(Price*Quantity) as SecondHighestSale from 
#Sales 
where Price*Quantity<(select MAX(Price*Quantity)  from #Sales)
--4.
select  SaleMonth, Total_qty   from (select MONTH(SaleDate) 
as SaleMonth, YEAR(SaleDate) as SaleYear,SUM(Quantity)
as Total_qty  from #Sales
group by MONTH(SaleDate),YEAR(SaleDate)) as MonthlySales
--5.
select * from #Sales as s1
where exists (select  Product from #Sales as s2 
where s1.Product=s2.Product and s1.CustomerName<>s2.CustomerName )
--6.
select Name, [Apple], [Orange], [Banana]
from (select Name, Fruit from Fruits) as sourcetbl
pivot (COUNT(Fruit) for Fruit in  ([Apple], [Orange], [Banana]) )as Pivotbl
--7.
select*from Family
--8.
;with cte as (
select distinct customerID from #Orders 
where deliveryState='CA'
) 
select  customerID, deliverystate 
from #orders
where DeliveryState='TX' and customerID in (select customerID from cte)
--9.
select resid, fullname, 
case when charindex('name=', address)=0 then 
stuff(address, charindex('age=', address), 0, 'name=' +fullname +' ')
else address
end as updatedAddress
from #Residents
--10.
select*from #Routes
--11.
select*,SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
OVER (ORDER BY ID) as ranking from #RankingPuzzle
--12.
select* from #EmployeeSales as s1
where SalesAmount> (select avg(SalesAmount) from #EmployeeSales as s2
where s1.Department=s2.Department
)
--13.
select * from #EmployeeSales as s1
where  not exists (select 1 from #EmployeeSales as s2 where 
s2.SalesAmount>s1.SalesAmount
and s1.SalesYear=s2.SalesYear and s1.SalesMonth=s2.SalesMonth)
--14.
SELECT DISTINCT s1.EmployeeName
FROM #EmployeeSales AS s1
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth, SalesYear
    FROM #EmployeeSales
    EXCEPT
    SELECT SalesMonth, SalesYear
    FROM #EmployeeSales AS s2
    WHERE s2.EmployeeID = s1.EmployeeID
)
--15.
select*from Products
where Price >(select avg(Price) as avgPrice from Products)
--16.
select *from Products
where Stock <(select MAX(Stock) as highestStock from Products)
--17.
select*from Products where Category in 
(select category from Products where Name='laptop')
--18.
select *from Products
where Price >(select MIN(Price) as minPrice from Products
 WHERE Category = 'Electronics')
 --19.
 select*from Products as p1
 join 
 (
 select category, avg(price) as avgPrice
 from Products
 group by Category) as p2
 on p1.Category=p2.Category
 where p1.price>p2.avgPrice
 --20.
 select  p.ProductID, p.name--, count(ord.orderID) as timesOrdered 
 from Products as p
 join Orders as ord
 on p.ProductID=ord.ProductID
 group by  p.ProductID, p.name
 having count(ord.orderID)>=1
 --21.
 select distinct p.* from Products as p 
 join (
 select *from Orders 
 where Quantity>(select avg(Quantity) from Orders)) as ord
 on p.ProductID=ord.ProductID
 --22.
 select*from Products  as p 
 where p.ProductID not in (select ProductID from Orders as ord
     WHERE ProductID IS NOT NULL
 )
 --23.
 select top 1  ProductID, SUM(Quantity) as total  from Orders
 group by ProductID
 order by total desc 
