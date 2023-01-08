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
insert into products (name, producer, count, price) VALUES ('product_3', 'producer_3', 12, 60);
insert into products (name, producer, count, price) VALUES ('product_4', 'producer_4', 14, 70);
insert into products (name, producer, count, price) VALUES ('product_5', 'producer_5', 16, 80);
insert into products (name, producer, count, price) VALUES ('product_6', 'producer_6', 18, 90);
insert into products (name, producer, count, price) VALUES ('product_7', 'producer_7', 20, 100);

create or replace function tax()
    returns trigger as
$$
BEGIN
    update products
    set price = price + price * 0.2;
    return new;
END;
$$
    LANGUAGE 'plpgsql';

create trigger tax_trigger
    after insert on products
    referencing new table as inserted
    for each statement
execute procedure tax();

insert into products (name, producer, count, price) VALUES ('product_8', 'producer_8', 22, 110);

create or replace function history_insert_trigger_fnc()
  returns trigger AS
$$
begin
 insert into history_of_price ("name","price","date")
values (NEW."name",NEW."price", now());
return new;
end;
$$
language 'plpgsql';

create trigger history_insert_trigger
  after insert
  on products
  for each row
  execute procedure history_insert_trigger_fnc();