create proc SCD_TYPE_2 as 
merge s2 as t
using s1 as s
on s.name=t.name and s.dept=t.dept
when matched then
update set t.flag='O'
when not matched by target then
insert(name,dept,flag) values(s.name,s.dept,'N')
when not matched by source then
delete;
select * from s2