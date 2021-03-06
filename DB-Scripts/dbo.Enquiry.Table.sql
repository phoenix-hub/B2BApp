USE [Event]
GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 6/2/2021 6:10:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Enquiry]') AND type in (N'U'))
DROP TABLE [dbo].[Enquiry]
GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EEID] [int] IDENTITY(1,1) NOT NULL,
	[EECname] [nvarchar](max) NULL,
	[EECPName] [nvarchar](13) NULL,
	[EECNumber] [nvarchar](30) NOT NULL,
	[EEEmail] [nvarchar](50) NOT NULL,
	[EEMessage] [nvarchar](max) NOT NULL,
	[EEstatus] [nvarchar](30) NOT NULL,
	[EERemark] [nvarchar](max) NULL,
	[EECreated] [date] NULL,
	[EECreatedBy] [nvarchar](50) NULL,
	[EEUpdated] [date] NULL,
	[EEUpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK__Enquiry__DE9635FE8CB991F2] PRIMARY KEY CLUSTERED 
(
	[EEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
