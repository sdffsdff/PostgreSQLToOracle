drop type if exists t_region_type;
create type t_region_type as (id integer, name varchar, pid integer);

CREATE OR REPLACE PROCEDURE MAIN_INS (pTab t_region_type[], pReg_name varchar)
LANGUAGE plpgsql
AS $$
declare
   my_state VARCHAR;
   my_errm VARCHAR;
   my_path VARCHAR;
begin

	with recursive tree as (
	  select name as names, pid
		from unnest(pTab)
	   where upper(name) = upper(pReg_name) 
	   union all
	  select p.name || ',' || names, p.pid
	    from unnest(pTab) as p,
		     tree t
      where p.id = t.pid
	)
	select names
	  into my_path
	  from tree
	 where pid is null;
      
   RAISE NOTICE '%', my_path;   
exception 
   when others then
     my_state := SQLSTATE;
     my_errm := SQLERRM;
     RAISE NOTICE '%', my_errm;  
end;  
$$;

-- вызов
do $$
declare
 t_reg_tab t_region_type[];
begin
  
 t_reg_tab[1]:= row(1, 'Россия', null);
 t_reg_tab[2]:= row(2, 'Москва', 1);
 t_reg_tab[3]:= row(3, 'Санкт-Петербург', 1);
 t_reg_tab[4]:= row(4, 'Краснодарский край', 1);
 t_reg_tab[5]:= row(5, 'Краснодар', 4);
 t_reg_tab[6]:= row(6, 'Воронежская область', 1);

 call MAIN_INS(t_reg_tab, 'Краснодар');
 call MAIN_INS(t_reg_tab, 'Стамбул');
end;
$$;
