select u.first_name, u.last_name, o.paid
from users as u
join orders as o on o.user_id = u.id;