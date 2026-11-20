select max(avg_price) as max_average_price
from (
    select avg(price) as avg_price
    from phones
    group by manufacturer
);