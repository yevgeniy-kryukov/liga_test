# **Разработчик**

Разработчик
 1. Как удалить полные дубли строк?
 2. Выбрать ФИО клиента + телефон + емейл + адрес
 3. Посчитать сумму транзакций клиента в рублях за месяц
 4. Выбрать все изменения контактных телефонов за месяц

**Модель данных:**

Таблица CUSTOMER - клиенты

| **CUST\_ID** | **FULLNAME** | **SEX** | **BIRTH\_DT** | **VALID\_FROM** | **VALID\_TO** |
| --- | --- | --- | --- | --- | --- |
| 1 | Иванова | Ж | 01.01.1960 | 01.01.1900 | 01.01.2021 |
| 1 | Петрова | Ж | 01.01.1960 | 01.01.2021 | 01.01.4000 |
| 2 | Петров | М | 01.01.1955 | 01.01.1900 | 01.01.4000 |
| 3 | Сидоров | М | 01.01.1980 | 01.01.1900 | 01.01.4000 |
| ... | ... | ... | ... | ... | ... |

Таблица CUSTOMER\_CONTACT - контакты клиентов

| **CUST\_ID** | **TYPE** | **VALUE** | **VALID\_FROM** | **VALID\_TO** |
| --- | --- | --- | --- | --- |
| 1 | EMAIL | ivanova@[mail.ru](http://mail.ru/) | 01.01.1900 | 01.01.4000 |
| 1 | PHONE | +7 965 123 45 67 | 01.01.1900 | 01.01.4000 |
| 1 | ADDRESS | г. Саратов, улица Ленина, дом 8 | 01.01.1900 | 01.01.2021 |
| 1 | ADDRESS | г. Москва, улица Ленина, дом 10 | 01.01.2021 | 01.01.4000 |
| 2 | EMAIL | petrov@mail.ru | 01.01.1900 | 01.01.4000 |
| 2 | ADDRESS | г. Москва, улица Ленина, дом 10 | 01.01.1900 | 01.01.4000 |
| 3 | EMAIL | sidorov@[mail.ru](http://mail.ru/) | 01.01.1900 | 01.01.4000 |
| 3 | PHONE | + 7 965 678 12 34 | 01.01.1900 | 01.01.4000 |
| 3 | ADDRESS | г. Саратов, улица Ленина, дом 9 | 01.01.1900 | 01.01.4000 |
| ... | ... | ... | ... | ... |

Таблица TRANSACTION - транзакции клиентов

| **CUST\_ID** | **TRANSACTION\_DT** | **CURRENCY\_ID** | **TRANSACTION\_AMT** |
| --- | --- | --- | --- |
| 1 | 01.01.2021 | RUR | 1000 |
| 1 | 02.01.2021 | EUR | 100 |
| 1 | 03.01.2021 | EUR | 100 |
| 1 | 04.01.2021 | USD | 50 |
| 2 | 01.01.2021 | USD | 150 |
| 2 | 02.01.2021 | USD | 200 |
| 2 | 04.01.2021 | USD | 50 |
| 3 | 01.01.2021 | RUR | 2000 |
| 3 | 04.01.2021 | RUR | 5000 |
| ... | ... | ... | ... |

Таблица CURRENCY\_RATE - курсы валют

| **CURRENCY\_ID** | **EXCH\_RATE** | **VALID\_FROM** | **VALID\_TO** |
| --- | --- | --- | --- |
| RUR | 1 | 01.01.1900 | 01.01.4000 |
| EUR | 90 | 01.01.2021 | 03.01.2021 |
| EUR | 95 | 03.01.2021 | 01.01.4000 |
| USD | 70 | 01.01.2021 | 02.01.2021 |
| USD | 75 | 02.01.2021 | 04.01.2021 |
| USD | 70 | 04.01.2021 | 01.01.4000 |
| ... | ... | ... | ... |
<<<<<<< HEAD
=======

Для Oracle заменить ctid на rowid, localtimestamp на sysdate, limit 1 на доп. условие rownum = 1

1. Как удалить полные дубли строк?
 --v1

delete

from liga.customer tx1

where tx1.ctid not in ( select min(ctid)

from liga.customer

group by cust\_id, fullname, sex, birth\_dt, valid\_from, valid\_to);

–v2

delete

from liga.customer tx1

where tx1.ctid \> (

select min(ctid)

from liga.customer

where cust\_id = tx1.cust\_id

and fullname = tx1.fullname

and sex = tx1.sex

and birth\_dt = tx1.birth\_dt

and valid\_from = tx1.valid\_from

and valid\_to = tx1.valid\_to

);

--v3

delete

from liga.customer tx1

where ctid in (

select tx.ctid

from (

select ctid, row\_number() over (partition by cust\_id, fullname, sex, birth\_dt, valid\_from, valid\_to order by ctid) as pos

from liga.customer

) tx

where tx.pos \> 1

);

2. Выбрать ФИО клиента + телефон + емейл + адрес

with cont as (

select cust\_id, value, type

from liga.customer\_contact

where localtimestamp \>= valid\_from and localtimestamp \< valid\_to

)

select cust.fullname, cont\_1.value as phone, cont\_2.value as email, cont\_3.value as address

from liga.customer cust

left join cont cont\_1 on cont\_1.cust\_id = cust.cust\_id and cont\_1.type = 'PHONE'

left join cont cont\_2 on cont\_2.cust\_id = cust.cust\_id and cont\_2.type = 'EMAIL'

left join cont cont\_3 on cont\_3.cust\_id = cust.cust\_id and cont\_3.type = 'ADDRESS'

where localtimestamp \>= cust.valid\_from and localtimestamp \< cust.valid\_to

order by fullname;

3. Посчитать сумму транзакций клиента в рублях за месяц

select cust.cust\_id, cust.fullname, sum(coalesce(tra.transaction\_amt, 0) \* coalesce(curr.exch\_rate, 0)) as summa

from liga.customer cust

left join liga.transaction tra on tra.cust\_id = cust.cust\_id

left join liga.currency\_rate curr on curr.currency\_id = tra.currency\_id

where localtimestamp \>= cust.valid\_from and localtimestamp \< cust.valid\_to

and tra.transaction\_dt \>= curr.valid\_from and tra.transaction\_dt \< curr.valid\_to

and to\_char(tra.transaction\_dt, 'mm.yyyy') = '01.2021' -- за выбранный месяц

--tra.transaction\_dt \>= (localtimestamp - interval '1' month) -- за последний месяц

and tra.currency\_id = 'RUR'

group by cust.cust\_id, cust.fullname

order by cust.fullname;

4. Выбрать все изменения контактных телефонов за месяц

select cont1.\*

from liga.customer\_contact cont1

where to\_char(cont1.valid\_from, 'mm.yyyy') = '01.2021' -- за выбранный месяц

--cont1.valid\_from \>= (localtimestamp - interval '1' month) -- за последний месяц

and cont1.type = 'PHONE'

and exists (select 1

from liga.customer\_contact cont2

where cont2.cust\_id = cont1.cust\_id and cont2.type = cont1.type and cont2.valid\_from \< cont1.valid\_from

limit 1); -- есть предыдущие записи по клиенту
>>>>>>> 3fd6ae75c1094240e54fff2ee53ba340244cb90e
