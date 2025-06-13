-- LEVEL 1: Basic Subqueries

-- Task 1: Find Employees with Minimum Salary
SELECT * 
FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees);


-- Task 2: Find Products Above Average Price
SELECT * 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);


-- LEVEL 2: Nested Subqueries with Conditions

-- Task 3: Find Employees in Sales Department
SELECT * 
FROM employees 
WHERE department_id = (
    SELECT id 
    FROM departments 
    WHERE department_name = 'Sales'
);


-- Task 4: Find Customers with No Orders
SELECT * 
FROM customers 
WHERE customer_id NOT IN (
    SELECT customer_id 
    FROM orders
);


-- LEVEL 3: Aggregation and Grouping in Subqueries

-- Task 5: Find Products with Max Price in Each Category
SELECT * 
FROM products p
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);


-- Task 6: Find Employees in Department with Highest Average Salary
SELECT * 
FROM employees 
WHERE department_id = (
    SELECT TOP 1 department_id 
    FROM employees 
    GROUP BY department_id 
    ORDER BY AVG(salary) DESC
);


-- LEVEL 4: Correlated Subqueries

-- Task 7: Find Employees Earning Above Department Average
SELECT * 
FROM employees e
WHERE salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = e.department_id
);


-- Task 8: Find Students with Highest Grade per Course
SELECT * 
FROM grades g
WHERE grade = (
    SELECT MAX(grade) 
    FROM grades 
    WHERE course_id = g.course_id
);


-- LEVEL 5: Subqueries with Ranking and Complex Conditions

-- Task 9: Find Third-Highest Price per Category
WITH RankedProducts AS (
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank
    FROM products
)
SELECT * 
FROM RankedProducts 
WHERE rank = 3;


-- Task 10: Find Employees whose Salary Between Company Average and Department Max Salary
SELECT * 
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND salary < (
      SELECT MAX(salary) 
      FROM employees 
      WHERE department_id = e.department_id
  );

