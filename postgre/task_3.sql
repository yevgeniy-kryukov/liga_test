create or replace view liga.task_3 as
select cust.cust_id, cust.fullname, sum(coalesce(tra.transaction_amt, 0) * coalesce(curr.exch_rate, 0)) as summa
from liga.customer cust
left join liga.transaction tra on tra.cust_id = cust.cust_id 
left join liga.currency_rate curr on curr.currency_id = tra.currency_id
where localtimestamp >= cust.valid_from and localtimestamp < cust.valid_to
  and tra.transaction_dt >= curr.valid_from and tra.transaction_dt < curr.valid_to
  and to_char(tra.transaction_dt, 'mm.yyyy') = '01.2021'            -- за выбранный месяц
--tra.transaction_dt >= (localtimestamp - interval '1' month)   -- за последний месяц
  and tra.currency_id = 'RUR'
group by cust.cust_id, cust.fullname
order by cust.fullname;

comment on view liga.task_3 is 'Посчитать сумму транзакций клиента в рублях за месяц';