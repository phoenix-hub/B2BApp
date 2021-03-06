USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPDashboard]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPDashboard]
GO
/****** Object:  StoredProcedure [dbo].[SPDashboard]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SPDashboard]
@RequestedBy nvarchar(50),
@ReqType nvarchar(50)
as


if(lower(@RequestedBy)='admin@gmail.com')
	begin
		set @RequestedBy= null;
	end

-----------------
if(lower(@ReqType)='eventdetails')
begin
print 1 
	select top 5 EMID, EMName, EMCoverImg, EMType, EMDescription, EMMaxCap, Convert(varchar(10),EMDate,103) EMDate, CONVERT(time,EMTime) EMTime, EMCity, EMArea, EMLocDesc, EMLocLink, EMCode, EMStsID, EMUID, EMMBUID, EMRecSts, UCrDt, UCrBy, EMMdDt, EMMdBy from [Event]
	where UCrBy= coalesce(@RequestedBy,UCrBy)
	order by Convert(date,EMDate,103) Desc,CONVERT(time,EMTime)
end
---------------
if(lower(@ReqType)='dashboardchart')
begin
print 2
	SELECT    count(1) EventCount, [user].UCPName from [dbo].[Event]
  inner join [User] on [user].UEmail= [Event].UCrBy 
  where [Event].UCrBy= coalesce(@RequestedBy,[Event].UCrBy)
  group by [user].UCPName
end
---------------- 
if(lower(@ReqType)='dashboard-enquiry')
begin
print 3
	SELECT TOP 5 EEID, EECname, EECPName, EECNumber, EEEmail, 
	CASE 
         WHEN Len(EEMessage) > 10 THEN CONCAT(SUBSTRING(EEMessage, 1, 10), '...')
         ELSE EEMessage
       END AS EEMessage,
	EEstatus, EERemark, Convert(varchar(10),EECreated,103) EECreated, EECreatedBy, EEUpdated, EEUpdatedBy
  FROM [Event].[dbo].[Enquiry]
  where isnull([EECreatedBy],'1') = coalesce(@RequestedBy,isnull([EECreatedBy],'1'))
  order by [EEID] desc
end
----------------
if(lower(@ReqType)='dashboard-topblocks')
begin
print 4

declare @TotInquiry int
declare @TotEvent int
declare @TotUsers int

select @TotInquiry = count(1) FROM [Event].[dbo].[Enquiry] where isnull([EECreatedBy],'1') = coalesce(@RequestedBy,isnull([EECreatedBy],'1'))
select @TotEvent = count(1) FROM [Event].[dbo].[Event] where isnull(UCrBy,'1') = coalesce(@RequestedBy,isnull(UCrBy,'1'))
select @TotUsers = count(1) FROM [Event].[dbo].[user] 
	 
	 select @TotInquiry TotInquiry, @TotEvent TotEvent,@TotUsers TotUsers

end
----------------
 
GO
