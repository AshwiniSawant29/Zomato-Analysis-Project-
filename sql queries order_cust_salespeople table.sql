Create database Project1;
Use Project1;

-- 1.	Create the Salespeople 
CREATE TABLE Salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50),
    comm DECIMAL(4, 2)
);
INSERT INTO Salespeople (snum, sname, city, comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New York', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);
select * from salespeople;

-- 2. Create the Cust Table 
CREATE TABLE Customers (
    cnum INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50),
    rating INT,
    snum INT
);
INSERT INTO Customers (cnum, cname, city, rating, snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);
select * from customers;

-- 3. create the Orders table
CREATE TABLE Orders (
    onum INT PRIMARY KEY,
    amt DECIMAL(10, 2),
    odate DATE,
    cnum INT,
    snum INT
);
INSERT INTO Orders (onum, amt, odate, cnum, snum) VALUES
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1003),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2001, 1001),
(3009, 1713.23, '1994-10-06', 2002, 1002),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);
select * from orders;
-- 4.	Write a query to match the salespeople to the customers according to the city they are living.
SELECT 
    s.snum AS Salesperson_Number,
    s.sname AS Salesperson_Name,
    s.city AS Salesperson_City,
    c.cnum AS Customer_Number,
    c.cname AS Customer_Name,
    c.city AS Customer_City
FROM 
    Salespeople s
JOIN 
    Customers c
ON 
    s.city = c.city;
-- 5.	Write a query to select the names of customers and the salespersons who are providing service to them.
SELECT 
    c.cname AS Customer_Name,
    s.sname AS Salesperson_Name
FROM 
    Customers c
JOIN 
    Salespeople s
ON 
    c.snum = s.snum;
-- 6.	Write a query to find out all orders by customers not located in the same cities as that of their salespeople
SELECT 
    o.onum AS Order_Number,
    o.amt AS Order_Amount,
    c.cname AS Customer_Name,
    c.city AS Customer_City,
    s.sname AS Salesperson_Name,
    s.city AS Salesperson_City
FROM 
    Orders o
JOIN 
    Customers c
ON 
    o.cnum = c.cnum
JOIN 
    Salespeople s
ON 
    o.snum = s.snum
WHERE 
    c.city != s.city;
-- 7.	Write a query that lists each order number followed by name of customer who made that order
SELECT 
    o.onum AS Order_Number,
    c.cname AS Customer_Name
FROM 
    Orders o
JOIN 
    Customers c
ON 
    o.cnum = c.cnum;

/*8.	Write a query that finds all pairs of customers having the same rating………………*/
SELECT 
    c1.cname AS Customer1_Name,
    c1.rating AS Rating,
    c2.cname AS Customer2_Name
FROM 
    Customers c1
JOIN 
    Customers c2
ON 
    c1.rating = c2.rating
AND 
    c1.cnum < c2.cnum; -- Avoid duplicate pairs and self-matching

-- 9. write a query to find all pairs of customers served by a salesperson
select c1.cnum as customer_1,
c1.cname as customer_name_1,
c2.cnum as customer_2,
c2.cname as customer_name_2,
s.snum as salesperson_id,
s.sname as salesperson_name
from customers c1
join 
customers c2
on
c1.snum = c2.snum
and c1.cnum < c2.cnum
join salespeople s 
on c1.snum = s.snum
order by s.snum, c1.cnum, c2.cnum;

-- 10. write a query that produces all pairs of dalepeople who are living in same city
select s1.snum as salesperson_1,
s1.sname as salesperson_name_1,
s2.snum as salesperson_2,
s2.sname as salesperson_name_2,
s1.city as city
from salespeople s1 join salespeople s2
on s1.city = s2.city and s1.snum < s2.snum
order by s1.city, s1.snum, s2.snum;

-- 11. write a query to find all orders credited to the same salesperson who serves customer 2008.
select o.* from orders o
join customers c on o.snum =c.snum
where c.cnum = 2008;

-- 12.write a query to find all orders that are greater than the average of oct 8th. 
select * from orders where amt > (
select avg(amt) from orders
where odate = '1994-10-04' );

-- 13. write a query to find all orders attributed to salespeople in london. 
select o.*from orders o join customers c on o.snum =c.snum
where c.city = 'london';

-- 14.write a query to find all the customers where cnum is 1000 above the snum of serres. 
select * from customers where cnum = (
select snum + 1000 from customers
where cnum = "serres" );

-- 15. write a query to count customers with ratings above san jose's average rating.
select count(*) from customers
where rating >( select avg(rating)
from customers where city = "san jose" );

-- 16. write a query to show each salesperson with multiple customers. 
select snum, count(*)as costomers_count
from customers group by snum having count(*) > 1;

