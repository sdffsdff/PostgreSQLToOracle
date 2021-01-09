drop type if exists t_region_type;
create type t_region_type as (id integer, name varchar, pid integer);

do $$
declare
  t_reg_tab t_region_type[];
  i t_region_type;
begin
    with t_tab as (select 1 as id, 'Россия' as name, null as pid
					union all
					select 2, 'Москва', 1
					union all
					select 3, 'Санкт-Петербург', 1
					union all
					select 4, 'Краснодарский край', 1
					union all
					select 5, 'Краснодар', 4
					union all
					select 6, 'Воронежская область', 1
					union all
					select 7, 'Воронеж', 6
					union all
					select 8, 'Лиски', 6
					union all
					select 9, 'Сочи', 4
					union all
					select 10, 'Алтайский край', 1
					union all
					select 11, 'Барнаул', 10 
					)
	 select array_agg(t.*)
	  into t_reg_tab
		  from t_tab t;

	foreach i in array t_reg_tab loop
	  raise notice '%', i.name;
	end loop;      

end;
$$;
