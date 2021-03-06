USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPTtlSalesDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPTtlSalesDisplay]
GO
/****** Object:  StoredProcedure [dbo].[SPTtlSalesDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create  PROCEDURE [dbo].[SPTtlSalesDisplay] (
	@Opt int
) AS
BEGIN
	
	select pname as 'Name', sum(PsQty) as 'Sales'
	from productsales
	left join product on pcode = pspcode
	group by pname 
	order by pname

END

/*
exec [SPTtlSalesDisplay] 1

select * from product

select * from productsales

select * from Clients

*/
GO
