-- FUNCTION: liga.task1()

CREATE OR REPLACE FUNCTION liga.task_1(
	)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
begin
    ALTER TABLE liga.customer  SET (autovacuum_enabled = off);
    --v1
    delete 
    from liga.customer tx1
    where tx1.ctid not in ( select min(ctid)
                            from liga.customer 
                            group by cust_id, fullname, sex, birth_dt, valid_from, valid_to);
    --v2
--     delete 
--     from liga.customer tx1
--     where tx1.ctid > (
--         select min(ctid)
--         from liga.customer 
--         where cust_id = tx1.cust_id 
--                and fullname = tx1.fullname 
--                and sex = tx1.sex 
--                and birth_dt = tx1.birth_dt 
--                and valid_from = tx1.valid_from 
--                and valid_to = tx1.valid_to
--     );
--     --v3
--     delete 
--     from liga.customer tx1
--     where ctid in (
--         select tx.ctid
--         from (
--             select ctid, row_number() over (partition by cust_id, fullname, sex, birth_dt, valid_from, valid_to order by ctid) as pos 
--             from liga.customer 
--         ) tx
--         where tx.pos > 1
--     );    
--     ALTER TABLE liga.customer SET (autovacuum_enabled = on);
end;
$BODY$;

ALTER FUNCTION liga.task_1()
    OWNER TO postgres;

COMMENT ON FUNCTION liga.task_1()
    IS 'Как удалить полные дубли строк';
