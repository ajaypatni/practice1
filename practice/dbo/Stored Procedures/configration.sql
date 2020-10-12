CREATE proc configration as
update config set _PrimaryKey='no' where _PrimaryKey!='yes' or _PrimaryKey is null or _PrimaryKey=''
update config set cli='no' where cli!='yes' or cli is null or cli=''
update config set ncli='no' where ncli!='yes'or ncli is null or ncli=''

declare @Table nvarchar(max)=''
Declare @a int=1 
while @a<=(select count(*) from(select Tables from config group by TableStatus,Tables having TableStatus='new'and TableStatus='New')v) 
begin
	declare @c int=1
	declare @p1 nvarchar(max)=''
	declare @col_with_d nvarchar(max)=''
	declare @pri nvarchar(max)=''
	declare @ncli nvarchar(max)=''
	declare @cli nvarchar(max)=''
	set @Table=(select Tables from(select tables ,ROW_NUMBER() over(partition by TableStatus order by Tables) row from 
	(select Tables,TableStatus from config group by TableStatus,Tables having TableStatus='new'and TableStatus='New') v) b where row=@a)
	while @c <=(select count(*) from config where Tables=@Table)
	begin 

		set @col_with_d=@col_with_d+(select NewColumn+'  '+DataTypes from
		(select *,ROW_NUMBER()  over(partition by Tables order by NewColumn)row from config where Tables=@Table)b where row=@c)+','

		set @pri=@pri+(select iif(_PrimaryKey='yes',NewColumn+',','')  from
		(select *,ROW_NUMBER()  over(partition by Tables order by NewColumn)row from config where Tables=@Table)b where row=@c)

		set @cli=@cli+(select iif(cli='yes',NewColumn+',','')  from
		(select *,ROW_NUMBER()  over(partition by Tables order by NewColumn)row from config where Tables=@Table)b where row=@c)

		set @ncli=@ncli+(select iif(ncli='yes',NewColumn+',','')  from
		(select *,ROW_NUMBER()  over(partition by Tables order by NewColumn)row from config where Tables=@Table)b where row=@c)

		set @c=@c+1
	end
	set @p1=STUFF(@pri,LEN(@pri),1,'')
	set @pri=', primary key('+STUFF(@pri,LEN(@pri),1,'')+')'
	set @col_with_d=STUFF(@col_with_d,LEN(@col_with_d),1,'')
	set @ncli=STUFF(@ncli,LEN(@ncli),1,'')
	set @cli=STUFF(@cli,LEN(@cli),1,'')

	if 'yes' in (select _PrimaryKey from config where Tables=@Table ) and (@p1=@cli or'no' = all (select cli from config where Tables=@Table )) and
	'no' = all (select ncli from config where Tables=@Table )
	begin 
		declare @sql nvarchar(max)='create Table '+@Table+'('+@col_with_d+@pri+')'
		exec (@sql)

	end
	else if 'yes' in (select _PrimaryKey from config where Tables=@Table ) and 'yes' in (select cli from config where Tables=@Table )AND(
	(@p1!=@cli) and
	'no' = all (select ncli from config where Tables=@Table ) or ('yes' in (select ncli from config where Tables=@Table ) and @p1=@ncli ))
	begin 
		declare @sql1 nvarchar(max)='create Table '+@Table+'('+@col_with_d+', primary key nonclustered('+@p1+'),index c1 clustered('+@cli+'))'
		exec (@sql1)
	end 
	else if 'yes' in (select _PrimaryKey from config where Tables=@Table ) and 'yes' in (select ncli from config where Tables=@Table )AND
	(@p1=@ncli) and
	'no' = all (select cli from config where Tables=@Table )
	begin 
		declare @sql2 nvarchar(max)='create Table '+@Table+'('+@col_with_d+', primary key nonclustered('+@p1+'))'
		exec (@sql2)
	end 

	else if 'yes' in (select _PrimaryKey from config where Tables=@Table ) and 'yes' in (select ncli from config where Tables=@Table )AND
	(@p1!=@ncli) and
	'no' = all (select cli from config where Tables=@Table )
	begin 
		declare @sql3 nvarchar(max)='create Table '+@Table+'('+@col_with_d+@pri+',index c1 nonclustered('+@ncli+'))'
		exec (@sql3)
		
	end 
	else if 'yes' in (select _PrimaryKey from config where Tables=@Table ) and 'yes' in (select ncli from config where Tables=@Table )AND
	'yes' in (select cli from config where Tables=@Table )
	begin 
		declare @sql23 nvarchar(max)='create Table '+@Table+'('+@col_with_d+', primary key nonclustered ('+@p1+'),index c1  clustered('+@cli+'),index n1  nonclustered('+@ncli+'))'
		exec (@sql23)
	end 

	else if 'no' =all (select _PrimaryKey from config where Tables=@Table ) and 'no' =all (select ncli from config where Tables=@Table )AND
	'no' = all (select cli from config where Tables=@Table )
	begin 
		declare @sql13 nvarchar(max)='create Table '+@Table+'('+@col_with_d+')'
		exec (@sql13)
	end 

	else if 'no' =all (select _PrimaryKey from config where Tables=@Table ) and 'no' =all (select ncli from config where Tables=@Table )AND
	'yes' in (select cli from config where Tables=@Table )
	begin 
		declare @sql_3 nvarchar(max)='create Table '+@Table+'('+@col_with_d+',index c1 clustered('+@cli+'))'
		exec (@sql_3)
	end

	else if 'no' =all (select _PrimaryKey from config where Tables=@Table ) and 'yes' =all (select ncli from config where Tables=@Table )AND
	'no' in (select cli from config where Tables=@Table )
	begin 
		declare @sql14 nvarchar(max)='create Table '+@Table+'('+@col_with_d+',index c1 nonclustered('+@ncli+'))'
		exec (@sql14)
	end

	else if 'no' =all (select _PrimaryKey from config where Tables=@Table ) and 'yes' in (select ncli from config where Tables=@Table )AND
	'yes' in (select cli from config where Tables=@Table )
	begin 
		declare @sql15 nvarchar(max)=''
		set @sql15='create Table '+@Table+'('+@col_with_d+',index c1 clustered('+@cli+'),index n2 nonclustered('+@ncli+'))'
		exec (@sql15)
		

	end
	

	print'--------------------------'
	set @a=@a+1
