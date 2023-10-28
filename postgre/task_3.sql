create or replace view liga.task_3 as 
select tx.cust_id,
    tx.tra_month,
    sum(tx.tra_summa) as summa
from (
    select cust.cust_id,
        to_char(tra.transaction_dt, 'yyyy-mm') as tra_month,
        tra.transaction_amt * curr.exch_rate as tra_summa
    from liga.customer cust
        left join liga.transaction tra on tra.cust_id = cust.cust_id
        left join liga.currency_rate curr on curr.currency_id::text = tra.currency_id::text
    where localtimestamp >= cust.valid_from and localtimestamp < cust.valid_to 
        and tra.transaction_dt >= curr.valid_from and tra.transaction_dt < curr.valid_to 
) tx
group by tx.cust_id, 
        tx.tra_month
order by tx.cust_id,
         tx.tra_month;

comment on view liga.task_3 is 'Посчитать сумму транзакций клиента в рублях за месяц';