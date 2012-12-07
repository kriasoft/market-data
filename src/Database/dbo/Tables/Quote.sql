CREATE TABLE [dbo].[Quote] (
    [SecurityID] INT        NOT NULL,
    [Period]     TINYINT    NOT NULL,
    [Date]       DATETIME   NOT NULL,
    [Open]       SMALLMONEY NOT NULL,
    [High]       SMALLMONEY NOT NULL,
    [Low]        SMALLMONEY NOT NULL,
    [Close]      SMALLMONEY NOT NULL,
    [Volume]     INT        NOT NULL,
    CONSTRAINT [PK_Quote_SecurityID_Period_Date] PRIMARY KEY CLUSTERED ([SecurityID] ASC, [Period] ASC, [Date] DESC)
);

