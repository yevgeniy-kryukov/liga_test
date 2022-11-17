REM   Script: liga
REM   liga

create table customer (
    cust_id integer not null,
    fullname varchar (255 char) not null,
    sex varchar (1 char) not null,
    birth_dt date not null,
    valid_from date not null,
    valid_to date not null
);

insert into customer (cust_id, fullname, sex, birth_dt, valid_from, valid_to)
select
1,
'Иванова',
'Ж',
to_date('01.01.1960', 'dd.mm.yyyy'),
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.2021', 'dd.mm.yyyy')
from dual
union all
select
1,
'Петрова',
'Ж',
to_date('01.01.1960', 'dd.mm.yyyy'),
to_date('01.01.2021', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
2,
'Петров',
'М',
to_date('01.01.1955', 'dd.mm.yyyy'),
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
3,
'Сидоров',
'М',
to_date('01.01.1980', 'dd.mm.yyyy'),
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual;

create table customer_contact (
    cust_id integer not null,
    type varchar (7 char) not null,
    value varchar (255 char) not null,
    valid_from date,
    valid_to date
);

insert into customer_contact (cust_id, type, value, valid_from, valid_to)
select
1,
'EMAIL',
'ivanova@mail.ru',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
1,
'PHONE',
'+7 965 123 45 67',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
1,
'ADDRESS',
'г. Саратов, улица Ленина, дом 8',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.2021', 'dd.mm.yyyy')
from dual
union all
select
1,
'ADDRESS',
'г. Москва, улица Ленина, дом 10',
to_date('01.01.2021', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
2,
'EMAIL',
'petrov@mail.ru',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
2,
'ADDRESS',
'г. Москва, улица Ленина, дом 10',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
3,
'EMAIL',
'sidorov@mail.ru',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
3,
'PHONE',
'+ 7 965 678 12 34',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
3,
'ADDRESS',
'г. Саратов, улица Ленина, дом 9',
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual;

create table transaction (
    cust_id integer not null,
    transaction_dt date not null,
    currency_id varchar (3 char) not null,
    transaction_amt number not null
);

insert into transaction (cust_id, transaction_dt, currency_id, transaction_amt)
select
1,
to_date('01.01.2021', 'dd.mm.yyyy'),
'RUR',
1000
from dual
union all
select
1,
to_date('02.01.2021', 'dd.mm.yyyy'),
'EUR',
100
from dual
union all
select
1,
to_date('03.01.2021', 'dd.mm.yyyy'),
'EUR',
100
from dual
union all
select
1,
to_date('04.01.2021', 'dd.mm.yyyy'),
'USD',
50
from dual
union all
select
2,
to_date('01.01.2021', 'dd.mm.yyyy'),
'USD',
150
from dual
union all
select
2,
to_date('02.01.2021', 'dd.mm.yyyy'),
'USD',
200
from dual
union all
select
2,
to_date('04.01.2021', 'dd.mm.yyyy'),
'USD',
50
from dual
union all
select
3,
to_date('01.01.2021', 'dd.mm.yyyy'),
'RUR',
2000
from dual
union all
select
3,
to_date('04.01.2021', 'dd.mm.yyyy'),
'RUR',
5000
from dual;

create table currency_rate (
    currency_id varchar (3) not null,
    exch_rate number not null,
    valid_from date not null,
    valid_to date not null
);

insert into currency_rate (currency_id, exch_rate, valid_from, valid_to)
select
'RUR',
1,
to_date('01.01.1900', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
'EUR',
90,
to_date('01.01.2021', 'dd.mm.yyyy'),
to_date('03.01.2021', 'dd.mm.yyyy')
from dual
union all
select
'EUR',
95,
to_date('03.01.2021', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual
union all
select
'USD',
70,
to_date('01.01.2021', 'dd.mm.yyyy'),
to_date('02.01.2021', 'dd.mm.yyyy')
from dual
union all
select
'USD',
75,
to_date('02.01.2021', 'dd.mm.yyyy'),
to_date('04.01.2021', 'dd.mm.yyyy')
from dual
union all
select
'USD',
70,
to_date('04.01.2021', 'dd.mm.yyyy'),
to_date('01.01.4000', 'dd.mm.yyyy')
from dual;

comment on table currency_rate is 'курсы валют';

comment on table customer is 'клиенты';

comment on table customer_contact is 'контакты клиентов';

comment on table transaction is 'транзакции клиентов';

