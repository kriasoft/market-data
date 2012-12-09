CREATE TABLE [dbo].[Security] (
    [SecurityID] INT            NOT NULL IDENTITY (100000, 1),
    [ExchangeID] SMALLINT       NOT NULL,
    [Type]       TINYINT        NOT NULL,
    [Ticker]     NVARCHAR (25)  NOT NULL,
    [Name]       NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Security_SecurityID] PRIMARY KEY CLUSTERED ([SecurityID] ASC),
    CONSTRAINT [FK_Security_Exchange] FOREIGN KEY ([ExchangeID]) REFERENCES [dbo].[Exchange] ([ExchangeID])
);

