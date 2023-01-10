-- таблица клиентов

CREATE TABLE customers(
    id serial primary key,
    first_name text,
    last_name text,
    age int,
    country text
);

-- таблица заказов

CREATE TABLE orders(
    id serial primary key,
    amount int,
    customer_id int references customers(id)
);

insert into customers (first_name, last_name, age, country) values ('Serg', 'Ivanov', 25, 'Russia');
insert into customers (first_name, last_name, age, country) values ('Petr', 'Petrov', 30, 'Russia');
insert into customers (first_name, last_name, age, country) values ('Ivan', 'Kruglov', 25, 'Russia');
insert into customers (first_name, last_name, age, country) values ('Andrey', 'Klochkov', 28, 'Russia');
insert into customers (first_name, last_name, age, country) values ('Eugene', 'Borisov', 29, 'Russia');
insert into customers (first_name, last_name, age, country) values ('Sasha', 'Ivanova', 40, 'Russia');
insert into customers (first_name, last_name, age, country) values ('Masha', 'Markova', 45, 'Russia');

insert into orders (amount, customer_id) VALUES (300, 1);
insert into orders (amount, customer_id) VALUES (500, 1);
insert into orders (amount, customer_id) VALUES (900, 2);
insert into orders (amount, customer_id) VALUES (150, 3);
insert into orders (amount, customer_id) VALUES (350, 3);
insert into orders (amount, customer_id) VALUES (500, 3);
insert into orders (amount, customer_id) VALUES (700, 4);
insert into orders (amount, customer_id) VALUES (900, 4);

-- вывод клиентов с минимальным возрастом

select first_name, last_name, country, age from customers
where age = (select min(age) from customers);

-- пользователи, не сдлавшие ни одного заказа

select first_name, last_name, age, country from customers
where customers.id NOT IN (SELECT orders.customer_id FROM orders);

