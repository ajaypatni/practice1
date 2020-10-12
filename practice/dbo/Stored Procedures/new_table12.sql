CREATE proc new_table12 @table nvarchar(1000),@col nvarchar(1000),@col_data_type nvarchar(1000)='int',
@primary_key nvarchar(max)='',@cli nvarchar(170)='',@ncli nvarchar(170)=''
as
if @table not in(Select TABLE_NAME from INFORMATION_SCHEMA.TABLES)
begin 
declare @sql nvarchar(max)='create table '+@table+'( '+@col +' )'

declare @sql1 nvarchar(max)='alter table '+@table+' add primary key '+'( '+@primary_key+' )'
declare @sql2 nvarchar(max)='create clustered index t on '+@table+' ( '+@cli+ ' )'
declare @sql3 nvarchar(max)='create non clustered index t on '+@table+' ( '+@ncli+' )'
execute sp_executesql @sql

if @primary_key!=''
begin
execute sp_executesql @sql1
end
if @cli!=''
begin
execute sp_executesql @sql2
end
if @ncli!=''
begin
execute sp_executesql @sql3
end
end
else
begin
declare @sqla nvarchar(max)='alter table '+@table+' add '+@col 
declare @sqla1 nvarchar(max)='create nonclustered index t on '+@table+' ( '+@ncli+' )'
if @ncli!=''
begin
execute sp_executesql @sqla1
end
end