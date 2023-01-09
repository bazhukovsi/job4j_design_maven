create database products;

create table products (
  id serial primary key,
  name varchar(50),
  producer varchar(50),
  count integer default 0,
  price integer
);

create table history_of_price (
    id serial primary key,
    name varchar(50),
    price integer,
    date timestamp
);

insert into products (name, producer, count, price) VALUES ('product_1', 'producer_1', 8, 40);
insert into products (name, producer, count, price) VALUES ('product_2', 'producer_2', 10, 50);

-- триггер после вставки данных (statement уровень)

create or replace function tax()
    returns trigger as
$$
BEGIN
    update products
    set price = price + price * 0.2;
    where id = (select id from inserted);
    return new;
END;
$$
    LANGUAGE 'plpgsql';

create trigger tax_trigger
    after insert on products
    referencing new table as inserted
    for each statement
execute procedure tax();

-- триггер до вставки данных (row уровень)

create or replace function tax_before()
    returns trigger as
$$
    begin
        new.price = new.price * 1.1;
        return new;
    end
$$
LANGUAGE 'plpgsql';

create trigger tax_before_trigger
    before insert
    on products
    for each row
    execute procedure tax_before();

-- проверка работы триггеров изменения цены (отключение и включение триггера tax_trigger)

insert into products (name, producer, count, price) VALUES ('product_7', 'producer_7', 20, 100);
alter table products disable trigger tax_trigger;
insert into products (name, producer, count, price) VALUES ('product_9', 'producer_9', 20, 100);
alter table products enable trigger tax_trigger;
insert into products (name, producer, count, price) VALUES ('product_10', 'producer_10', 20, 100);
select * from products;

-- триггер для записи истории изменений цены

create or replace function history_of_price()
    returns trigger as
$$
    BEGIN
        insert into history_of_price (name, price, date)
        values (new.name, new.price, now());
        return new;
    END;
$$
LANGUAGE 'plpgsql';

create trigger history_of_price
    after insert
    on products
    for each row
    execute procedure history_of_price();

-- проверка записи в историю изменения цены

insert into products (name, producer, count, price) VALUES ('product_11', 'producer_11', 10, 110);
insert into products (name, producer, count, price) VALUES ('product_12', 'producer_12', 20, 120);
insert into products (name, producer, count, price) VALUES ('product_13', 'producer_13', 30, 130);
select * from history_of_price;