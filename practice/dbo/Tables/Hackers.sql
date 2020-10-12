CREATE TABLE [dbo].[Hackers] (
    [hac_id]  INT           NULL,
    [name]    VARCHAR (68)  NULL,
    [Hackers] NVARCHAR (25) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Hackers] TO [ajay2]
    AS [dbo];

