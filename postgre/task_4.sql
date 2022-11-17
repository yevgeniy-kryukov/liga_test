create or replace view liga.task_4 as
select cont1.*
from liga.customer_contact cont1
where to_char(cont1.valid_from, 'mm.yyyy') = '01.2021'            -- за выбранный месяц 
  --cont1.valid_from >= (localtimestamp - interval '1' month) -- за последний месяц
  and cont1.type = 'PHONE'
  and exists (select 1 
              from liga.customer_contact cont2 
              where cont2.cust_id = cont1.cust_id and cont2.type = cont1.type and cont2.valid_from < cont1.valid_from
              limit 1); -- есть предыдущие записи по клиенту
              
comment on view liga.task_4 is 'Выбрать все изменения контактных телефонов за месяц';