create proc new_data as 
merge emp1 as e
using emp as d on e.name=d.name
when matched  then
update set e.dept=d.dept,e.location=d.location,e.Salary=d.Salary
when not matched by target then 
insert(name,dept,location,Salary) values(d.name,d.dept,d.location,d.Salary)
when not matched by source then 
delete; 
select * from emp1