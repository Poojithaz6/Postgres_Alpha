create table users(
id serial primary key,
username varchar(50)
);

insert into users (username)
values ('monahan93'),('pferrer'),('si93onis'),('99stroman');

select * from users;

create table photos(
id serial primary key,
url varchar(200),
user_id int references users(id)
);

insert into photos (url,user_id)
values ('https://one.jpg',4);

select * from photos;

insert into photos(url,user_id)
values
('https://two.jpg',1),
('https://25.jpg',1),
('https://36.jpg',1),
('https://754.jpg',2),
('https://35.jpg',3),
('https://256.jpg',4);

select * from photos;

select * from photos where user_id=4;

select url, username
from photos join users on users.id=photos.user_id;

delete from users where id=1;

drop table photos;