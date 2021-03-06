USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPEnquiry]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPEnquiry]
GO
/****** Object:  StoredProcedure [dbo].[SPEnquiry]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[SPEnquiry]
@EEID nvarchar(50)=null,  
@EECname nvarchar(max)=null, 
@EECPName nvarchar(13)=null, 
@EECNumber nvarchar(30)=null, 
@EEEmail nvarchar(50)=null, 
@EEMessage nvarchar(max)=null, 
@EEstatus nvarchar(10)=null, 
@EERemark nvarchar(max)=null,  
@EECreatedBy nvarchar(50)=null,  
@EEUpdatedBy nvarchar(50)=null,

@ColName nvarchar(50)=null, 
@FilterValue nvarchar(50)=null, 
@User nvarchar(50)=null,  
@OrderBy nvarchar(50)=null,  
@ShortOrder nvarchar(50)=null, 


@RequestType nvarchar(15)

as

 
declare @query nvarchar(max)
declare @WhereClouse nvarchar(200)
declare @filtercondition nvarchar(max)



if lower(@RequestType)='add'
begin

 set @EEUpdatedBy = case when @EECreatedBy is null then @User else @EECreatedBy end;

INSERT INTO [dbo].[Enquiry]
           ([EECname]
           ,[EECPName]
           ,[EECNumber]
           ,[EEEmail]
           ,[EEMessage]
           ,[EEstatus]
           ,[EECreated]
           ,[EECreatedBy])
     VALUES
           (@EECname, 
           @EECPName,
           @EECNumber, 
           @EEEmail, 
           @EEMessage,
           @EEstatus, 
           GETDATE(),
           @EEUpdatedBy)
END

if lower(@RequestType)='getall'
begin

print 1

 set @WhereClouse = case when @User = 'admin@gmail.com' then ' 1=1 ' else ' EECreatedBy='''+ @User+'''' end;

 if(lower(@ColName) !='all')
	 begin
print 2
		set @WhereClouse = @WhereClouse + ' and '+ @ColName +'='''+@FilterValue+''''
	 end 
  
 set @OrderBy = case when @OrderBy is null then ' 1 ' else ' '+ @OrderBy+' ' end;
 set @ShortOrder = case when @ShortOrder is null then ' desc ' else ' '+ @ShortOrder+' ' end;
 
print 3
  print (@WhereClouse)
  print (@OrderBy)
  print (@ShortOrder)

set @query=N'SELECT [EEID]
      ,[EECname]
      ,[EECPName]
      ,[EECNumber]
      ,[EEEmail]
      ,[EEMessage]
      ,[EEstatus]
      ,[EERemark]
      ,[EECreated]
      ,[EECreatedBy]
      ,[EEUpdated]
      ,[EEUpdatedBy]
  FROM [dbo].[Enquiry] 
  where '+ @WhereClouse +'
  order by '+ @OrderBy +' '+  @ShortOrder

  print (@query)
  exec (@query)

END

if lower(@RequestType)='getone'
begin 
SELECT [EEID]
      ,[EECname]
      ,[EECPName]
      ,[EECNumber]
      ,[EEEmail]
      ,[EEMessage]
      ,[EEstatus]
      ,[EERemark]
      ,[EECreated]
      ,[EECreatedBy]
      ,[EEUpdated]
      ,[EEUpdatedBy]
  FROM [dbo].[Enquiry] 
  where EEID=@EEID
END
 
if lower(@RequestType)='delete'
begin  
DELETE FROM [dbo].[Enquiry] 
  where EEID=Convert(int,@EEID)
END

 
if lower(@RequestType)='update'
begin 


 set @EEUpdatedBy = case when @EEUpdatedBy is null then @User else @EEUpdatedBy end;

UPDATE [dbo].[Enquiry]
   SET 
      [EEstatus] = @EEstatus,  
      [EERemark] = @EERemark ,
      [EEUpdated] =  getdate(),
      [EEUpdatedBy] = @EEUpdatedBy
 
  where EEID= Convert(int,@EEID)
END


GO
