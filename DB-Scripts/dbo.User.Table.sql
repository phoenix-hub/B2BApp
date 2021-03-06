USE [Event]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/2/2021 6:10:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
DROP TABLE [dbo].[User]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[UCName] [nvarchar](max) NULL,
	[UCPName] [nvarchar](100) NULL,
	[UPhone] [nvarchar](20) NULL,
	[UMobile] [nvarchar](20) NULL,
	[UCity] [nvarchar](50) NULL,
	[UOffAdd] [nvarchar](max) NULL,
	[UEmail] [nvarchar](50) NULL,
	[UPwd] [nvarchar](30) NULL,
	[UUName] [nvarchar](12) NULL,
	[UTlicns] [nvarchar](200) NULL,
	[URole] [nvarchar](50) NULL,
	[UCrDt] [smalldatetime] NULL,
	[UCrBy] [nvarchar](50) NULL,
	[UMdDt] [smalldatetime] NULL,
	[UMdBy] [nvarchar](50) NULL,
 CONSTRAINT [PK__User__C5B196024944A580] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([UID], [UCName], [UCPName], [UPhone], [UMobile], [UCity], [UOffAdd], [UEmail], [UPwd], [UUName], [UTlicns], [URole], [UCrDt], [UCrBy], [UMdDt], [UMdBy]) VALUES (1, N'CAdmin', N'PAdmin', N'080809999', N'0980898', N'City', N'Admin', N'admin@gmail.com', N'1234', N'Admin', N'2INK6O-20210527165127.jpg', N'admin', NULL, N'admin@gmail', CAST(N'2021-05-29T15:17:00' AS SmallDateTime), N'admin@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
