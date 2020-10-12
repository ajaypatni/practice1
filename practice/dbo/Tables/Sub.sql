CREATE TABLE [dbo].[Sub] (
    [sub_d]  DATE NULL,
    [sub_id] INT  NOT NULL,
    [hac_id] INT  NULL,
    [score]  INT  NULL,
    PRIMARY KEY NONCLUSTERED ([sub_id] ASC)
);

