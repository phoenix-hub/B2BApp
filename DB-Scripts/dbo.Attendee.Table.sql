USE [Event]
GO
ALTER TABLE [dbo].[Attendee] DROP CONSTRAINT [DF_Attendee_UCrDt]
GO
/****** Object:  Table [dbo].[Attendee]    Script Date: 6/2/2021 6:10:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attendee]') AND type in (N'U'))
DROP TABLE [dbo].[Attendee]
GO
/****** Object:  Table [dbo].[Attendee]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendee](
	[EAID] [int] IDENTITY(1,1) NOT NULL,
	[EACN] [nvarchar](50) NULL,
	[EAName] [nvarchar](50) NULL,
	[EAEmail] [nvarchar](50) NULL,
	[EMID] [int] NULL,
	[EAAddedBy] [nvarchar](50) NULL,
	[UCrDt] [smalldatetime] NULL,
	[UCrBy] [nvarchar](50) NULL,
	[EMMdDt] [date] NULL,
	[EMMdBy] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attendee] ADD  CONSTRAINT [DF_Attendee_UCrDt]  DEFAULT (getdate()) FOR [UCrDt]
GO
