drop table if exists main;
create table main (t1 int);
drop index if exists main_idx;
create unique index main_idx on main (t1);
drop table if exists mainlog;
create table mainlog (logdata varchar);

CREATE EXTENSION dblink;

CREATE OR REPLACE PROCEDURE MAIN_INS(pT1 integer)
LANGUAGE plpgsql
AS $$
declare
  my_state varchar;
  my_errm varchar;
begin
  insert into main (t1) values (pT1);
  perform main_log ('Insert Ok');
exception 
  when others then
    my_state := SQLSTATE;
    my_errm := SQLERRM;
    perform main_log(pResult=>'Insert exception, error code='||my_state||' time:'||to_char(now(),'YYYY-MM-DD hh:mi')||' ,errmsg: '||substr(my_errm,0,50));
end;  
$$;

CREATE OR REPLACE FUNCTION main_log(presult varchar)
    RETURNS void
    LANGUAGE 'sql'
AS $BODY$
	select dblink('dbname=mytest', format('insert into mainlog select %L', pResult));
$BODY$;

do $$
begin
	call MAIN_INS(1);
	call MAIN_INS(1);
	commit;
end;
$$;
