rollback;
//1

insert into employe values (99,'Bob',35,3);

select * from employe;
commit;


//2
delete from employe where nuempl=99;
select * from employe;

commit;

//3
insert into employe values (99,'Bob',35,3);
select * from employe;
commit;

//4
update employe set hebdo=10 where nuempl=99;

commit;
select * from employe;

//5
update employe set hebdo=10 where nuempl=99;

select * from employe;

//6
insert into travail values (99,135,5);

//7
update employe set nomempl="Dupond" where nuempl=101;

//8
select * from employe where nuempl=100 for update;

update employe set nomempl='Martin' where nuempl=100;
commit;

//9
select * from employe where nuempl=101 for update;

update employe set nomempl='Marcel' where nuempl=101;

commit;

//10
insert into employe values(100,'Martin',22,3);

commit;

//11
insert into travail values(100,3,23);

//select * from travail;
