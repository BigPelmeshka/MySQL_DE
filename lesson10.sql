/* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name. */

drop table if exists logs;
create table logs (
	created_at datetime,
	name_table varchar(max),
	id bigint(20),
	name_container varchar(max)
) ENGINE = ARCHIVE;

drop trigger if exists trigger_users;
delimiter //
create trigger trigger_users after insert on users
for each row
BEGIN
	insert into logs (created_at, name_table, id, name_container)
	values (NOW(), 'users', new.id, new.name);
END //
delimiter ;

drop trigger if exists trigger_catalogs;
delimiter //
CREATE TRIGGER trigger_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	insert into logs (created_at, name_table, id, name_container)
	values (NOW(), 'catalogs', new.id, new.name);
END //
delimiter ;

delimiter //
CREATE TRIGGER trigger_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	insert into logs (created_at, name_table, id, name_container)
	values (NOW(), 'products', new.id, new.name);
END //
delimiter ;


/*В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.*/
HSET ipaddr 127.0.0.1 
1

/*При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу 
и наоборот, поиск электронного адреса пользователя по его имени. */
SET google_name_email geekbrains@gmail.com
SET geekbrains@gmail.com google_name_email

/*Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.*/
db.shop.insert({category: 'Молочка'})
db.shop.insert({category: 'Мясо'})

db.shop.update({category: 'Молочка'}, {$set: { products:['сыр', 'йогурт', 'молоко'] }})
db.shop.update({category: 'Мясо'}, {$set: { products:['свинина', 'говядина', 'барранина'] }})
