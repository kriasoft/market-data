CREATE TABLE [dbo].[SecurityType] (
    [TypeID] TINYINT       NOT NULL,
    [Name]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_SecurityType_TypeID] PRIMARY KEY CLUSTERED ([TypeID] ASC)
);

