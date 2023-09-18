
//Ex4

exec dbms_stats.gather_table_stats( 'S5A08B', 'EMPLOYE');

exec dbms_stats.gather_table_stats('S5A08B','EMPLOYE', method_opt=>'FOR COLUMNS HEBDO');

select * from user_tab_statistics;
select * from user_tab_col_statistics;
select * from user_tab_histograms;

select ENDPOINT_NUMBER , ENDPOINT_VALUE
from user_tab_histograms where table_name='EMPLOYE' and column_name='HEBDO' ;

select column_name, num_distinct, num_buckets, histogram
from user_tab_col_statistics where table_name = 'EMPLOYE' AND column_name = 'HEBDO';

SELECT e.nuempl, t.duree FROM Employe e JOIN Travail t ON e.nuempl = t.nuempl
WHERE t.nuproj = 3;

SELECT * FROM table (dbms_xplan.display_cursor);

alter system flush shared_pool;
alter system flush buffer_cache;

select sql_id, child_number, sql_text from v$sql where sql_text 
not like '%v$sql%' and parsing_schema_name like 'S5A08B';


SELECT * FROM table (dbms_xplan.display_cursor);

SELECT * FROM table(dbms_xplan.display_cursor('f52w2vurfvr3w', 0,
format=>'all'));


alter system flush shared_pool;
select t.plan_table_output from v$sql s,
table(dbms_xplan.display_cursor(s.sql_id,s.child_number,'all')) t
where s.sql_text like 'duree' and s.sql_text not like '%v$sql%'
and s.parsing_schema_name like 'S5A08B';

//explain plan set statement_id = 'ex_plan1' for requete-select-from-where;

select * from table(dbms_xplan.display(statement_id=>'ex_plan1', format=>'all'));







//Ex6
select * from distribution;

create table Distribution as select * from basetd.distribution;
create table Operateur as select * from basetd.operateur;
create table Commune as select * from basetd.commune;

CREATE INDEX INDX_NUMFO ON distribution(numfo);
 
 



//Ex7

Create or replace procedure distribution_static(stat in varchar2 default NULL) as
cursor ma_requete is select id from distribution where statut=stat or statut is null;
id number(10);
cursor plan is select plan_table_output from table(dbms_xplan.display_cursor);
v_plan_table_output varchar2(1000);
begin
dbms_output.enable(1000000);
open ma_requete;
loop
fetch ma_requete into id;
exit when ma_requete%notfound;
dbms_output.put_line(id);
end loop;
close ma_requete;

dbms_output.put_line(
chr(10)||'Résultat de la requête suivante :'||
chr(10)||
chr(10)||'select id from distribution where'||
chr(10)||'(statut=stat;');
dbms_output.put_line(chr(10));
dbms_output.put_line('Plan Execution:'||chr(10));
open plan;
loop
fetch plan into v_plan_table_output;
exit when plan%notfound;
dbms_output.put_line(v_plan_table_output);
end loop;
close plan;
end;
/


Create or replace procedure distribution_dynamique(statut in varchar2 default NULL,code in number default NULL) as

TYPE cursor_type IS REF CURSOR;
c_cursor cursor_type;

ma_requete varchar2(300);
v_id number;
v_statut varchar2(60);
v_plan_table_output varchar2(200);
cursor plan is select plan_table_output from table(dbms_xplan.display_cursor);

begin

dbms_output.enable(1000000);

ma_requete:='select id from distribution where 1 = 1';

if statut is not null then ma_requete:=ma_requete||' and statut=:statut';end if;

if code is not null then ma_requete:=ma_requete||' and ADR_NM_CP=:code';
end if;

if statut is null and code is null then
open c_cursor for ma_requete;
end if;

if statut is not null and code is null then
open c_cursor for ma_requete using statut;
end if;

if statut is null and code is not null then
open c_cursor for ma_requete using code;
end if;

if statut is not null and code is not null then
open c_cursor for ma_requete using statut,code;
end if;

loop
fetch c_cursor into v_id;
exit when c_cursor%notfound;
dbms_output.put_line(v_id);
end loop;
close c_cursor;
dbms_output.put_line(
chr(10)||'Résultat de ma requête:'||
chr(10)||
chr(10)||ma_requete);

dbms_output.put_line(chr(10)||' Plan :'||chr(10));
open plan;
loop
fetch plan into v_plan_table_output;
exit when plan%notfound;
dbms_output.put_line(v_plan_table_output);
end loop;
close plan;
end;
/

select * from basetd.distribution;
exec distribution_dynamique('En service',2);


//Ex8








/*
CREATE TABLE EMPLOYE(
NUEMPL NUMBER(4, 0) NOT NULL, NOMEMPL VARCHAR2(20) NOT NULL, HEBDO NUMBER(2, 0) NOT NULL, AFFECT NUMBER(2, 0) NOT NULL

);

CREATE TABLE PROJET(
NUPROJ NUMBER(3, 0) NOT NULL, NOMPROJ CHAR(5) NOT NULL, RESP NUMBER(4, 0) NOT NULL
);

CREATE TABLE SERVICE(
NUSERV NUMBER(2, 0) NOT NULL, NOMSERV VARCHAR2(10) NOT NULL, CHEF NUMBER(4, 0) NOT NULL
);

CREATE TABLE TRAVAIL(
NUEMPL NUMBER(4, 0) NOT NULL, 
NUPROJ NUMBER(3, 0) NOT NULL,
DUREE NUMBER(2, 0), 
CONSTRAINT pk_TRAVAIL PRIMARY KEY(NUEMPL,NUPROJ)
);

CREATE TABLE CONCERNE(
NUSERV NUMBER(2, 0) NOT NULL, NUPROJ NUMBER(3, 0) NOT NULL);



alter table employe add constraint pk_empl primary key (nuempl);
alter table service add constraint pk_serv primary key (nuserv);
alter table projet add constraint pk_proj primary key (nuproj);
alter table concerne add constraint pk_co primary key (nuproj,nuserv);

alter table travail add constraint fk_empl foreign key (nuempl) references employe (nuempl);
alter table travail add constraint fk_projet foreign key (nuproj) references projet (nuproj);
---------------------------------------------------

Insert into EMPLOYE (NUEMPL,NOMEMPL,HEBDO,AFFECT) values (20,'marcel',35,3);
Insert into EMPLOYE (NUEMPL,NOMEMPL,HEBDO,AFFECT) values (30,'robert',35,5);

Insert into PROJET (NUPROJ,NOMPROJ,RESP) values (3,'cobra',30); 
Insert into PROJET (NUPROJ,NOMPROJ,RESP) values (5,'zorro',30);

Insert into SERVICE (NUSERV,NOMSERV,CHEF) values (1,'achat',30); 
Insert into SERVICE (NUSERV,NOMSERV,CHEF) values (2,'vente',30);

Insert into TRAVAIL (NUEMPL,NUPROJ,DUREE) values (20,3,10); 
Insert into TRAVAIL (NUEMPL,NUPROJ,DUREE) values (30,5,15);

Insert into CONCERNE (NUSERV,NUPROJ) values (1,3); 
Insert into CONCERNE (NUSERV,NUPROJ) values (2,5);
commit;
*/