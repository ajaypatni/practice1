CREATE TABLE [dbo].[dim_date] (
    [dates]         DATE         NOT NULL,
    [month_name]    VARCHAR (89) NULL,
    [year_name]     INT          NULL,
    [month_no]      INT          NULL,
    [week_day_name] VARCHAR (67) NULL,
    [quarter_of]    INT          NULL,
    [day_year]      INT          NULL,
    CONSTRAINT [pk] PRIMARY KEY CLUSTERED ([dates] ASC)
);

