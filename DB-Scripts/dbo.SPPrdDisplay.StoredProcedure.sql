USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPPrdDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPPrdDisplay]
GO
/****** Object:  StoredProcedure [dbo].[SPPrdDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  PROCEDURE [dbo].[SPPrdDisplay] (
	@Opt int
) AS
BEGIN
	select pid, pcode, pname, plaunchdate from product
END
GO
