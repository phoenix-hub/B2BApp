USE [Event]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 6/2/2021 6:10:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Event]') AND type in (N'U'))
DROP TABLE [dbo].[Event]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[EMID] [int] IDENTITY(1,1) NOT NULL,
	[EMName] [nvarchar](50) NULL,
	[EMCoverImg] [nvarchar](max) NULL,
	[EMType] [nvarchar](50) NULL,
	[EMDescription] [nvarchar](250) NULL,
	[EMMaxCap] [int] NULL,
	[EMDate] [date] NULL,
	[EMTime] [time](7) NULL,
	[EMCity] [nvarchar](50) NULL,
	[EMArea] [nvarchar](100) NULL,
	[EMLocDesc] [nvarchar](300) NULL,
	[EMLocLink] [nvarchar](max) NULL,
	[EMCode] [nvarchar](50) NULL,
	[EMStsID] [int] NULL,
	[EMUID] [int] NULL,
	[EMMBUID] [int] NULL,
	[EMRecSts] [bit] NULL,
	[UCrDt] [smalldatetime] NULL,
	[UCrBy] [nvarchar](50) NULL,
	[EMMdDt] [date] NULL,
	[EMMdBy] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
