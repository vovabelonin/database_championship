USE [NewLb]
GO

/****** Object:  Table [dbo].[RUNK]    Script Date: 26.10.2020 22:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Tuser].[RUNK1](
	[RUNK_ID] [smallint] NOT NULL,
	[RUNK_NAME] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RUNK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


