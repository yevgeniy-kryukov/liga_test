REM   Script: task_1
REM   task_1

CREATE OR REPLACE PROCEDURE task_1 AS
begin
   --Как удалить полные дубли строк

    --v1
    delete 
    from customer tx1
    where tx1.rowid not in ( select min(rowid)
                                           from customer 
                                           group by cust_id, fullname, sex, birth_dt, valid_from, valid_to);
    --v2
--     delete 
--     from customer tx1
--     where tx1.rowid > (
--         select min(rowid)
--         from customer 
--         where cust_id = tx1.cust_id 
--                and fullname = tx1.fullname 
--                and sex = tx1.sex 
--                and birth_dt = tx1.birth_dt 
--                and valid_from = tx1.valid_from 
--                and valid_to = tx1.valid_to
--     );
--     --v3
--     delete 
--     from customer tx1
--     where rowid in (
--         select tx.rowid
--         from (
--             select rowid, row_number() over (partition by cust_id, fullname, sex, birth_dt, valid_from, valid_to order by rowid) as pos 
--             from customer 
--         ) tx
--         where tx.pos > 1
--     );    
	commit;
end;
/
/

