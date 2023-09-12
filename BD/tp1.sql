
//select * from basetd.employe

exec dbms_stats.gather_table_stats( 'S5A08B', 'BASETD.EMPLOYE')


//exec dbms_stats.gather_table_stats('{basetd.EMPLOYE}','EMPLOYE’ method_opt=>'FOR COLUMNS HEBDO');


SELECT e.nuempl, t.duree FROM basetd.Employe e JOIN basetd.Travail t ON e.nuempl = t.nuempl
WHERE t.nuproj = 3;

SELECT * FROM table (dbms_xplan.display_cursor);

select sql_id, child_number, sql_text from v$sql where sql_text 
not like '%v$sql%' and parsing_schema_name like 'S5A08B';


SELECT * FROM table (dbms_xplan.display_cursor);

SELECT * FROM table(dbms_xplan.display_cursor('f52w2vurfvr3w', 0,
format=>'all'));


alter system flush shared_pool;
select t.plan_table_output from v$sql s,
table(dbms_xplan.display_cursor(s.sql_id,s.child_number,'all')) t
where s.sql_text like '%find me%' and s.sql_text not like '%v$sql%'
and s.parsing_schema_name like 'S5A08B';

//explain plan set statement_id = 'ex_plan1' for {requete-select-from-where};

alter system flush shared_pool;
alter system flush buffer_cache;



select * from basetd.distribution;

create table Distribution as select * from basetd.distribution;
create table Operateur as select * from basetd.operateur;
create table Commune as select * from basetd.commune;

CREATE INDEX INDX_NUMFO ON distribution(numfo);

INDEX RANGE SCAN;