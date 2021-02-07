/* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который 
больше всех общался с нашим пользователем. */

drop table if exists number_of_messages;
create table number_of_messages (
from_users_id int
,to_users_id int
,concatenation int
,number_messages int);

insert into number_of_messages
select from_users_id
, to_users_id
, concat(from_users_id,to_users_id) as concatenation
, count(from_users_id) as number_messages 
FROM vk.messages
group by from_users_id, to_users_id
order by number_messages desc;


drop table if exists friend_pairs_first_half;
drop table if exists friend_pairs_second_half;
drop table if exists friend_pairs;
create table friend_pairs_first_half (
from_users_id int,
to_users_id int,
concatenation int);

create table friend_pairs_second_half (
from_users_id int,
to_users_id int,
concatenation1 int);

create table friend_pairs (
from_users_id int,
to_users_id int,
concatenation1 int);

-- Пары друзей
insert into friend_pairs_first_half
SELECT from_users_id, to_users_id, concat(from_users_id,to_users_id)
FROM friend_requests
WHERE `status` = 1;

insert into friend_pairs_second_half
SELECT to_users_id, from_users_id, concat(to_users_id,from_users_id) 
FROM friend_requests
WHERE `status` = 1;

insert into friend_pairs
select*from friend_pairs_first_half;
insert into friend_pairs
select*from friend_pairs_second_half;

drop table if exists friend_pairs_first_half;
drop table if exists friend_pairs_second_half;

select * from number_of_messages
left join number_of_messages nm on nm.concatenation = friend_pairs.concatenation1
where nm.to_users_id = 8

/*Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.*/

drop table if exists count_likes;
create table count_likes (
users_id1 int,
Число_лайков int);

insert into count_likes
SELECT users_id as users_id1, 
count(posts_id)+count(messages_id)+count(media_id) as Число_лайков
FROM vk.likes
group by users_id
order by Число_лайков desc;

select pr.users_id, pr.birthday from vk.profiles
left join vk.profiles pr on pr.users_id = count_likes.users_id1
order by pr.birthday desc limit 10;

/*Определить кто больше поставил лайков (всего) - мужчины или женщины? */
select pr.gender from vk.profiles
left join vk.profiles pr on pr.users_id = count_likes.users_id1
group by gender

