-- Очистим таблицу со сбросом id в 1

delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;

-- insert data

call insert_data('WAP-9', 'HUAWEI', 1, 1000);
call insert_data('QWEWQWE', 'Toshiba', 0, 800);

select * from products;

-- delete, if count = 0;
-- процедура

create or replace procedure
    proc_delete_data_byCountZero()
    language 'plpgsql'
as $$
begin
    delete from products where count = 0;
end
$$;

call proc_delete_data_byCountZero();
select * from products;

call insert_data('GHJGHJGH', 'Lenovo', 1, 900);
call insert_data('GHJ678678', 'Asus', 0, 300);
select * from products;

-- delete, if count = 0;
-- функция

create or replace function
    func_delete_data_byCountZero()
    returns integer
    language 'plpgsql'
as $$
declare
    result integer;
begin
    select count(*) into result from products where count = 0;
    delete from products where count = 0;
    return result;
end;
$$;

select func_delete_data_byCountZero();
select * from products;

-- удаление по id
-- процедура

create or replace procedure
    proc_delete_data_byId()
    language 'plpgsql'
as $$
begin
    delete from products where id = 1;
end
$$;

select proc_delete_data_byId();
select * from products;

-- удаление по id
-- функция

create or replace function
    func_delete_data_byId()
    returns integer
    language 'plpgsql'
as $$
declare
    result integer;
begin
    select count(*) into result from products where count = 0;
    delete from products where id = 3;
    return result;
end;
$$;

select func_delete_data_byId();
select * from products;
