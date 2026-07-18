-- 13/7/26
use world;
-- multiple rows function - it collapses number of rows into a single element
select distinct(continent) from country; -- applies on multiple values and returns unique values
select count(continent) from country; -- finds out total no of rows in the given column
select count(name) as continents, count(distinct(continent)) as unique_continent from country; -- will give count of all the unique continents present

-- aggregate func are funcs which are used to apply the calculations on set of rows eg count, max, min, sum, svg
select count(population), sum(population), avg(population) from country;
select count(surfacearea), sum(surfacearea), max(surfacearea) from country;
select count(continent), max(continent), min(continent) from country; -- max,min will give value accdn to the alphabet order, doesnt work with sum,avg
select population, count(population) from country; -- non aggregate column = population, aggregate column=count(population)
 -- normal column cannot be printed with aggregate column, aggregate columns will be printed with aggregate columns
 
 select avg(population),avg(replace(population,1,4)) from country;
select avg(population),avg(replace(population,0,'')) from country;
  
  -- DATA SORTING (ORDER BY) clause
select name, continent, region, population from country order by name;
select name, continent, region, population from country order by name desc;
select name, continent, region, population from country order by population;
select name, continent, region, population from country order by population, name;
select name, continent, region, population from country order by continent, name;
select name, continent, region, population from country order by region, population desc; -- refion sorted in ascending order than population of each region is sorted in descending order
select name, continent, region, population from country order by continent;

-- 14/7/26
-- group by --> used for collection of same 

select distinct(continent) from country; -- cannot use any aggregate func with distinct
select continent from country group by continent;
select continent,count(name) from country group by continent; -- applies count on every continent collectively above doesnt do it collectively
select name,count(name) from country group by name;

select * from city;
select district,count(name) from city group by district;
select count(name) from city where district='Zuid-holland';
select district,count(name),sum(population) from city group by district; -- we can only print column which is being grouped

select countrycode,count(name) from city where countrycode='Afg';
select countrycode,count(name) from city group by countrycode; 

select * from country;
-- count the no of countries which have a lie expentancy from 70.1 to 83.5
select count(name) from country where LifeExpectancy>=70.1 AND lifeexpectancy<=83.5;

-- get the total population of the country who got their independence after 1990
select sum(population) from country where Indepyear>1990;

-- count the no of countries which are not slaved by any community
select count(name) from country where indepyear IS null;
select count(name)-count(indepyear) from country;

-- get the total countries and the total surface area for each region 
select region,count(name),sum(surfacearea) from country group by region;

-- get the total countries in each continent
select continent,count(name) from country group by continent having count(name)>10;

-- get the total country for each region for each continent
select region,continent,count(name) from country group by region,continent; 

-- 17/7/26
select continent,count(*) AS CountryCount from country group by continent having CountryCount>30;

select indepyear,count(*) AS IndepCountry from country group by indepyear having IndepCountry>10;

-- assgn
-- searched case
select name,continent, CASE
when population>='1000000' then 'densly populated'
when population>='200000' AND population<'10000' then 'poorly populated'
END AS Population_count from country;

-- simple case
select  name,lifeexpectancy, CASE lifeexpectancy
when 79.8 then 'very long'
when 45.0 then 'very short'
when 66.4 then 'moderate'
else 'unknown'
END AS Lengthoflife
from country;

-- with order by
select name,continent from country order by CASE continent 
when 'Asia' then 1
when 'africa' then 2
else 3
END,name asc;

-- with aggregate func
select name,continent, 
COUNT(CASE WHEN region='Southeast Asia' then 1 end) AS asia_region,
COUNT(CASE WHEN region='Western Europe' then 2 end) AS europe_region
from country group by name,continent;

-- IFNULL
select name,IFNULL(Indepyear,0) AS IndepYear from country;

-- Coalesce
SELECT Name, COALESCE(IndepYear, 0) AS Independence_Year FROM Country;