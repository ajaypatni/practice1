create  proc Dim_time as
declare @hour int=0
declare @h varchar(30)
declare @m varchar(30)
declare @s varchar(30)
declare @min int
declare @i int=0
declare @sec int
while @hour<24
begin
if @hour<10
begin
set @h='0'+convert(varchar,@hour)
end
else
begin
set @h=convert(varchar,@hour)
end
set @min=0
while @min<60
begin
if @min<10
begin
set @m='0'+convert(varchar,@min)
end
else
begin
set @m=convert(varchar,@min)
end
set @sec=0
while @sec<60
begin
if @sec<10
begin
set @s='0'+convert(varchar,@sec)
end
else
begin
set @s=convert(varchar,@sec)
end
if @hour<12
begin
insert into DimTime values( @i, @h+':'+@m+':'+@s,convert(varchar,@hour),convert(varchar,@min),convert(varchar,@sec),@i,convert(varchar,@hour)+'  '+'AM',@h+':'+@m)
end
if @hour=12
begin

insert into DimTime values( @i, @h+':'+@m+':'+@s,convert(varchar,@hour),convert(varchar,@min),convert(varchar,@sec),@i,convert(varchar,@hour)+'  '+'Noon',@h+':'+@m)

end

if @hour>12
begin
insert into DimTime values( @i, @h+':'+@m+':'+@s,convert(varchar,@hour),convert(varchar,@min),convert(varchar,@sec),@i,convert(varchar,@hour)+'  '+'PM',@h+':'+@m)
end
set @i=@i+1
set @sec=@sec+1
end
set @min=@min+1
end
set @hour=@hour+1
end