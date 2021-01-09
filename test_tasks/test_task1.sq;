create table main (t1 int);
create unique index main_idx on main (t1);
create table mainlog (logdata  varchar2(512));

create or replace procedure MAIN_LOG (pResult in varchar2)
is
pragma autonomous_transaction;
begin
  insert into mainlog (logdata) values (pResult);
  commit;
end;
  
create or replace procedure MAIN_INS (pT1 in int)
is  
  my_code NUMBER;
  my_errm VARCHAR2(32000);
begin
  insert into main (t1) values (pT1);
  main_log ('Insert Ok');
exception 
  when others then
    my_code := SQLCODE;
    my_errm := SQLERRM;
    MAIN_LOG(pResult=>'Insert exception, error code='||SQLCODE||' time:'||to_char(sysdate,'YYYY-MM-DD hh:mi')||' ,errmsg: '||substr(SQLERRM,0,50));
end;

begin
  MAIN_INS(1);
  MAIN_INS(1);
  commit;
end;
