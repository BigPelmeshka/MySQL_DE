#Задание 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
use vk;
update vk.profiles
set created_at = now()
where created_at is null;
update vk.profiles
set updated_at = now()
where updated_at is null;

#На мой взгляд, можно продублировать эти столбцы и их преобразовывать, чтобы не потерять данные. 

/* Задание 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое 
время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/
use vk;
update vk.profiles
set created_at = convert(created_at,datetime)
where created_at is not null;
update vk.profiles
set created_at = convert(updated_at,datetime)
where updated_at is not null;


/* Задание 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился 
и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения 
значения value. Однако нулевые запасы должны выводиться в конце, после всех записей. */

#select * from vk.profiles
#ORDER BY CASE WHEN users_id='0' THEN 1 ELSE 0 end


/* Задание 4. Подсчитайте средний возраст пользователей в таблице users.*/
select 
sum(year(convert(now(),date))-year(birthday)-(RIGHT(now(),5)<RIGHT(birthday,5)))/count(users_id) as Средний_возраст
from vk.profiles

/* Задание 5. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/;

alter table vk.profiles 
add column weekday_current_year varchar(50);

update vk.profiles
set weekday_current_year = weekday(convert(concat(year(now()),'-',month(birthday),'-',day(birthday)),date));

select 
weekday_current_year
,count(users_id) as Количество
from vk.profiles
group by weekday_current_year

