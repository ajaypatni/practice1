--put @g=1 during insertion --
--put @g=0 during updating --
 
CREATE procedure scd___2 
as
declare @d int
declare @e int
set @e=(select count(*) from Package)
set @d=(select count(*) from(select count(*) b from Package1 group by id) v)
if @d!=@e
begin
merge Package1 as e
using Package as d on e.id=d.id and e.Salary=d.Salary
when not matched by target then 
insert (id,Salary,start_date,flag) values(d.id,d.salary,getdate(),'y');
end
else
begin
merge Package1 as e
using Package as d on e.id=d.id and e.Salary=d.Salary
when not matched by target then 
insert (id,Salary,start_date,flag) values(d.id,d.salary,getdate(),'y');

declare @b int
set @b=(select id from(select * from Package1 except 
select top ((select count(*) from Package1)-1) * from Package1)v)
print @b

declare @a int
set @a=(select Salary from(select * from Package1 except 
select top ((select count(*) from Package1)-1) * from Package1)v)
print @a
update Package1 set end_date=(SELECT DATEADD(day, -1, getdate())),flag='0' where  id=@b and not Salary=@a
end