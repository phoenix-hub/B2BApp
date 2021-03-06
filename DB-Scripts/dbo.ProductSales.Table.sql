USE [Event]
GO
ALTER TABLE [dbo].[ProductSales] DROP CONSTRAINT [FK__ProductSa__PsPCo__3C69FB99]
GO
ALTER TABLE [dbo].[ProductSales] DROP CONSTRAINT [FK__ProductSa__PsCCo__3B75D760]
GO
/****** Object:  Table [dbo].[ProductSales]    Script Date: 6/2/2021 6:10:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductSales]') AND type in (N'U'))
DROP TABLE [dbo].[ProductSales]
GO
/****** Object:  Table [dbo].[ProductSales]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSales](
	[PsID] [int] IDENTITY(1,1) NOT NULL,
	[PsRefNo] [nvarchar](12) NOT NULL,
	[PsCCode] [nvarchar](12) NOT NULL,
	[PsDate] [datetime] NOT NULL,
	[PsPCode] [nvarchar](12) NOT NULL,
	[PsQty] [int] NOT NULL,
	[PsStatus] [nvarchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PsRefNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductSales]  WITH CHECK ADD FOREIGN KEY([PsCCode])
REFERENCES [dbo].[Clients] ([CCode])
GO
ALTER TABLE [dbo].[ProductSales]  WITH CHECK ADD FOREIGN KEY([PsPCode])
REFERENCES [dbo].[Product] ([PCode])
GO
