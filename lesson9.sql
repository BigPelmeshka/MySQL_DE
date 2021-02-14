/* В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись 
id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции. */

start transaction;

select * from sample.users
union all 
select * from shop.users where id = 1

commit;


/*Создайте представление, которое выводит название name товарной позиции из таблицы products и 
соответствующее название каталога name из таблицы catalogs. */

create view test as 
select products.name, catalogs.name from products 
left join products on products.id = catalogs.id; 

select * from test;

/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от 
текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 
функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
"Доброй ночи". */

delimiter //
create procedure hello()
begin 
	if (hour(now()) >= 6 and hour(now()) < 12) then
		select 'Доброе утро';
	elseif (hour(now()) >= 12 and hour(now()) < 18) then
		return 'Добрый день';
	elseif (hour(now()) >= 12 and hour(now()) < 18) then
		return 'Добрый вечер';
	else
		return 'Доброй ночи';
	end if;
end //


/*В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля 
были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

create trigger NULL_tr before insert on products
for each row
begin 
	if (isnull(name) and isnull(description)) then
		signal sqlstate '45000' set message_text = 'NULL in fields';
    end if;
end //
