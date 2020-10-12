CREATE TABLE [dbo].[Occupation] (
    [Name] VARCHAR (56) NULL,
    [Occu] VARCHAR (78) NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Occupation] TO [ajay_patni]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Occupation] TO [ajay_patni]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Occupation] TO [ajay_patni]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[Occupation] TO [ajay_patni]
    AS [dbo];

