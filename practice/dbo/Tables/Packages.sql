CREATE TABLE [dbo].[Packages] (
    [ID]     INT            NULL,
    [Salary] NUMERIC (8, 4) NULL
);


GO
CREATE NONCLUSTERED INDEX [name]
    ON [dbo].[Packages]([Salary] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20200608-123306]
    ON [dbo].[Packages]([ID] ASC);

