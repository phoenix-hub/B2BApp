USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPAttendee]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPAttendee]
GO
/****** Object:  StoredProcedure [dbo].[SPAttendee]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SPAttendee]
@EAID nvarchar(50)=null,
@EMID int =0,
@EACN nvarchar(50)=null, 
@EAName nvarchar(50)=null, 
@EAEmail nvarchar(50)=null, 
@EAAddedBy nvarchar(50)=null, 
@UCrBy nvarchar(12)=null,
@EMMdBy nvarchar(12)=null, 
@RequestType nvarchar(15)

as


--	truncate table attendee


if lower(@RequestType)='add'
begin
INSERT INTO [dbo].[Attendee]
           ([EACN]
		   ,EMID
           ,[EAName]
           ,[EAEmail]
           ,[EAAddedBy]
           ,[UCrDt]
           ,[UCrBy])
     VALUES
           (@EACN,
		   @EMID,
           @EAName,
           @EAEmail, 
           coalesce(@UCrBy,@EAAddedBy),
           getdate(),
           coalesce(@UCrBy,@EAAddedBy))
end


if lower(@RequestType)='getall'
begin  


--	SPAttendee @RequestType='GetAll', @EAAddedBy='user@gmail.com', @EAName='b'
--	SPAttendee @RequestType='GetAll', @EAAddedBy='admin@gmail.com'
--	SPAttendee @RequestType='GetAll', @EAAddedBy='admin@gmail.com', @EAName=''
--	SPAttendee @RequestType='GetAll', @EAName=''
--	SPAttendee @RequestType='GetAll'

set @EAAddedBy = case when @EAAddedBy = 'admin@gmail.com' then null else @EAAddedBy end

SELECT [EAID]
      ,[EACN]
	  ,EMID
      ,[EAName]
      ,[EAEmail]
      ,[EAAddedBy]
      ,[UCrDt]
      ,[UCrBy]
      ,[EMMdDt]
      ,[EMMdBy]
  FROM [dbo].[Attendee] 
  where EAAddedBy= coalesce(@EAAddedBy,EAAddedBy)
  and EAName like  '%' +coalesce(@EAName,EAName) + '%' 
  and EMID=@EMID
end


if lower(@RequestType)='getone'
begin  
SELECT [EAID]
      ,[EACN]
	  ,EMID
      ,[EAName]
      ,[EAEmail]
      ,[EAAddedBy]
      ,[UCrDt]
      ,[UCrBy]
      ,[EMMdDt]
      ,[EMMdBy]
  FROM [dbo].[Attendee] 
  where EAID=@EAID
end

 
if lower(@RequestType)='delete'
begin  
DELETE FROM [dbo].[Attendee]
  where EAID=@EAID
end

if lower(@RequestType)='update'
begin 
UPDATE [dbo].[Attendee]
   SET [EACN] = @EACN,
		EMID = @EMID,
      [EAName] = @EAName,  
      [EAEmail] = @EAEmail,  
      [EMMdDt] = getdate(),
      [EMMdBy] = @EMMdBy
  where EAID=@EAID
end
GO
