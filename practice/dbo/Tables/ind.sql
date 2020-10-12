CREATE TABLE [dbo].[ind] (
    [id]   INT          NOT NULL,
    [name] VARCHAR (56) NULL,
    [gen]  NCHAR (10)   NULL,
    [age]  INT          NULL
);


GO
CREATE NONCLUSTERED INDEX [t]
    ON [dbo].[ind]([age] ASC);

