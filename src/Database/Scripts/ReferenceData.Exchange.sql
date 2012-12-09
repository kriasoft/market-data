SET IDENTITY_INSERT [dbo].[Exchange] ON;
GO

MERGE INTO [dbo].[Exchange] AS Target
USING (VALUES
  ( 1, N'NYSE',   N'NYSE Euronext',        N'US,EU', N'New York City', 14242, 20161),
  ( 2, N'NASDAQ', N'NASDAQ OMX',           N'US,EU', N'New York City',  4687, 13552),
  ( 3, N'TSE',    N'Tokyo Stock Exchange', N'JP',    N'Tokyo',          3325,  3972),
  (17, N'MICEX',  N'Moscow Exchange',      N'RU',    N'Moscow',          800,   514)
)
AS Source ([ExchangeID], [Code], [Name], [Economy], [Headquarters], [MarketCap], [TradeValue])
ON Target.[ExchangeID] = Source.[ExchangeID]
-- update matched rows
WHEN MATCHED THEN
UPDATE SET [Code] = Source.[Code], [Name] = Source.[Name], [Economy] = Source.[Economy], [Headquarters] = Source.[Headquarters], [MarketCap] = Source.[MarketCap], [TradeValue] = Source.[TradeValue]
-- insert new rows
WHEN NOT MATCHED BY TARGET THEN
INSERT ([ExchangeID], [Code], [Name], [Economy], [Headquarters], [MarketCap], [TradeValue])
VALUES ([ExchangeID], [Code], [Name], [Economy], [Headquarters], [MarketCap], [TradeValue])
-- delete rows that are in the target but not the source
WHEN NOT MATCHED BY SOURCE THEN 
DELETE;
GO

SET IDENTITY_INSERT [dbo].[Exchange] OFF;
GO