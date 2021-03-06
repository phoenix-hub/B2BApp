USE [Event]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 6/2/2021 6:10:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Clients]') AND type in (N'U'))
DROP TABLE [dbo].[Clients]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[CID] [int] IDENTITY(1,1) NOT NULL,
	[CCode] [nvarchar](12) NOT NULL,
	[CName] [nvarchar](100) NOT NULL,
	[CMob] [int] NOT NULL,
	[COff] [int] NOT NULL,
	[CEmail] [nvarchar](100) NOT NULL,
	[CCreatedDate] [datetime] NOT NULL,
	[CStatus] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
