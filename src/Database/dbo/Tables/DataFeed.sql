CREATE TABLE [dbo].[DataFeed] (
    [DataFeedID]  SMALLINT       NOT NULL IDENTITY (100, 1),
    [Name]        NVARCHAR (100) NOT NULL,
    [Description] NVARCHAR (500) NULL,
    [Website]     [dbo].[Url]    NULL,
    [Phone]       [dbo].[Phone]  NULL,
    [HasRealTime] [dbo].[Flag]   NOT NULL,
    [HasLookUp]   [dbo].[Flag]   NOT NULL,
    CONSTRAINT [PK_DataFeed_DataFeedID] PRIMARY KEY CLUSTERED ([DataFeedID] ASC)
)
