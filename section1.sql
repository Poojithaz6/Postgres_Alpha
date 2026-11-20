create table cities(
name varchar(50),
country varchar(50),
population int,
area int
);

insert into cities (name, country, population, area)
values('Tokyo','Japan',38505000,8223);

insert into cities (name, country, population, area)
values('India','Delhi',28125000,2240);

insert into cities (name,country,population,area)
values('Shanghai','China',2215000,4015);

insert into cities (name,country,population,area)
values('Sao Paulo','Brazil',20935000,3043);

select * from cities;

update cities set name='Delhi' where name='India';
update cities set country='India' where country='Delhi';

select name, country from cities;

select name, population/area as population_density from cities;

select name||','||country as location from cities;

select concat(name,',',country) as location from cities;

select concat(upper(name),',',upper(country)) as location from cities;

select upper(concat(name, ', ', country)) as location from cities;