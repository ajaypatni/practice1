CREATE TABLE [dbo].[DimTime] (
    [Tid]      INT           NULL,
    [Time]     VARCHAR (67)  NOT NULL,
    [Hour]     VARCHAR (78)  NULL,
    [Minute]   VARCHAR (89)  NULL,
    [Sec]      VARCHAR (88)  NULL,
    [Time_sec] INT           NULL,
    [Clock_12] VARCHAR (100) NULL,
    [Clock_24] VARCHAR (100) NULL,
    CONSTRAINT [ak] PRIMARY KEY CLUSTERED ([Time] ASC)
);

