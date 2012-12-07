CREATE TABLE [dbo].[Tick] (
    [SecurityID] INT          NOT NULL,
    [Date]       DATETIME2(2) NOT NULL,
    [Price]      SMALLMONEY   NOT NULL,
    [Volume]     INT          NOT NULL,
    CONSTRAINT [PK_Tick_SecurityID_Date] PRIMARY KEY CLUSTERED ([SecurityID] ASC, [Date] DESC),
    CONSTRAINT [FK_Tick_Security] FOREIGN KEY ([SecurityID]) REFERENCES [dbo].[Security] ([SecurityID])
);
GO

CREATE NONCLUSTERED INDEX [IX_Tick_Date] ON [dbo].[Tick] ([Date] DESC) INCLUDE ([Price], [Volume]);
