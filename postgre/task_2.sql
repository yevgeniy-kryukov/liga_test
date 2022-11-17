create or replace view liga.task_2 as
with cont as (
    select cust_id, value, type
    from liga.customer_contact 
    where localtimestamp >= valid_from and localtimestamp < valid_to
)
select cust.fullname, cont_1.value as phone, cont_2.value as email, cont_3.value as address
from liga.customer cust
left join cont cont_1 on cont_1.cust_id = cust.cust_id and cont_1.type = 'PHONE'
left join cont cont_2 on cont_2.cust_id = cust.cust_id and cont_2.type = 'EMAIL'
left join cont cont_3 on cont_3.cust_id = cust.cust_id and cont_3.type = 'ADDRESS'
where localtimestamp >= cust.valid_from and localtimestamp < cust.valid_to
order by fullname;

comment on view liga.task_2 is 'Выбрать ФИО клиента + телефон + емейл + адрес';
