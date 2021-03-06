USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPTtlSalesStatusDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPTtlSalesStatusDisplay]
GO
/****** Object:  StoredProcedure [dbo].[SPTtlSalesStatusDisplay]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[SPTtlSalesStatusDisplay] (
	@Opt int
) AS
BEGIN
	create table #tempfinal (Status varchar(12), Qty int)
	
	insert into #tempfinal 
	select PsStatus, sum(PsQty)
	from productsales
	group by PsStatus

	insert into #tempfinal 
	select 'Total',sum(PsQty)
	from productsales

	select * from #tempfinal

	drop table #tempfinal
END

/*
exec [SPTtlSalesStatusDisplay] 1

select * from product

select * from productsales

select * from Clients

*/
GO
