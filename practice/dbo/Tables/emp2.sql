CREATE TABLE [dbo].[emp2] (
    [id]   INT          NULL,
    [name] VARCHAR (50) NULL,
    [age]  INT          NULL
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20200619-033054]
    ON [dbo].[emp2]([id] ASC);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20200619-033127]
    ON [dbo].[emp2]([id] ASC);

