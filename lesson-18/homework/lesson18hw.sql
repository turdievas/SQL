--1.
create table #MonthlySales (id int, ProductName varchar(100), 
monthOfSale varchar(30), totalQuantity int, totalRevenue int
);
insert into #MonthlySales (id, ProductName, monthOfSale, totalQuantity, totalRevenue)
SELECT 
    p.ProductID,
    p.ProductName,
    DATENAME(month, s.SaleDate) AS saleMonth,
    SUM(s.Quantity) AS totalQty,
    SUM(s.Quantity * p.Price) AS totalRevenue
FROM Products AS p
JOIN Sales AS s ON p.ProductID = s.ProductID
WHERE DATENAME(month, s.SaleDate) = 'April'
GROUP BY p.ProductID, p.ProductName, DATENAME(month,
s.SaleDate);
--2.
create view vw_ProductSalesSummary as
select p.productID, p.ProductName, p.Category, sum(s.quantity) 
as TotalQuantitySold from Products as p
join sales as s
on p.ProductID=s.ProductID
group by p.productID, p.ProductName, p.Category
--3. 
create FUNCTION fn_GetTotalRevenueForProduct
(
    @productID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @total INT;

    SELECT @total = SUM(p.price * s.quantity)
    FROM Products AS p
    JOIN Sales AS s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @productID;

    RETURN @total;
END;
--4.
create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table 
as
return(
select p.ProductName, SUM(s.Quantity) as totalQuantity, 
SUM(s.Quantity*p.Price) as TotalRevenue 
from Products as p 
join sales as s
on p.ProductID=s.ProductID
group by p.ProductName
)
--5.
CREATE FUNCTION dbo.fn_IsPrime(@Number INT)
RETURNS VARCHAR(50)
AS
BEGIN
    IF @Number <= 1
        RETURN 'Bu son tub emas';

    DECLARE @inc INT = 2;
    DECLARE @checker INT = 1;

    WHILE @inc * @inc <= @Number
    BEGIN
        IF @Number % @inc = 0
        BEGIN
            SET @checker = 0;
            BREAK;
        END
        SET @inc = @inc + 1;
    END

    IF @checker = 0
        RETURN 'Bu son tub emas';
    ELSE
        RETURN 'Bu son tub';
END;
--6.
create function fn_GetNumbersBetween(@Start INT,
@End INT)
returns table 
as 
return (
create table Numbers(@start int, )
)
--7.
select salary as getNthHighestSalary from (select distinct salary
from Employee
order by salary desc
OFFSET 1 ROW FETCH NEXT 1 ROW ONLY) as getNthHighestSalary
--8.
select top 1 id, count(*) as num
from (select requester_id  as id from RequestAccepted
union all
select accepter_id   as id from  RequestAccepted)
as all_friends
group by id
order by num desc
--9.
CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    cust.customer_id,
    cust.name,
    COUNT(ord.order_id) AS total_orders,
    SUM(ord.amount) AS total_amount,
    MAX(ord.order_date) AS last_order_date
FROM Customers AS cust
JOIN Orders AS ord
    ON cust.customer_id = ord.customer_id
GROUP BY cust.customer_id, cust.name;
--10.
