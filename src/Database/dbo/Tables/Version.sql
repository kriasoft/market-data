CREATE TABLE [dbo].[Version] (
    [VersionID]     INT           NOT NULL IDENTITY (1, 1),
    [VersionNumber] NVARCHAR (25) NOT NULL,
    [VersionDate]   DATETIME      NOT NULL,
    CONSTRAINT [PK_Version_VersionID] PRIMARY KEY CLUSTERED ([VersionID] ASC)
);
