-- 8/7/26
create database moviesdb;
use moviesdb; -- you are using the database(kind of like folder)
-- creates DDL
create table ranveer(filmname varchar(50), amount int, director varchar(50));
describe ranveer; -- describes table
-- insert data => DML
insert into ranveer values('Dhurandar', '800000000', 'aditya dhar');
select * from ranveer; -- select is DQL

show databases;
use world;
describe country; -- table mai konse column hai and their datatype
-- data access
select * from country;
select name, continent from country;
select name, continent, population, population+500  as newpopulation from country; -- doesnt change the prev population table , also as is used to change the name of tables only in output not originally
-- to select limited no of rows
select * from country where continent='Asia';
select * from country where name='Bahrain';

select name,continent,population from country where name='china';

select * from country where population=156483000;
select name,indepyear from country where continent='Europe' and indepyear>1900;

-- 1) get the country code and country name where the surface area of the country is greater than 900
select * from country;
select code,name from country where surfacearea>900;

-- 2) get the country code and country name only for the countries where the region is southern europe
select code,name from country where region='Southern Europe';

-- 3) get the country code and country name where the continent belongs to africa and the region is central africa 
select code,name from country where continent='Africa' and region='Central Africa';

-- 4) get the country name, continent and population where they belong to asia or africa 
select name,continent,population from country where continent='Asia' or continent='Africa';

-- 5) get the country name, population and region with the 10% increament in the population for the countries whose independence year is after 1950
select name,population,region,population+(0.1*population) as newpopulation from country where indepyear>1950;

-- 6) get all the values  of country where the country name and local name is same
select * from country where name=localname;

-- ASSGN
-- between, in, like opr 
use world;
show tables;
select * from country;

select name,continent,population from country where population between 75000 and 200000;

select name,continent,region from country where region IN ('central africa', 'southern europe');

select name from country where name like 'A%';
select name from country where name like '%A';
select name from country where name like '%A%';
select name from country where name like 'A_____';

-- 9/7/26
select * from city;
select * from city where population between 100000 and 150000;
select * from city where population IN (129170,117196);
select * from city where name like '%a%';

-- 1) get the city and the population where u have the letter E in the city name
SELECT name, population from city where name like '%E%';
-- 2) get the city and the population where second last letter should be B
SELECT name, population from city where name like '%B_';
-- 3) get the city and the population where have the second letter as A and last second character as R
SELECT name, population from city where name like '_A%R_';
-- 4) get the city and the population where u have AA in the city name
SELECT name, population from city where name like '%AA%';
-- 5) get the city and the population where the country name have the two characters EE seperated with a character and it should be in middle
SELECT name, population from city where name like '_%E_E%_';

-- assgn concat, replace, trim, substr, length
select concat(name,'-',continent) as country_capital from country;

select name, length(name) as Name_length from country;

select trim(name) from country;

select governmentform, REPLACE (governmentform, 'republic', 'democratic') as new_form from country;

select name, substring(name,1,3) as First3 from country; 

-- 10/07/2026
-- assign concat,replace,trim,substr,length
use world;
select concat(name,'-',continent) as country_capital from country;  -- used to add two string but here we need to give the separater
-- now to solve this issue of separation justification is done using CONCAT_WS(with separator)
select name,continent , concat_ws('-',continent,name) from country;
 
-- substring= to get some portion of the string from the original string
-- here index value starts from 1 only 
select name,substring(name,1,3) from country;
select name,substr(name,-4,2) from country;

-- length- total no of bytes(memory)
-- char_length - total length of any character 
select name,char_length(name) as name_length from country;

-- replace= replacing any char in the column 
select name,replace(name,'a','e') from country;

-- trim=it is used to remove the white spaces from th staring and ending of the charter
select trim('     he llo    ');
select trim(name) from country;

-- lpad/rpad= means to add(basically when we need to have a fix size like here of 6 ch so it pad or add a given charter in the name)
select name,lpad(name,6,'-') from country;

-- date- YYYY-MM-DD   <= DD/MM/YYYY ( can be converted )
select current_date(), current_time(), current_timestamp(), now();
select now();
select now(), adddate(now(), 2);   -- add the given days in the current date 
select now(), adddate(now(), interval 1 month); 
select now(), adddate(now(), interval 1 year), adddate(now(), interval 1 week);

-- extract year,month etc from the date
select now() , year(now()) , month(now());
select extract(month from now()), extract(year from now()), extract(minute from now());
select weekday ( now());
select now(), date_format(now(),'month is %m');

-- 11/7/26
-- numeric func
select lifeexpectancy, round(lifeexpectancy) from country; -- rounds off the value
select round(78.467,1);

-- round off to nearest 10,100,1000
select round(9,-1),round(4.4,-1),round(23,-1);
select round(13.2,-2),round(233,-2),round(64.2,-2);
select round(2350,-3), round(534,-3), round(7654.9,-3);

-- truncate
select round(34.867,-1), truncate(34.867,-1); -- extracts values does not rounds it off

-- mod
select round(34.867,-1), truncate(34.867,-1), mod(3,5);

-- floor - shows lower value
select floor(34.9999999999);
select floor(2662.724), floor(653.223);

-- ceil - shows upper value 
select ceil(34.000001);

-- abs 
select abs(-10.0239);