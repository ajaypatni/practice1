create proc dim_date_proc as
declare @a date=(select GETDATE())
declare @b int=0
while @b<25*365
begin
set @a=dateadd(day,1,@a)
insert into dim_date values(@a,datename(month,@a),DATEPART(YEAR,@a),DATEPART(MONTH,@a),datename(weekday,@a),DATEPART(QUARTER,@a),DATEPART(DAYOFYEAR,@a))
set @b=@b+1
end
select * from dim_date