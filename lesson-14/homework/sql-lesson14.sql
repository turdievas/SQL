-- ###########################
-- LESSON 14 - EASY TASKS
-- ###########################

-- 1. Split Name by comma
SELECT 
  LEFT(Name, CHARINDEX(',', Name) - 1) AS Name,
  LTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name))) AS Surname
FROM TestMultipleColumns;

-- 2. Find strings containing %
SELECT * 
FROM TestPercent
WHERE ColumnName LIKE '%[%]%';

-- 3. Split string by dot
SELECT 
  value 
FROM STRING_SPLIT((SELECT TOP 1 col FROM Splitter), '.');

-- 4. Replace digits with 'X'
SELECT 
  TRANSLATE('1234ABC123456XYZ1234567890ADS', '0123456789', 'XXXXXXXXXX') AS Result;

-- 5. Rows with more than two dots
SELECT * 
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

-- 6. Count spaces in string
SELECT 
  LEN(Vals) - LEN(REPLACE(Vals, ' ', '')) AS SpaceCount
FROM CountSpaces;

-- 7. Employees who earn more than their managers
SELECT e.Name 
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;

-- 8. Employees with 10-15 years of service
SELECT 
  EmployeeID, FirstName, LastName, HireDate, 
  DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 10 AND 14;

-- ###########################
-- MEDIUM TASKS
-- ###########################

-- 9. Separate integers and characters
SELECT 
  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    'rtcfvty34redt', '0',''),'1',''),'2',''),'3',''),'4',''),'5',''),'6',''),'7',''),'8',''),'9','') AS Letters,
  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    'rtcfvty34redt', 'a',''),'b',''),'c',''),'d',''),'e',''),'f',''),'g',''),'h',''),'i',''),'j','') AS Digits -- Extend as needed

-- 10. Dates with higher temp than previous
SELECT w1.Id 
FROM weather w1
JOIN weather w2 ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;

-- 11. First login date per player
SELECT player_id, MIN(login_date) AS FirstLogin
FROM Activity
GROUP BY player_id;

-- 12. Third item from comma list
SELECT 
  value 
FROM STRING_SPLIT((SELECT TOP 1 fruits FROM Fruits), ',')
ORDER BY (SELECT NULL) OFFSET 2 ROWS FETCH NEXT 1 ROW ONLY;

-- 13. Convert string to rows
WITH cte AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM cte WHERE n < LEN('sdgfhsdgfhs@121313131')
)
SELECT SUBSTRING('sdgfhsdgfhs@121313131', n, 1) AS Char
FROM cte
OPTION (MAXRECURSION 0);

-- 14. Join p1 and p2, replace code if 0
SELECT 
  p1.id,
  CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;

-- 15. Employment Stage classification
SELECT 
  EmployeeID,
  CASE 
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 5 THEN 'Junior'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 10 THEN 'Mid-Level'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) <= 20 THEN 'Senior'
    ELSE 'Veteran'
  END AS EmploymentStage
FROM Employees;

-- 16. Extract integer from start of string
SELECT 
  LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS StartInteger
FROM GetIntegers;

-- ###########################
-- DIFFICULT TASKS
-- ###########################

-- 17. Swap first two letters of comma-separated string
SELECT 
  STUFF(STUFF(value, 1, 1, SUBSTRING(value, 3, 1)), 3, 1, SUBSTRING(value, 1, 1)) AS Swapped
FROM STRING_SPLIT((SELECT TOP 1 col FROM MultipleVals), ',');

-- 18. First logged-in device per player
SELECT player_id, device_id
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn
  FROM Activity
) t
WHERE rn = 1;

-- 19. Week-on-week percentage sales per area
WITH SalesCTE AS (
  SELECT 
    area, 
    DATEPART(WEEK, sale_date) AS week_num,
    SUM(amount) AS total_sales
  FROM Sales
  GROUP BY area, DATEPART(WEEK, sale_date)
),
WeekTotal AS (
  SELECT 
    DATEPART(WEEK, sale_date) AS week_num,
    SUM(amount) AS week_total
  FROM Sales
  GROUP BY DATEPART(WEEK, sale_date)
)
SELECT 
  s.area, s.week_num,
  ROUND(100.0 * s.total_sales / wt.week_total, 2) AS area_percentage
FROM SalesCTE s
JOIN WeekTotal wt ON s.week_num = wt.week_num;

-- END OF SCRIPT
