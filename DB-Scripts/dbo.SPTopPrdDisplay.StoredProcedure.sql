USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPTopPrdDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPTopPrdDisplay]
GO
/****** Object:  StoredProcedure [dbo].[SPTopPrdDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  PROCEDURE [dbo].[SPTopPrdDisplay] (
	@Opt int
) AS
BEGIN
	
	select top 3 pname as 'Name', sum(PsQty) as 'Sales'
	from productsales
	left join product on pcode = pspcode
	group by pname 
	order by sum(PsQty) desc

END

/*
exec [SPTtlSalesDisplay] 1

select * from product

select * from productsales

select * from Clients

*/
GO
