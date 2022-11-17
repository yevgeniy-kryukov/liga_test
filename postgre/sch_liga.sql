create schema liga;

create table liga.customer (
    cust_id integer not null,
    fullname character varying (255) not null,
    sex character varying (1) not null,
    birth_dt timestamp without time zone not null,
    valid_from timestamp without time zone not null,
    valid_to timestamp without time zone not null
);

insert into liga.customer 
values (
1,
'Иванова',
'Ж',
'01.01.1960',
'01.01.1900',
'01.01.2021'
),
(
1,
'Петрова',
'Ж',
'01.01.1960',
'01.01.2021',
'01.01.4000'
),
(
2,
'Петров',
'М',
'01.01.1955',
'01.01.1900',
'01.01.4000'
),
(
3,
'Сидоров',
'М',
'01.01.1980',
'01.01.1900',
'01.01.4000'
);

create table liga.customer_contact (
    cust_id integer not null,
    type character varying (7) not null,
    value character varying (255) not null,
    valid_from timestamp without time zone not null,
    valid_to timestamp without time zone not null
);

insert into liga.customer_contact 
values (
1,
'EMAIL',
'ivanova@mail.ru',
'01.01.1900',
'01.01.4000'
),
(
1,
'PHONE',
'+7 965 123 45 67',
'01.01.1900',
'01.01.4000'
),
(
1,
'ADDRESS',
'г. Саратов, улица Ленина, дом 8',
'01.01.1900',
'01.01.2021'
),
(
1,
'ADDRESS',
'г. Москва, улица Ленина, дом 10',
'01.01.2021',
'01.01.4000'
),
(
2,
'EMAIL',
'petrov@mail.ru',
'01.01.1900',
'01.01.4000'
),
(
2,
'ADDRESS',
'г. Москва, улица Ленина, дом 10',
'01.01.1900',
'01.01.4000'
),
(
3,
'EMAIL',
'sidorov@mail.ru',
'01.01.1900',
'01.01.4000'
),
(
3,
'PHONE',
'+ 7 965 678 12 34',
'01.01.1900',
'01.01.4000'
),
(
3,
'ADDRESS',
'г. Саратов, улица Ленина, дом 9',
'01.01.1900',
'01.01.4000'
);

create table liga.transaction (
    cust_id integer not null,
    transaction_dt timestamp without time zone not null,
    currency_id character varying (3) not null,
    transaction_amt numeric not null
);

insert into liga.transaction 
values (
1,
'01.01.2021',
'RUR',
1000
),
(
1,
'02.01.2021',
'EUR',
100
),
(
1,
'03.01.2021',
'EUR',
100
),
(
1,
'04.01.2021',
'USD',
50
),
(
2,
'01.01.2021',
'USD',
150
),
(
2,
'02.01.2021',
'USD',
200
),
(
2,
'04.01.2021',
'USD',
50
),
(
3,
'01.01.2021',
'RUR',
2000
),
(
3,
'04.01.2021',
'RUR',
5000
);

create table liga.currency_rate (
    currency_id character varying (3) not null,
    exch_rate numeric not null,
    valid_from timestamp without time zone not null,
    valid_to timestamp without time zone not null
);

insert into liga.currency_rate 
values (
'RUR',
1,
'01.01.1900',
'01.01.4000'
),
(
'EUR',
90,
'01.01.2021',
'03.01.2021'
),
(
'EUR',
95,
'03.01.2021',
'01.01.4000'
),
(
'USD',
70,
'01.01.2021',
'02.01.2021'
),
(
'USD',
75,
'02.01.2021',
'04.01.2021'
),
(
'USD',
70,
'04.01.2021',
'01.01.4000'
);

comment on table liga.currency_rate is 'курсы валют';
comment on table liga.customer is 'клиенты';
comment on table liga.customer_contact is 'контакты клиентов';
comment on table liga.transaction is 'транзакции клиентов';