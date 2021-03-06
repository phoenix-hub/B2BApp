USE [Event]
GO
/****** Object:  Table [dbo].[CredentialsResetRequest]    Script Date: 6/2/2021 6:10:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CredentialsResetRequest]') AND type in (N'U'))
DROP TABLE [dbo].[CredentialsResetRequest]
GO
/****** Object:  Table [dbo].[CredentialsResetRequest]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CredentialsResetRequest](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](50) NULL,
	[created] [date] NULL,
	[status] [nvarchar](50) NULL,
	[remarks] [nvarchar](250) NULL,
	[updatedby] [nvarchar](50) NULL,
	[updated] [date] NULL,
 CONSTRAINT [PK_CredentialsResetRequest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
