USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPUser]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPUser]
GO
/****** Object:  StoredProcedure [dbo].[SPUser]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SPUser @UEmail='admin@gmail.com',@UPwd='1234',@RequestType='Login'
--SPUser @UEmail='user@gmail.com', @RequestType='GetOne'

CREATE Proc [dbo].[SPUser]
@UID nvarchar(50) =null, 
@UCName nvarchar(max)=null,  
@UCPName nvarchar(100)=null,  
@UPhone nvarchar(20)=null, 
@UMobile nvarchar(20)=null, 
@UCity nvarchar(50) =null, 
@UOffAdd nvarchar(max)=null, 
@UEmail nvarchar(50)=null, 
@UPwd nvarchar(30)=null, 
@UUName nvarchar(12)=null, 
@UTlicns nvarchar(200)=null,  
@URole nvarchar(50)=null, 
@UCrBy nvarchar(12)=null,  
@UMdBy nvarchar(12)=null,  
@OrderBy nvarchar(50)=null,  
@ShortOrder nvarchar(50)=null, 
@ColName nvarchar(50)=null, 
@FilterValue nvarchar(50)=null, 

@RequestType nvarchar(15)

as


declare @query nvarchar(max)

if lower(@RequestType)='add'
begin

if (Exists (select 1 from [User] where UEmail=@UEmail))
	begin
		return null
	end
else
	begin
		
	INSERT INTO [dbo].[User]
			   ([UCName]
			   ,[UCPName]
			   ,[UPhone]
			   ,[UMobile]
			   ,[UCity]
			   ,[UOffAdd]
			   ,[UEmail]
			   ,[UPwd]
			   ,[UUName]
			   ,[UTlicns]
			   ,[URole]
			   ,[UCrDt]
			   ,[UCrBy])
		 VALUES
			   (@UCName,  
			   @UCPName, 
			   @UPhone,  
			   @UMobile,  
			   @UCity,  
			   @UOffAdd,  
			   @UEmail,  
			   @UPwd,  
			   @UUName,  
			   @UTlicns, 
			   @URole,
			   getdate(),
			   @UCrBy )
	end

END -- End of Add block

if @RequestType='GetAll'
begin  
set @query='SELECT *
  FROM [dbo].[User] 
  order by '+@OrderBy +' '+  @ShortOrder
  
  
--	SPUser @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetAll'

  exec(@query)
  print (@query)
END


if lower(@RequestType)=lower('GetFiltered')
begin  
declare @filtercondition nvarchar(max)

if( lower(@ColName)=lower('UCName') or  lower(@ColName)=lower('UCPName') )
begin
set @filtercondition ='  where '+@ColName+' like ''%'+@FilterValue+'%'' order by '+@OrderBy +' '+  @ShortOrder
end
else if lower(@ColName)=lower('all')
begin 
set  @filtercondition =' order by ' + @OrderBy +' '+  @ShortOrder
end
else  
begin 
set @filtercondition =' where '+ @ColName+'='''+@FilterValue+''' order by '+@OrderBy +' '+  @ShortOrder
end

print @filtercondition

set @query='SELECT *
  FROM [dbo].[User]  '
  print( @query + @filtercondition )

  
--	SPUser @ColName='UCName', @FilterValue='User',   @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetFiltered'

--	SPUser @ColName='UMobile', @FilterValue='798669',   @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetFiltered'

--	SPUser @ColName='UPhone', @FilterValue='9797',   @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetFiltered'

  exec( @query + @filtercondition)
END


if lower(@RequestType)=lower('GetOne')
begin  

set @query='SELECT *
  FROM [dbo].[User] 
  where   UEMail='''+@UEmail+''' '

--	SPUser  @UEmail='user@gmail.com' , @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetOne'

  print(@query)
  exec(@query)
END
 
if lower(@RequestType)=lower('GetMyMailId')
begin  
SELECT *
  FROM [dbo].[User]   with (nolock)
  where [UEmail]=@UEmail 
END

if lower(@RequestType)=lower('GetMyUID')
begin  
SELECT *
  FROM [dbo].[User]   with (nolock)
  where [UID]=@UID 
END

if @RequestType='Login'
begin  
SELECT *
  FROM [dbo].[User] with (nolock)
  where [UEmail]=@UEmail and [UPwd]=@UPwd
END

if @RequestType='Delete'
begin   
DELETE FROM [dbo].[User] 
  where [UEmail] =@UEmail
END


if lower(@RequestType)='update'
begin    

set @UTlicns = case when @UTlicns ='' then null else @UTlicns end

UPDATE [dbo].[User]
   SET [UCName] = coalesce(@UCName,UCName),
      [UCPName] =coalesce(@UCPName,[UCPName]),  
      [UPhone] = coalesce(@UPhone,[UPhone]),  
      [UMobile] =coalesce(@UMobile,[UMobile]),    
      [UCity] =coalesce(@UCity,[UCity]),  
      [UOffAdd] =coalesce(@UOffAdd,[UOffAdd]),  
      --[UEmail] =@UEmail,  
      --[UPwd] =@UPwd,  
      [UUName] =coalesce(@UUName,[UUName]),    
      [UTlicns] =coalesce(@UTlicns,[UTlicns]),  
      [URole] =coalesce(@URole,[URole]),  
      [UMdDt] =getdate(),
      [UMdBy] =@UMdBy 
 
  where [UEmail] =@UEmail
END



if lower(@RequestType)='updatetouser'
begin    

set @UTlicns = case when @UTlicns ='' then null else @UTlicns end

UPDATE [dbo].[User]
   SET [UCName] = coalesce(@UCName,UCName),
      [UCPName] =coalesce(@UCPName,[UCPName]),  
      [UPhone] = coalesce(@UPhone,[UPhone]),  
      [UMobile] =coalesce(@UMobile,[UMobile]),    
      [UCity] =coalesce(@UCity,[UCity]),  
      [UOffAdd] =coalesce(@UOffAdd,[UOffAdd]),  
      [UEmail] =@UEmail,  
      --[UPwd] =@UPwd,  
      [UUName] =coalesce(@UUName,[UUName]),    
      [UTlicns] =coalesce(@UTlicns,[UTlicns]),  
      [URole] =coalesce(@URole,[URole]),  
      [UMdDt] =getdate(),
      [UMdBy] =@UMdBy 
 
  where [UID]=@UID
END


if lower(@RequestType)='passwordreset'
begin  
UPDATE [dbo].[User]
   SET  
      [UPwd] =@UPwd,   
      [UMdDt] =getdate(),
      [UMdBy] =@UMdBy 
 
  where [UEmail] =@UEmail
END


if lower(@RequestType)=lower('GetMyPWD')
begin  
SELECT [UPwd]
  FROM [dbo].[User]   with (nolock)
  where [UEmail]=@UEmail 
END
GO
