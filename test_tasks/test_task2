create or replace type t_region_type is object (id integer, name varchar2(32000), pid integer);
create or replace type t_region_tab is table of t_region_type;
  
create or replace procedure MAIN_INS (pTab t_region_tab, pReg_name varchar2) is  
   my_code NUMBER;
   my_errm VARCHAR2(32000);
   my_path VARCHAR2(100);
  begin

    select ltrim(SYS_CONNECT_BY_PATH(name,'/'), '/') 
      into my_path
      from table(pTab) t
     where upper(t.name) = upper(pReg_name)
      start with pid is null
      connect by prior id = pid;
      
   dbms_output.put_line(my_path);    
                
exception 
   when others then
     my_code := SQLCODE;
     my_errm := SQLERRM;
     dbms_output.put_line('Ошибка');    
end;

-- вызов
declare
 t_reg_tab t_region_tab:= t_region_tab();
begin
  
 t_reg_tab.extend(6);
 t_reg_tab(1):= t_region_type(1, 'Россия', null);
 t_reg_tab(2):= t_region_type(2, 'Москва', 1);
 t_reg_tab(3):= t_region_type(3, 'Санкт-Петербург', 1);
 t_reg_tab(4):= t_region_type(4, 'Краснодарский край', 1);
 t_reg_tab(5):= t_region_type(5, 'Краснодар', 4);
 t_reg_tab(6):= t_region_type(6, 'Воронежская область', 1);

 MAIN_INS(t_reg_tab, 'Краснодар');
 MAIN_INS(t_reg_tab, 'Стамбул');
end;
