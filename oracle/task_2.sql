REM   Script: task_2
REM   task_2

create or replace view task_2 as
with cont as (
    select cust_id, value, type
    from customer_contact 
    where sysdate >= valid_from and sysdate < valid_to
)
select cust.fullname, cont_1.value as phone, cont_2.value as email, cont_3.value as address
from customer cust
left join cont cont_1 on cont_1.cust_id = cust.cust_id and cont_1.type = 'PHONE'
left join cont cont_2 on cont_2.cust_id = cust.cust_id and cont_2.type = 'EMAIL'
left join cont cont_3 on cont_3.cust_id = cust.cust_id and cont_3.type = 'ADDRESS'
where sysdate >= cust.valid_from and sysdate < cust.valid_to
order by fullname;

comment on table task_2 is 'Выбрать ФИО клиента + телефон + емейл + адрес';

