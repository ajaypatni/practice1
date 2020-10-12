create proc config2 @table nvarchar(1000),@col nvarchar(1000),
@col_data_type nvarchar(1000),@status nvarchar(max),
@primary_key nvarchar(max),@cli nvarchar(170),@ncli nvarchar(170)

as

if @status='New'

begin 

declare @sql nvarchar(max)='create table '+@table+'( '+@col + @col_data_type+' )'

execute sp_executesql @sql
end