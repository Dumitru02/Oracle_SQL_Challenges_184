/*
1. From the following tables, write a SQL query to find all salespeople and customers located in the city of London.

Sample table: Salesman
salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14


Sample table: Customer

customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
        3004 | Fabian Johnson | Paris      |   300 |        5006

*/
SELECT salesman_id "ID", name, 'Salesman' FROM 
salesman 
WHERE city='London' 
UNION 
(SELECT customer_id "ID", cust_name, 'Customer' FROM customer WHERE city='London')

/*
2. From the following tables, write a SQL query to find distinct salespeople and their cities. Return salesperson ID and city.

Sample table: Salesman

 salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14
        5007 | Paul Adam  | Rome     |       0.13
        5003 | Lauson Hen | San Jose |       0.12

Sample table: Customer

customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
        3004 | Fabian Johnson | Paris      |   300 |        5006
*/
SELECT salesman_id, city FROM customer 
UNION 
(SELECT salesman_id, city FROM salesman)

/*
3. From the following tables, write a SQL query to find all those salespeople and customers who are involved in the inventory management system.
 Return salesperson ID, customer ID.

Sample table: orders

ord_no      purch_amt   ord_date    customer_id  salesman_id
----------  ----------  ----------  -----------  -----------
70001       150.5       2012-10-05  3005         5002
70009       270.65      2012-09-10  3001         5005
70002       65.26       2012-10-05  3002         5001


Sample table: customer

customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002

*/
SELECT salesman_id, customer_id 
FROM customer 
UNION (SELECT salesman_id, customer_id FROM orders)

/*
4. From the following table, write a SQL query to find the salespersons who generated the largest and smallest orders on each date. 
Return salesperson ID, name, order no., highest on/lowest on, order date.

Sample table: Salesman

salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14


Sample table: Orders

ord_no      purch_amt   ord_date    customer_id  salesman_id
----------  ----------  ----------  -----------  -----------
70001       150.5       2012-10-05  3005         5002
70009       270.65      2012-09-10  3001         5005
70002       65.26       2012-10-05  3002         5001
70004       110.5       2012-08-17  3009         5003

*/
SELECT a.salesman_id, name, ord_no, 'highest on', ord_date 
FROM salesman a, orders b
WHERE a.salesman_id =b.salesman_id AND b.purch_amt= (SELECT MAX (purch_amt) FROM orders c WHERE c.ord_date = b.ord_date)
UNION 
(SELECT a.salesman_id, name, ord_no, 'lowest on', ord_date FROM salesman a, orders b 
WHERE a.salesman_id =b.salesman_id AND b.purch_amt = (SELECT MIN (purch_amt) 
FROM orders c WHERE c.ord_date = b.ord_date));

/*
5. From the following tables, write a SQL query to find the salespeople who generated the largest and smallest orders on each date. 
Sort the result-set on third field. Return salesperson ID, name, order no., highest on/lowest on, order date.

Sample table: Salesman

salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14

Sample table: Orders

ord_no      purch_amt   ord_date    customer_id  salesman_id
----------  ----------  ----------  -----------  -----------
70001       150.5       2012-10-05  3005         5002
70009       270.65      2012-09-10  3001         5005
70002       65.26       2012-10-05  3002         5001
70004       110.5       2012-08-17  3009         5003

*/

SELECT a.salesman_id, name, ord_no, 'highest on', ord_date FROM salesman a, orders b
WHERE a.salesman_id =b.salesman_id AND b.purch_amt= (SELECT MAX (purch_amt) FROM orders c WHERE c.ord_date = b.ord_date)
UNION 
(SELECT a.salesman_id, name, ord_no, 'lowest on', ord_date FROM salesman a, orders b 
WHERE a.salesman_id =b.salesman_id AND b.purch_amt= (SELECT MIN (purch_amt) 
FROM orders c 
WHERE c.ord_date = b.ord_date)) 
ORDER BY 3


/*
6. From the following tables, write a SQL query to find those salespeople who live in the same city where the customer lives as well as those who do not have customers in their cities by indicating 'NO MATCH'.
 Sort the result set on 2nd column (i.e. name) in descending order. Return salesperson ID, name, customer name, commission.

Sample table: Salesman
 salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14


Sample table: Customer

customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
        3004 | Fabian Johnson | Paris      |   300 |        5006

*/
SELECT salesman.salesman_id, name, cust_name, commission FROM salesman, customer 
WHERE salesman.city = customer.city 
UNION 
(SELECT salesman_id, name, 'NO MATCH', commission FROM salesman WHERE NOT city = ANY (SELECT city FROM customer)) 
ORDER BY 2 DESC


/*
7. From the following tables, write a SQL query that appends strings to the selected fields, indicating whether the city of any salesperson is matched with the city of any customer. 
Return salesperson ID, name, city, MATCHED/NO MATCH.

Sample table: Salesman

salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14

Sample table: Customer

customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
        3004 | Fabian Johnson | Paris      |   300 |        5006
*/

SELECT a.salesman_id, name, a.city, 'MATCHED' FROM salesman a, customer b 
WHERE a.city = b.city 
UNION 
(SELECT salesman_id, name, city, 'NO MATCH' FROM salesman WHERE NOT city = ANY (SELECT city FROM customer)) 
ORDER BY 2 DESC

/*
8. From the following table, write a SQL query to create a union of two queries that shows the customer id, cities, and ratings of all customers. 
Those with a rating of 300 or greater will have the words 'High Rating', while the others will have the words 'Low Rating'.

Sample table: Customer
customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
*/
SELECT customer_id, city, grade, 'High Rating' FROM 
customer WHERE grade >= 300 
UNION 
(SELECT customer_id, city, grade, 'Low Rating' FROM customer WHERE grade < 300)

/*
9. From the following table, write a SQL query to find those salespersons and customers who have placed more than one order. Return ID, name.

Sample table: Customer

customer_id |   cust_name    |    city    | grade | salesman_id 
-------------+----------------+------------+-------+-------------
        3002 | Nick Rimando   | New York   |   100 |        5001
        3007 | Brad Davis     | New York   |   200 |        5001
        3005 | Graham Zusi    | California |   200 |        5002
        3008 | Julian Green   | London     |   300 |        5002
        3004 | Fabian Johnson | Paris      |   300 |        5006


Sample table: salesman
salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11

Sample table: orders     

ord_no      purch_amt   ord_date    customer_id  salesman_id
----------  ----------  ----------  -----------  -----------
70001       150.5       2012-10-05  3005         5002
70009       270.65      2012-09-10  3001         5005
70002       65.26       2012-10-05  3002         5001
70004       110.5       2012-08-17  3009         5003
70007       948.5       2012-09-10  3005         5002  

*/

SELECT customer_id as ID,  cust_name as NAME FROM customer a 
WHERE 1 < (SELECT COUNT (*) FROM orders b WHERE a.customer_id = b.customer_id)
UNION 
(SELECT salesman_id as ID, name as NAME FROM salesman a 
WHERE 1 < (SELECT COUNT (*) FROM orders b WHERE  a.salesman_id = b.salesman_id)) 
ORDER BY 2






















