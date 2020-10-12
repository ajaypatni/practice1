CREATE proc SCDT2
as
merge Package1 as t
using Package as s
on s.id=t.id and s.Salary=t.Salary
when not matched  by target then
insert (id,Salary,start_date,flag) values(s.id,s.Salary,getdate(),'N');
update  Package1 set flag='0'  where CONCAT(CONVERT(varchar,id),' ',CONVERT(varchar,Salary)) in 
(select CONCAT(CONVERT(varchar,id),' ',CONVERT(varchar,Salary))from(select id ,Salary from Package1 except select id,Salary from Package)v)
update Package1 set end_date=GETDATE() where flag ='0'and end_date is Null
select * from Package1