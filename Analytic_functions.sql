-- 1. Display the rank of salaries for each employee within their department.

SELECT employee_id, department_id, salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 2. Display each employee's salary along with the difference from the average salary in their department.

SELECT employee_id, department_id, salary,
       salary - AVG(salary) OVER (PARTITION BY department_id) AS salary_diff
FROM employees;

-- 3. Display the cumulative total of sales for each month.

SELECT sale_date, sales_amount,
       SUM(sales_amount) OVER (ORDER BY sale_date) AS cumulative_sales
FROM sales;

-- 4. Display sales for each month and the average sales for the last 3 months.

SELECT sale_date, sales_amount,
       AVG(sales_amount) OVER (ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_sales_last_3_months
FROM sales;

-- 5. Display the number of employees in each department.

SELECT employee_id, department_id,
       COUNT(*) OVER (PARTITION BY department_id) AS dept_employee_count
FROM employees;

-- 6.Display the current salary and the difference from the previous month's salary.

SELECT employee_id, sale_date, sales_amount,
       sales_amount - LAG(sales_amount) OVER (PARTITION BY employee_id ORDER BY sale_date) AS sales_change
FROM sales;

-- 7. Display sales for each product and its percentage of total sales.

SELECT product_id, sales_amount,
       sales_amount / SUM(sales_amount) OVER () * 100 AS sales_percentage
FROM sales;

-- 8 Display the current price and the price for the next month for each product.

SELECT product_id, sale_date, price,
       LEAD(price) OVER (PARTITION BY product_id ORDER BY sale_date) AS next_month_price
FROM product_prices;

-- 9. Display employees who earn more than the company-wide average salary.

SELECT employee_id, salary
FROM employees
WHERE salary > AVG(salary) OVER ();

-- 10. Divide employees into four salary groups (quartiles) based on their salaries.

SELECT employee_id, salary,
       NTILE(4) OVER (ORDER BY salary DESC) AS salary_quintile
FROM employees;
