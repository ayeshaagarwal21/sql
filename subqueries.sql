-- 25/7/26
use world;
select name,indepyear, ifnull(indepyear,0) from country; -- changes null to 0
select name, indepyear, lifeexpectancy,coalesce(indepyear,lifeexpectancy,name) from country; -- returns first not null value
select name,population,indepyear,if (indepyear>1947, "after india", "before india") from country;

select name,population,indepyear,if (indepyear>1947, "after india", 
if (indepyear>1920, "just before india","before india")) as casecond from country;

select name, population, indepyear,
case
  when indepyear>1947 then 'After India'
  when indepyear>=1919 then 'only after 1919'
  else 'No cond'
end
from country;

-- pop 200000-500000 avg pop, if 500000> then large else small pop
select name,population,
case
  when population>200000 AND population<500000 then 'Average population'
  when population>500000 then 'Large population'
  else 'small population'
end 
from country;

-- print the continent name and the no of countries with the category of the continent column , category if country in continent>10 small, if >15 avg size, >25 large scale
select distinct(continent) AS Continents, count(*) AS CountryCount, CASE
when count(*)>25 then 'Large'
when count(*)>15 then 'Average'
when count(*)>10 then 'Small'
else 'very small'
end AS category
from country group by Continents;

-- 28/7/26
-- a query within a query is called subquery
-- subquery is also known as nested query where a query is present inside another query
create database corr_db;
use corr_db;
create table employee_c(id int, name varchar(50), salary int);
insert into employee_c values(1,'a',100),(2,'b',250),(3,'c',400),(4,'d',380);

insert into employee_c values(5,'aman',250);

-- highest salary
select max(salary) from employee_c;
select * from employee_c where salary=400;

-- minimum salary
select min(salary) from employee_c;
select * from employee_c where salary=100;

-- nested query - outer query depends on inner query
-- {select * from employee_c where salary=} // outer quert{(query)} // inner, nested or sub query;
-- single row subquery as it returns only one row
select * from employee_c where salary=(select min(salary) from employee_c);
select * from employee_c where salary=(select max(salary) from employee_c);

select * from employee_c where salary=(select salary from employee_c where name='b');
select avg(salary) from employee_c;
select id,name from employee_c where salary>(select avg(salary) from employee_c);

use world;
select * from city;
-- get the name of the city where the district of the city is same for the city abu dhabi
select name from city where district=(select district from city where name='abu dhabi');

-- get all the columns from the city table where the population is max
select * from city where population=(select max(population) from city);

-- get the district and the name of the city where the countrycode is same for herat
select district, name from city where countrycode=(select countrycode from city where name='herat');

-- get the district city and popualtion for all the countries of amsterdam and sort data by population
select district, name , population from city where countrycode=(select countrycode from city where name='amsterdam') order by population; 

-- 30/7/26
-- multirow subquery
create database corr_db2;
use corr_db2;
create table employee_co(id int, name varchar(20), salary int);
insert into employee_co values(1,'a', 100),(2,'b',250),(3,'c',400),(4,'d',100),
(5,'a',300);
select * from employee_co;
select * from employee_co where salary in (select salary from employee_co where name ='a');

select * from employee_co where salary = any (select salary from employee_co where name ='a');
select * from employee_co where salary >any (select salary from employee_co where name ='a');
select * from employee_co where salary <any (select salary from employee_co where name ='a');

select * from employee_co where salary >all (select salary from employee_co where name ='a');
select * from employee_co where salary <all (select salary from employee_co where name ='a');

-- 31/7/26
create table order1(order_id int, name varchar(20), amount int);
insert into order1 values(1,'a',100),(2,'a',200),(3,'a',300),(4,'b',400),(5,'b',300);
select * from order1;
select * from order1 where amount=(select max(amount) from order1 where name='a');
select * from order1 where name='a' and amount=(select max(amount) from order1 where name='a');
select * from order1 as o where amount=(select max(amount) from order1 where name=o.name);

-- 1/8/26
create database querydb;

use querydb;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender CHAR(1),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);


INSERT INTO Department VALUES
(101, 'HR', 'Delhi'),
(102, 'IT', 'Bangalore'),
(103, 'Finance', 'Mumbai'),
(104, 'Sales', 'Pune'),
(105, 'Marketing', 'Hyderabad');



