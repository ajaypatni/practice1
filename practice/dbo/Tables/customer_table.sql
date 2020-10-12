CREATE TABLE [dbo].[customer_table] (
    [PersonID]       INT           NULL,
    [Name]           VARCHAR (255) NOT NULL,
    [LastModifytime] DATETIME      NULL,
    CONSTRAINT [nk] PRIMARY KEY CLUSTERED ([Name] ASC)
);

