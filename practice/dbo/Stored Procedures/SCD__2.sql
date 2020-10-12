create proc SCD__2 as
merge Pack1 as e
using Packages as d on e.id=d.ID and e.Salary=d.Salary
when not matched by target then 
insert(id,Salary,flag) values(d.ID,d.Salary,'y')
when not matched by source then 
delete;

declare @a numeric(5,4)
set @a=(select Salary from(select * from Packages except 
select top ((select count(*) from Packages)-1) * from Packages)v)
print @a

declare @b int
set @b=(select ID from(select * from Packages except 
select top ((select count(*) from Packages)-1) * from Packages)v)
print @b
update Pack1 set flag='O' where  id=@b and not Salary=@a
select * from Pack1