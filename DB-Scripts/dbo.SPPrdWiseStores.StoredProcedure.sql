USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPPrdWiseStores]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPPrdWiseStores]
GO
/****** Object:  StoredProcedure [dbo].[SPPrdWiseStores]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 


create  PROCEDURE [dbo].[SPPrdWiseStores] (
	@PrdName varchar(100)
) AS
BEGIN
	
	declare @prdCode varchar(12)
	declare @MaxVal int

	select @prdCode = ltrim(rtrim(PCode)) from product where ltrim(rtrim(PName)) = @PrdName

	select PsCCode, sum(PsQty) PsQty into #tempprd from productsales where ltrim(rtrim(PsPCode)) = @prdCode group by PsCCode 

	--select * from #tempprd 

	select @MaxVal = max(PsQty) from #tempprd 

	select CName as Store, @MaxVal as Sale from #tempprd 
	left join Clients on PsCCode = CCode 
	where  PsQty = @MaxVal

END

/*
exec [SPPrdWiseStores] 'Double Choco Loco'

select * from product

select * from productsales

select * from Clients

*/
GO
