/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине */
select u.*, o.* from users u
right join orders o on u.id = o.user_id

/* Выведите список товаров products и разделов catalogs, который соответствует товару */
select p.products, c.catalogs from products p, catalogs c
where products = (select * from catalogs where products = 'Товар')


/* (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов 
flights с русскими названиями городов. */

select 
(select cities.name from cities 
left join cities on flights.from=cities.label) as 'from', 
(select cities.name from cities 
left join cities on flights.to=cities.label) as 'to'
from flights