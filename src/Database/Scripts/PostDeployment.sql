-----------------------------------------------------------------------------------------------------------------------
-- IMPORT THE LIST OF EXCHANGES
-----------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp;

SELECT TOP(0) CAST([ExchangeID] AS SMALLINT) AS [ExchangeID], [Code], [Name], [Economy], [Headquarters], [MarketCap], [TradeValue] INTO #Temp FROM [dbo].[Exchange];

BULK INSERT #Temp FROM '$(ReferenceDataDir)Exchange.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ' | ', ROWTERMINATOR = '\n', KEEPNULLS);
GO

SET IDENTITY_INSERT [dbo].[Exchange] ON;
GO

MERGE INTO [dbo].[Exchange] AS Target
USING (SELECT [ExchangeID], [Code], [Name], [Economy], [Headquarters], [MarketCap], [TradeValue] FROM #Temp) AS Source
ON Target.[ExchangeID] = Source.[ExchangeID]
-- update matched rows
WHEN MATCHED THEN
UPDATE SET [Code] = Source.[Code], [Name] = Source.[Name], [Economy] = Source.[Economy], [Headquarters] = Source.[Headquarters], [MarketCap] = Source.[MarketCap], [TradeValue] = Source.[TradeValue]
-- insert new rows
WHEN NOT MATCHED BY TARGET THEN
INSERT ([ExchangeID], [Code], [Name], [Economy], [Headquarters], [MarketCap], [TradeValue])
VALUES ([ExchangeID], [Code], [Name], [Economy], [Headquarters], [MarketCap], [TradeValue]);
-- delete rows that are in the target but not the source
-- WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE;
GO

SET IDENTITY_INSERT [dbo].[Exchange] OFF;
GO

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp;
GO

-----------------------------------------------------------------------------------------------------------------------
-- IMPORT THE LIST OF DATA FEEDS
-----------------------------------------------------------------------------------------------------------------------

SELECT TOP(0) CAST([DataFeedID] AS TINYINT) AS [DataFeedID], [Name], [Description], [Website], [Phone], CAST([HasRealTime] AS NVARCHAR (20)) AS [HasRealTime], CAST([HasLookup] AS NVARCHAR (20)) AS [HasLookup] INTO #Temp FROM [dbo].[DataFeed];

SET IDENTITY_INSERT [dbo].[DataFeed] ON;
GO

BULK INSERT #Temp FROM '$(ReferenceDataDir)DataFeed.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ' | ', ROWTERMINATOR = '\n', KEEPNULLS);
GO

MERGE INTO [dbo].[DataFeed] AS Target
USING (SELECT [DataFeedID], [Name], [Description], CASE [Website] WHEN '' THEN NULL ELSE [Website] END AS [Website], CASE [Phone] WHEN '' THEN NULL ELSE [Phone] END AS [Phone], CASE [HasRealTime] WHEN '0' THEN 0 ELSE 1 END AS [HasRealTime], CASE [HasLookup] WHEN '0' THEN 0 ELSE 1 END AS [HasLookup] FROM #Temp) AS Source
ON Target.[DataFeedID] = Source.[DataFeedID]
-- update matched rows
WHEN MATCHED THEN
UPDATE SET [Name] = Source.[Name], [Description] = Source.[Description], [Website] = Source.[Website], [Phone] = Source.[Phone], [HasRealTime] = Source.[HasRealTime], [HasLookup] = Source.[HasLookup]
-- insert new rows
WHEN NOT MATCHED BY TARGET THEN
INSERT ([DataFeedID], [Name], [Description], [Website], [Phone], [HasRealTime], [HasLookup])
VALUES ([DataFeedID], [Name], [Description], [Website], [Phone], [HasRealTime], [HasLookup]);
-- delete rows that are in the target but not the source
-- WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE;
GO

SET IDENTITY_INSERT [dbo].[DataFeed] OFF;
GO

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp;
GO

-----------------------------------------------------------------------------------------------------------------------
-- IMPORT THE LIST OF SECURITY TYPES
-----------------------------------------------------------------------------------------------------------------------

SELECT TOP(0) [TypeID], [Name] INTO #Temp FROM [dbo].[SecurityType];

BULK INSERT #Temp FROM '$(ReferenceDataDir)SecurityType.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ' | ', ROWTERMINATOR = '\n', KEEPNULLS);
GO

MERGE INTO [dbo].[SecurityType] AS Target
USING (SELECT [TypeID], [Name] FROM #Temp) AS Source
ON Target.[TypeID] = Source.[TypeID]
-- update matched rows
WHEN MATCHED THEN
UPDATE SET [Name] = Source.[Name]
-- insert new rows
WHEN NOT MATCHED BY TARGET THEN
INSERT ([TypeID], [Name])
VALUES ([TypeID], [Name]);
-- delete rows that are in the target but not the source
-- WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE;
GO

SET IDENTITY_INSERT [dbo].[Security] OFF;
GO

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp;
GO

-----------------------------------------------------------------------------------------------------------------------
-- IMPORT THE LIST OF SECURITIES
-----------------------------------------------------------------------------------------------------------------------

SELECT TOP(0) CAST([SecurityID] AS SMALLINT) AS [SecurityID], [ExchangeID], [TypeID], [Ticker], [Name] INTO #Temp FROM [dbo].[Security];

SET IDENTITY_INSERT [dbo].[Security] ON;
GO

BULK INSERT #Temp FROM '$(ReferenceDataDir)Security.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ' | ', ROWTERMINATOR = '\n', KEEPNULLS);
GO

MERGE INTO [dbo].[Security] AS Target
USING (SELECT [SecurityID], [ExchangeID], [TypeID], [Ticker], [Name] FROM #Temp) AS Source
ON Target.[SecurityID] = Source.[SecurityID]
-- update matched rows
WHEN MATCHED THEN
UPDATE SET [ExchangeID] = Source.[ExchangeID], [TypeID] = Source.[TypeID], [Ticker] = Source.[Ticker], [Name] = Source.[Name]
-- insert new rows
WHEN NOT MATCHED BY TARGET THEN
INSERT ([SecurityID], [ExchangeID], [TypeID], [Ticker], [Name])
VALUES ([SecurityID], [ExchangeID], [TypeID], [Ticker], [Name]);
-- delete rows that are in the target but not the source
-- WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE;
GO

SET IDENTITY_INSERT [dbo].[Security] OFF;
GO

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp;
GO
