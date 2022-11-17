REM   Script: task_3
REM   task_3

create or replace view task_3 as
select cust.cust_id, cust.fullname, sum(coalesce(tra.transaction_amt, 0) * coalesce(curr.exch_rate, 0)) as summa
from customer cust
left join transaction tra on tra.cust_id = cust.cust_id 
left join currency_rate curr on curr.currency_id = tra.currency_id
where sysdate >= cust.valid_from and sysdate < cust.valid_to
  and tra.transaction_dt >= curr.valid_from and tra.transaction_dt < curr.valid_to
  and to_char(tra.transaction_dt, 'mm.yyyy') = '01.2021'            -- за выбранный месяц
--tra.transaction_dt >= (sysdate - interval '1' month)   -- за последний месяц
  and tra.currency_id = 'RUR'
group by cust.cust_id, cust.fullname
order by cust.fullname;

comment on table task_3 is 'Посчитать сумму транзакций клиента в рублях за месяц';

