CREATE TABLE [dbo].[Exchange] (
    [ExchangeID]   SMALLINT       NOT NULL IDENTITY (1000, 1),
    [Code]         NVARCHAR (25)  NOT NULL,
    [Name]         NVARCHAR (100) NOT NULL,
    [Economy]      NVARCHAR (25)  NOT NULL,
    [Headquarters] NVARCHAR (100) NULL,
    [MarketCap]    INT            NOT NULL,
    [TradeValue]   INT            NOT NULL,
    CONSTRAINT [PK_Exchange_ExchangeID] PRIMARY KEY CLUSTERED ([ExchangeID] ASC)
);