INSERT INTO Employee VALUES
(1, 'Amit',    'M', 55000, 101, NULL),
(2, 'Neha',    'F', 48000, 101, 1),
(3, 'Raj',     'M', 62000, 101, 1),
(4, 'Priya',   'F', 70000, 102, NULL),
(5, 'Arjun',   'M', 68000, 102, 4),
(6, 'Kiran',   'F', 72000, 102, 4),
(7, 'Rohit',   'M', 61000, 102, 4),
(8, 'Sneha',   'F', 80000, 103, NULL),
(9, 'Vikas',   'M', 75000, 103, 8),
(10,'Anjali',  'F', 78000, 103, 8),
(11,'Mohit',   'M', 50000, 104, NULL),
(12,'Pooja',   'F', 45000, 104, 11),
(13,'Deepak',  'M', 53000, 104, 11),
(14,'Riya',    'F', 60000, 104, 11),
(15,'Kunal',   'M', 65000, 105, NULL),
(16,'Nisha',   'F', 62000, 105, 15),
(17,'Varun',   'M', 59000, 105, 15),
(18,'Isha',    'F', 67000, 105, 15),
(19,'Manish',  'M', 64000, 105, 15),
(20,'Kavya',   'F', 52000, 101, 1);

select * from employee;
select * from department;

select * from employee where dept_id=104
and salary=(select max(salary) from employee where dept_id=104);

select * from employee as eout where 
salary=(select max(salary) from employee where dept_id=eout.dept_id);

-- employee whose salary is greater than avg salary of their own dept
select * from employee as e where salary>(select avg(salary) from employee where dept_id=e.dept_id);

-- employee who earns more than every other employee in their department
select emp_name from employee as e where salary>=ALL(select salary from employee where dept_id=e.dept_id);

-- employee whose salary is greater than their managers
select * from employee as e where salary > (select salary from employee as m where m.dept_id=e.manager_id);

-- employees who are not the highest paid in their department
select emp_name from employee as e where salary != (select max(salary) from employee where dept_id=e.dept_id);

-- departments having atleast one employee earning more than 70000
select dept_name from department where dept_id in (select dept_id from employee where salary>70000);

-- second highest salary
select emp_name, dept_id, salary from employee as e where salary=(select max(salary) from employee as e2 where dept_id=e.dept_id and 
salary<(select max(salary) from employee where dept_id=e.dept_id));

-- 3/8/26
drop database if exists newdb2;
create database newdb2;

use newdb2;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30)
);

INSERT INTO Customers VALUES
(101, 'Alice', 'New York'),
(102, 'Bob', 'Chicago'),
(103, 'Charlie', 'Dallas'),
(104, 'David', 'Seattle'),
(105, 'Emma', 'Boston'),
(106, 'Frank', 'Chicago'),
(107, 'Grace', 'Dallas'),
(108, 'Henry', 'Miami');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO Orders VALUES
(1001, 101, '2025-01-05', 1200, 'Delivered'),
(1002, 101, '2025-02-15', 800, 'Cancelled'),
(1003, 102, '2025-01-20', 3500, 'Delivered'),
(1004, 102, '2025-03-10', 600, 'Pending'),
(1005, 103, '2025-02-18', 900, 'Delivered'),
(1006, 104, '2025-03-05', 4500, 'Delivered'),
(1007, 104, '2025-04-01', 700, 'Pending'),
(1008, 105, '2025-01-11', 1500, 'Cancelled'),
(1009, 105, '2025-04-12', 2200, 'Delivered'),
(1010, 107, '2025-05-01', 1800, 'Pending');

select * from customers;
select * from orders;

-- when we take values from outer table relate them to the inner table
-- exist and non exist correlated subquery --> it will check once if the vlaue is present, unlike IN it does not check every query and
 -- return true or false value and than the outer query will fetch value, 1-True, 0-False, tho we can also use IN to determine all values
-- in operator will check for every value written by the subquery
-- in operator is slower than exist operator
-- with null IN may fail whereas exist is unlikely to fail

select customer_name from customers where exists(select 1 from orders where orders.customer_id=customers.customer_id);
select * from customers where exists (select 1 from orders where orders.customer_id=customers.customer_id);

select * from customers where not exists (select 1 from orders where orders.customer_id=customers.customer_id);

-- find the customer where cusstomer has atleast 1 delivered order
select * from customers where exists(select 1 from orders where orders.customer_id=customers.customer_id AND orders.status='delivered');

-- find the customer who have both delivered and pending
select * from customers where exists(select 1 from orders where orders.customer_id=customers.customer_id AND orders.status='delivered') 
AND exists 
(select 1 from orders where orders.customer_id=customers.customer_id AND orders.status='pending');