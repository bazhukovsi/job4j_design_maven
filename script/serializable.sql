-- таблица из предыдущих примеров

create table products (
  id serial primary key,
  name varchar(50),
  producer varchar(50),
  count integer default 0,
  price integer
);

-- вставляем данные

insert into products (name, producer, count, price) VALUES ('A', 'HUAWEI', 10, 110);
insert into products (name, producer, count, price) VALUES ('B', 'TOSHIBA', 20, 120);
insert into products (name, producer, count, price) VALUES ('C', 'ASUS', 30, 130);

-- перечень команд в транзакции из первой консоли
begin transaction isolation level serializable;
 select sum(count) from products;
 update products set count = 26 where name = 'A';
 update products set count = 10 where name = 'B';
 update products set count = 15 where name = 'C';
commit


-- перечень команд в транзакции из второй консоли
begin transaction isolation level serializable;
 select sum(count) from products;
 update products set count = 40 where name = 'A';

select * from products;

-- products
--1, A, HUAWEI,  26, 110
--2, B, TOSHIBA, 10, 120
--3, C, ASUS,    15, 130
