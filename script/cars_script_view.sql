create table dealers (
    id serial primary key,
    company_name varchar(255),
    company_city varchar(255)
);

insert into dealers (company_name, company_city) values ('Auto-Dom', 'Petrozavodsk');
insert into dealers (company_name, company_city) values ('VW Auto', 'Moscow');
insert into dealers (company_name, company_city) values ('Scoda Auto', 'SPB');

create table brands (
    id serial primary key,
    brand_name varchar(50),
    country_brand varchar(50)
);

insert into brands (brand_name, country_brand) values ('Toyota', 'Japan');
insert into brands (brand_name, country_brand) values ('VW', 'Germany');
insert into brands (brand_name, country_brand) values ('Skoda', 'Chech Republic');
insert into brands (brand_name, country_brand) values ('BMV', 'Germany');
insert into brands (brand_name, country_brand) values ('KIA', 'Korea');

create table models (
    id serial primary key,
    model_name varchar(200),
    model_id integer references brands(id)
);

insert into models (model_name, model_id) values ('RAV4', 1);
insert into models (model_name, model_id) values ('Land Cruiser', 1);
insert into models (model_name, model_id) values ('Hilux', 1);
insert into models (model_name, model_id) values ('VW Polo', 2);
insert into models (model_name, model_id) values ('VW Tiguan', 2);
insert into models (model_name, model_id) values ('VW Amarok', 2);
insert into models (model_name, model_id) values ('Rapid', 3);
insert into models (model_name, model_id) values ('Octavia', 3);
insert into models (model_name, model_id) values ('X5', 4);
insert into models (model_name, model_id) values ('X6', 4);
insert into models (model_name, model_id) values ('Sportage', 5);
insert into models (model_name, model_id) values ('RIO', 5);

create table orders (
    id serial primary key,
    model_id integer references models(id),
    dealer_id integer references dealers(id)
);

insert into orders (model_id, dealer_id) values (1, 1);
insert into orders (model_id, dealer_id) values (1, 1);
insert into orders (model_id, dealer_id) values (2, 1);
insert into orders (model_id, dealer_id) values (2, 1);
insert into orders (model_id, dealer_id) values (2, 1);
insert into orders (model_id, dealer_id) values (3, 1);
insert into orders (model_id, dealer_id) values (5, 1);
insert into orders (model_id, dealer_id) values (6, 1);
insert into orders (model_id, dealer_id) values (4, 2);
insert into orders (model_id, dealer_id) values (5, 2);
insert into orders (model_id, dealer_id) values (6, 2);
insert into orders (model_id, dealer_id) values (6, 2);
insert into orders (model_id, dealer_id) values (6, 2);
insert into orders (model_id, dealer_id) values (6, 2);
insert into orders (model_id, dealer_id) values (5, 2);
insert into orders (model_id, dealer_id) values (7, 2);
insert into orders (model_id, dealer_id) values (8, 2);
insert into orders (model_id, dealer_id) values (8, 2);
insert into orders (model_id, dealer_id) values (9, 3);
insert into orders (model_id, dealer_id) values (9, 3);
insert into orders (model_id, dealer_id) values (9, 3);
insert into orders (model_id, dealer_id) values (10, 3);
insert into orders (model_id, dealer_id) values (10, 3);
insert into orders (model_id, dealer_id) values (11, 3);
insert into orders (model_id, dealer_id) values (11, 3);
insert into orders (model_id, dealer_id) values (11, 3);
insert into orders (model_id, dealer_id) values (11, 3);
insert into orders (model_id, dealer_id) values (2, 3);

create view show_dealers_with_2_or_more_models
as select d.company_name as company, count(b.brand_name), b.brand_name as brand from dealers as d
         join orders o on d.id = o.dealer_id
         join models m on o.model_id = m.id
         join brands b on m.model_id = b.id
         group by (d.company_name, b.brand_name) having count(b.brand_name) >= 2;

select * from show_dealers_with_2_or_more_models;

create view all_orders
as select d.company_name, d.company_city, m.model_name, b.brand_name, b.country_brand  from dealers as d
         join orders o on d.id = o.dealer_id
         join models m on o.model_id = m.id
         join brands b on m.model_id = b.id;

select * from all_orders;
