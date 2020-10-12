
create proc insert_in_emp @name1 varchar(20),@dept1 varchar(30),@location1 varchar(50),@Salary1 int
as 
insert into emp values(@name1,@dept1,@location1,@Salary1)