end
update config set TableStatus='Processed' where TableStatus='New'

declare @Tableo nvarchar(max)=''
Declare @ao int=1 
while @ao<=(select count(*) from(select Tables from config group by TableStatus,Tables having TableStatus='old' and TableStatus!='Processed')v) 
begin
	declare @co int=1
	declare @p1o nvarchar(max)=''
	declare @col_with_do nvarchar(max)=''
	declare @prio nvarchar(max)=''
	declare @nclio nvarchar(max)=''
	declare @clio nvarchar(max)=''

	set @Tableo=(select Tables from(select * ,ROW_NUMBER() over(partition by TableStatus order by Tables) row from 
	(select Tables,TableStatus from config group by TableStatus,Tables having TableStatus='old'and TableStatus!='Processed') v) b where row=@ao)
	

	while @co <=(select count(*) from config where Tables=@Tableo and TableStatus='old'and TableStatus!='Processed')
	begin 

		set @col_with_do=@col_with_do+(select NewColumn+'  '+DataTypes from
		(select *,ROW_NUMBER()  over(partition by Tables order by NewColumn)row from config where Tables=@Tableo and TableStatus='old' and TableStatus!='Processed')b where row=@co)+','
		select NewColumn+'  '+DataTypes from
		(select *,ROW_NUMBER()  over(partition by Tables order by NewColumn)row from config where Tables=@Tableo and TableStatus='old' and TableStatus!='Processed')b where row=@co
		set @co=@co+1
	end
	set @col_with_do=STUFF(@col_with_do,LEN(@col_with_do),1,'')
	


	Declare @sql5 nvarchar(max)=''
	set @sql5='alter table'+' '+@Tableo+' '+'add '+@col_with_do
	exec (@sql5)
	
	print'--------------------------'
	set @ao=@ao+1
end
update config set TableStatus='Processed' where TableStatus='old'