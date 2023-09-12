
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

explain plan set statement_id = 'ex_plan1' for requete-select-from-where;

select * from table(dbms_xplan.display(statement_id=>'ex_plan1', format=>'all'));





alter system flush shared_pool;
alter system flush buffer_cache;



select * from basetd.distribution;

create table Distribution as select * from basetd.distribution;
create table Operateur as select * from basetd.operateur;
create table Commune as select * from basetd.commune;

CREATE INDEX INDX_NUMFO ON distribution(numfo);

INDEX RANGE SCAN;












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