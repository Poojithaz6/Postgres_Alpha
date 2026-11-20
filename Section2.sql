select name, area from cities where area>4000;

select name, area from cities where area between 2000 and 4000;

select name, area from cities where name in ('Delhi','Shanghai');

select name, area from cities where area not in (3043,8223) or name='Delhi';

select name, population/area as population_density from cities where population/area>6000;

update cities set population=39505000 where name='Tokyo';

delete from cities where name='Tokyo';