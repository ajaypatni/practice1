CREATE TABLE [dbo].[fact] (
    [id]     INT  NULL,
    [o_date] DATE NULL,
    [proid]  INT  NULL,
    [cusd]   INT  NULL,
    FOREIGN KEY ([cusd]) REFERENCES [dbo].[cus] ([cus_id]),
    FOREIGN KEY ([o_date]) REFERENCES [dbo].[d_date] ([date_id]),
    FOREIGN KEY ([proid]) REFERENCES [dbo].[pro] ([pro_id])
);

