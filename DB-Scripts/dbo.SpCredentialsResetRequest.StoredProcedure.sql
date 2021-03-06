USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SpCredentialsResetRequest]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SpCredentialsResetRequest]
GO
/****** Object:  StoredProcedure [dbo].[SpCredentialsResetRequest]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--		SpCredentialsResetRequest @email='admin@gmail.com', @RequestType='Add'


CREATE proc [dbo].[SpCredentialsResetRequest]
@id nvarchar(50)=null, 
@email nvarchar(50)=null, 
@Pwd nvarchar(50)=null, 
@created date=null,
@status nvarchar(50)=null,
@remarks nvarchar(250)=null,
@updatedby nvarchar(50)=null, 

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

if lower(@RequestType)=lower('add')
begin

INSERT INTO [dbo].[CredentialsResetRequest]
           ([email]
           ,[created],
		   [status])
     VALUES
           (@email,
		   getdate(),
		   coalesce(@status,'requested'))
end


if lower(@RequestType)=lower('GetAll')
begin  


 set @WhereClouse = case when @id = '0' then ' 1=1 ' else ' id='''+ @id+'''' end;

 if(lower(@ColName) !='all')
	 begin 
		set @WhereClouse = @WhereClouse + ' and '+ @ColName +'='''+@FilterValue+''''
	 end 
  
 set @OrderBy = case when @OrderBy is null then ' 1  ' else ' '+ @OrderBy+' ' end;
 set @ShortOrder = case when @ShortOrder is null then ' desc ' else ' '+ @ShortOrder+' ' end;
 
print 3
  print (@WhereClouse)
  print (@OrderBy)
  print (@ShortOrder)

set @query=N'SELECT 
		[id]
      ,[email]
      ,convert(varchar(10),[created],103) created
      ,[status]
      ,[remarks]
      ,[updatedby]
      ,convert(varchar(10),[updated],103) updated
  FROM [dbo].[CredentialsResetRequest] 
  where '+ @WhereClouse +'
  order by '+ @OrderBy +' '+  @ShortOrder

  print (@query)
  exec (@query)

end


if lower(@RequestType)=lower('GetOne')
begin  
 
SELECT [id]
      ,[email]
      ,convert(varchar(10),[created],103) created
      ,[status]
      ,[remarks]
      ,[updatedby]
      ,convert(varchar(10),[updated],103) updated
  FROM [dbo].[CredentialsResetRequest]
  where id=@id  order by id desc
end


if lower(@RequestType)=lower('Delete')
begin  
DELETE  [dbo].[CredentialsResetRequest]
  where id=@id
end

if lower(@RequestType)=lower('Update')
begin 

if(exists (select 1 from [dbo].[User] where UEmail=@email ))
begin
		UPDATE [dbo].[CredentialsResetRequest]
		   SET  [status] = @status,
		[remarks]= @remarks,
		[updatedby]=@updatedby,
		updated=getdate()
		  where id=@id

		UPDATE [dbo].[User]
		   SET  [UPwd]=@Pwd,
		[UMdBy]=@updatedby,
		[UMdDt]=getdate()
		  where [UEmail]=@email
end

else
	begin
		return 0
	end

end
GO
