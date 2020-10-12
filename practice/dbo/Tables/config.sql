CREATE TABLE [dbo].[config] (
    [NewColumn]   VARCHAR (67) NULL,
    [DataTypes]   VARCHAR (78) NULL,
    [Tables]      VARCHAR (78) NULL,
    [TableType]   VARCHAR (10) NULL,
    [TableStatus] VARCHAR (10) NULL,
    [_PrimaryKey] VARCHAR (10) NULL,
    [cli]         VARCHAR (10) NULL,
    [ncli]        VARCHAR (10) NULL
);


GO
GRANT ALTER
    ON OBJECT::[dbo].[config] TO [ajay_patni]
    AS [dbo];

