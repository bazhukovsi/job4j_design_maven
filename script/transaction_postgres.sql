-- таблица products
create table products (
  id serial primary key,
  name varchar(50),
  producer varchar(50),
  count integer default 0,
  price integer
);

-- очиска таблица со сбросом id
delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;
-- вставляем данные
insert into products (name, producer, count, price) VALUES ('product_1', 'producer_1', 3, 50);
insert into products (name, producer, count, price) VALUES ('product_2', 'producer_2', 15, 32);
insert into products (name, producer, count, price) VALUES ('product_3', 'producer_3', 8, 115);
select * from products;

--начинаем транзакцию 1

begin transaction;
insert into products (name, producer, count, price) VALUES ('product_4', 'producer_4', 11, 64);
commit;
select * from products;

--начинаем транзакцию 2

begin transaction;
delete from products;
drop table products;
-- откатываем удаление таблицы и удаление данных из таблицы
rollback transaction;
commit;
select * from products;

--начинаем транзакцию 3

begin transaction;
insert into products (name, producer, count, price) VALUES ('product_5', 'producer_5', 17, 45);
select * from products;
-- устанавливаем точку сохранения first_savepoint
savepoint first_savepoint;
delete from products where price = 115;
update products set price = 75 where name = 'product_1';
select * from products;
-- откатываем к состоянию на точке first_savepoint;
rollback to first_savepoint;
select * from products;
insert into products (name, producer, count, price) VALUES ('A', 'Cherkizpvo', 50, 50);
insert into products (name, producer, count, price) VALUES ('B', 'ASUS', 1, 2);
-- ставим вторую точку сохранения
savepoint second_savepoint;
delete from products where producer = 'ASUS';
delete from products where producer = 'Cherkizovo';
rollback to second_savepoint;
delete from products where producer = 'ASUS';
commit;
select * from products;

-- итоговое состояние таблицы

--1,  product_1,  producer_1,  3,  50
--2,  product_2,  producer_2,  15, 32
--3,  product_3,  producer_3,  8,  115
--4,  product_4,  producer_4,  11, 64
--5,  product_5,  producer_5,  17, 45
--6,  A        ,  Cherkizpvo,  50, 50

