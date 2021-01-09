create or replace type t_region_type is object (id integer, name varchar2(32000), pid integer);
create or replace type t_region_tab is table of t_region_type;

declare
 t_reg_tab t_region_tab:= t_region_tab();
begin
 
 with t_tab as (select 1 as id, 'Россия' as name, null as pid from dual
                union all
                select 2, 'Москва', 1 from dual
                union all
                select 3, 'Санкт-Петербург', 1 from dual
                union all
                select 4, 'Краснодарский край', 1 from dual
                union all
                select 5, 'Краснодар', 4 from dual
                union all
                select 6, 'Воронежская область', 1 from dual
                union all
                select 7, 'Воронеж', 6 from dual
                union all
                select 8, 'Лиски', 6 from dual
                union all
                select 9, 'Сочи', 4 from dual
                union all
                select 10, 'Алтайский край', 1 from dual
                union all
                select 11, 'Барнаул', 10 from dual
                )
    select t_region_type(id, name, pid)
      bulk collect into t_reg_tab
      from t_tab;
      
for i in 1..t_reg_tab.count loop
  dbms_output.put_line(t_reg_tab(i).name); 
end loop;      

end;
