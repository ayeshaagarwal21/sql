use world;
select * from city;
select * from country;

select city.name, city.countrycode from city;
select country.name, country.code from country;

select city.name, city.countrycode, country.code, country.name AS Country_name
from city join country where city.countrycode=country.code and city.name='Amsterdam';

select cn.name,cn.population from country as cn;
select c.name,c.population from city as c;

select cn.name,cn.population,c.name,c.population from city as c join country as cn where
c.countrycode=cn.code;

-- 20/7/26
create database joinsdb;
use joinsdb;

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50)
);
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
DepartmentID INT
);
INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID)
VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 105),
(4, 'David', NULL), 
(5, 'Eva', 101);

-- old syntax
select e.employeeid, e.employeename, e.departmentID,
d.departmentname, d.departmentid from employees as e join departments as d
where d.departmentid=e.departmentid;

select d.departmentid, d.departmentname from departments as d;
select d.departmentid, d.departmentname from departments as d;

-- new syntax (on) also inner join
select e.employeeid, e.employeename, e.departmentID,
d.departmentname, d.departmentid from employees as e join departments as d
on d.departmentid=e.departmentid;

-- left join
select e.employeeid, e.employeename, e.departmentID,
d.departmentname, d.departmentid from employees as e left join departments as d
on d.departmentid=e.departmentid;

select e.employeeid, e.employeename, e.departmentID,
d.departmentname, d.departmentid from departments as d left join employees as e
on d.departmentid=e.departmentid;

-- primary key -> country code and foriegn key joining the table 2 with reference to primary key
select c.id,c.name,c.countrycode,cn.code, cn.name from city as c join country as cn
where c.countrycode=cn.code;

-- cross join
select c.id,c.name,c.countrycode,cn.code, cn.name from city as c cross join country as cn
where c.countrycode=cn.code;

-- 21/7/26
-- natural join -> doesnt use condition and automatically joins the column with same name
-- natural join
select c.id, c.name, c.countrycode, cty.code,cty.name from city as c natural join country as cty;

-- self join
 create database selfjoindb;
 use selfjoindb;
 
 create table employee(e_id int , name varchar(20), manager_id int);
 insert into employee values(1,'Tushar',null),(2,'abhinav',1),(3,'saksham',1),(4,'akshay',2);
 select * from employee;
 
select e.e_id, e.name, e.manager_id, mngr.e_id, mngr.name from employee as e left join employee as mngr on e.manager_id=mngr.e_id;
select mngr.e_id, mngr.name from employee as mngr;

-- 23/7/26
use joinsdb2;

-- to find out total budget of each department
select d.dept_name, sum(budget) from projects as p join departments as d on p.dept_id=d.dept_id
group by dept_name;

-- find dept_name and total employees working in that department
select d.dept_name, count(emp_id) AS EmpCount from employees as e join departments as d ON e.dept_id=d.dept_id 
group by dept_name having count(emp_id)>1;

-- where clause and having clause are both used with group by
-- where clause is used to filter the data from table 
-- having is used to filter after using aggregate func
-- where doesnt execute aggregate func because execution order of where is before than aggregate func

-- a primary key can be made by combining more than one column. In relational databases, this combination is called a composite primary key 

