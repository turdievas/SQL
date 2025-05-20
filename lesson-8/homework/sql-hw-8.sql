create database lesson7_hw
use lesson7_hw

--Easy Level
--1.
select category as category, SUM(Price) as total_price
from products 
group by category
--2.
select category as category, AVG(Price) as avg_price
from products 
group by category
having category='Electronics'
--3.
select*from customers where city like 'L%'
--4.
select*from products where ProductName like '%er'
--5.
select*from customers where country like '%A'
--6.
select MAX(Price) as max_price from products
--7.
select*,
case when StockQuantity<30 then 'Low Stock'
else 'Sufficient' end as Stock
from products
--8.
select country, COUNT(customerID) as number
from customers
group by country
--9.
select MIN(quantity) as min_quant, MAX(quantity) as max_quant
from orders
--Medium Level
--10.
select distinct customerID 
from orders
where  YEAR(OrderDate)=2023 and MONTH(OrderDate)=01
and CustomerID not in (
select distinct customerID
from invoices
)
--11.
select ProductName from products_discounted
UNION ALL
select ProductName from products
--12.
select ProductName from products_discounted
UNION
select ProductName from products
--13.
select AVG(Quantity) as avg_order_amount, YEAR(OrderDate) as year
from orders
group by YEAR(OrderDate)
--14.
select ProductName,
case when Price<100 then 'Low'
     when Price between 100 and 500 then 'Mid'
	 else 'High' end as PriceGroup 
from products
--15.
select district_name,[2012],[2013] into Population_Each_Year from city_population
PIVOT
(
SUM(Population) for year in([2012],[2013])
) as Pivoted_table
--16.
select productID as productID, SUM(SaleAmount) as totalSales
from sales
group by ProductID
--17.
select ProductName from products where ProductName like '%oo%'
--18.
select year, [Bektemir],[Chilonzor], [Yakkasaroy]
into Population_Each_City from city_population
PIVOT
(
SUM(Population) for district_name in([Bektemir],[Chilonzor], [Yakkasaroy])
) as Pivoted_table
--Hard Level
--19.
select TOP 3  customerID as customerID, MAX(totalAmount) as maxInvoiceAmount
from invoices
group by customerID
--20
select district_name, population, year from  Population_Each_Year
UNPIVOT(
Population for year in([2012],[2013])
) as Unpivoted_table
--21.
SELECT 
    p.ProductName, 
    COUNT(s.SaleID) AS TimesSold
FROM 
    Products p
JOIN 
    Sales s ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductName;
--22.
SELECT 
    year, 
    district_name, 
    population
FROM 
    Population_Each_City
UNPIVOT
(
    population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS UnpivotedTable;
