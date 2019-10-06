--Insert
insert into regions values (10,'Great Britain');
insert into regions (region_name, region_id) values ('Australasia',11);
insert into regions (region_id) values (12);
insert into regions values (13,null);
insert into (select region_id from regions where region_id = 1) values (14);


--Update
update employees
set last_name = 'Jobs' where first_name = 'Steven'


update (select first_name, last_name from employees)
set first_name = 'DIN' where last_name = 'OCONNELL'


update regions set (region_name, region_id) = (select 'Australasia',11 from dual)
where region_id = 11;


--Delete
delete job_history;


delete from (select * from job_history);