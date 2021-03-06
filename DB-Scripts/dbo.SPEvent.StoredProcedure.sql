USE [Event]
GO
/****** Object:  StoredProcedure [dbo].[SPEvent]    Script Date: 6/2/2021 6:10:56 PM ******/
DROP PROCEDURE [dbo].[SPEvent]
GO
/****** Object:  StoredProcedure [dbo].[SPEvent]    Script Date: 6/2/2021 6:10:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SPEvent]
@EMID nvarchar(50) = null,
@EMName nvarchar(50) = null,
@EMCoverImg nvarchar(max) = null,
@EMType nvarchar(50) = null,
@EMDescription nvarchar(250) = null,
@EMMaxCap int =0,
@EMDate date=null,
@EMTime time(7) = null,
@EMCity nvarchar(50) = null,
@EMArea nvarchar(100) = null,
@EMLocDesc nvarchar(300) = null,
@EMLocLink nvarchar(max) = null,
@EMCode nvarchar(50) = null,
@EMStsID int=0,
@EMUID int=0,
@EMMBUID int=0,
@EMRecSts bit=false,
@UCrDt smalldatetime=null,
@UCrBy nvarchar(50) = null,
@EMMdDt date=null,
@EMMdBy nvarchar(50) = null,  
@OrderBy nvarchar(50)=null,  
@ShortOrder nvarchar(50)=null, 
@ColName nvarchar(50)=null, 
@FilterValue nvarchar(50)=null, 

@RequestType nvarchar(30)

as

declare @query nvarchar(max)
declare @WhereClouse nvarchar(200)
declare @filtercondition nvarchar(max)

------------------------------// New Record Proc

if lower(@RequestType)='add' or lower(@RequestType)='update'
begin 
if(EXISTS (SELECT 1 FROM Event WHERE EMID= CONVERT(int, @EMID)
))
begin  
print('update Entered')

UPDATE [dbo].[Event]
   SET [EMName] =@EMName,  
      [EMCoverImg] =coalesce(@EMCoverImg, [EMCoverImg]), 
      [EMType] =coalesce(@EMType, [EMType]), 
      [EMDescription]  = coalesce(@EMDescription, [EMDescription]),   
      [EMMaxCap] = coalesce(@EMMaxCap, [EMMaxCap]),  
      [EMDate] =  coalesce(CONVERT(date,@EMDate,103), [EMDate]),    
      [EMTime] =coalesce(@EMTime, [EMTime]),   
      [EMCity] =coalesce(@EMCity, [EMCity]),    
      [EMArea] = coalesce(@EMArea, [EMArea]), 
      [EMLocDesc] =@EMLocDesc, 
      [EMLocLink] =@EMLocLink, 
      [EMCode] =@EMCode,  
      [EMStsID] =@EMStsID,  
      [EMUID] =@EMUID,  
      [EMMBUID] =@EMMBUID,  
      [EMRecSts] =@EMRecSts,     
      [EMMdDt] =getdate(),  
      [EMMdBy] =@EMMdBy 
  where EMID=@EMID 
 
end
else
begin

print('Add Entered')
INSERT INTO [dbo].[Event]
           ([EMName]
           ,[EMCoverImg]
           ,[EMType]
           ,[EMDescription]
           ,[EMMaxCap]
           ,[EMDate]
           ,[EMTime]
           ,[EMCity]
           ,[EMArea]
           ,[EMLocDesc]
           ,[EMLocLink]
           ,[EMCode]
           ,[EMStsID]
           ,[EMUID]
           ,[EMMBUID]
           ,[EMRecSts]
           ,[UCrDt]
           ,[UCrBy])
     VALUES
           (@EMName,  
           @EMCoverImg,  
           @EMType,  
           @EMDescription,  
           @EMMaxCap,  
           CONVERT(date,@EMDate,103),
           CONVERT(time, @EMTime),  
           @EMCity,  
           @EMArea,  
           @EMLocDesc,  
           @EMLocLink,  
           @EMCode,  
           @EMStsID,  
           @EMUID,  
           @EMMBUID,  
           @EMRecSts,  
           getdate(),
           @UCrBy)
 
end

end
------------------------------// New Record Proc

--	SPEvent @RequestType='GetAll', @UCrBy = 'admin@gmail.com', @OrderBy='EMName',@ShortOrder=' asc'
 
if @RequestType='GetAll'
begin 


  set @WhereClouse = case when @UCrBy = 'admin@gmail.com' then ' 1=1 ' else ' UCrBy='''+ @UCrBy+'''' end;


  print(@WhereClouse);

set @query=N'select [EMID]
		   ,[EMName]
           ,[EMCoverImg]
           ,[EMType]
           ,[EMDescription]
           ,[EMMaxCap]
           ,
		    CONVERT(VARCHAR(10), [EMDate],103) EMDate
           , convert(varchar, [EMTime], 8) EMTime
           ,[EMCity]
           ,[EMArea]
           ,[EMLocDesc]
           ,[EMLocLink]
           ,[EMCode]
           ,[EMStsID]
           ,[EMUID]
           ,[EMMBUID]
           ,[EMRecSts]
           ,[UCrDt]
           ,[UCrBy]
  FROM [dbo].[Event] 
  where '+ @WhereClouse +'
  order by '+@OrderBy +' '+  @ShortOrder
  
  
--	SPEvent @OrderBy='EMName',@ShortOrder='asc', @RequestType='GetAll'
    
  print(@query)
  exec(@query)
END


-- exec SPEvent @RequestType=N'GetOne',@OrderBy=N'ASC',@EMID=N'4', @UCrBy = 'user@gmail.com'

if lower(@RequestType)='getone'
begin 
print(1)
print(@EMID)
print(@OrderBy)
print(@ShortOrder) 

  set @WhereClouse = case when @UCrBy = 'admin@gmail.com' then ' and 1=1 ' else ' and UCrBy='''+ @UCrBy+''' ' end;

  
-- exec SPEvent @RequestType=N'GetOne',@OrderBy=N'EMName',@EMID=N'4', @UCrBy = 'admin@gmail.com', @ShortOrder ='asc'

  print(@WhereClouse);
set @query='select [EMID]
		   ,[EMName]
           ,[EMCoverImg]
           ,[EMType]
           ,[EMDescription]
           ,[EMMaxCap]
           ,
		    CONVERT(VARCHAR(10), [EMDate],103) EMDate
           , convert(varchar, [EMTime], 8) EMTime
           ,[EMCity]
           ,[EMArea]
           ,[EMLocDesc]
           ,[EMLocLink]
           ,[EMCode]
           ,[EMStsID]
           ,[EMUID]
           ,[EMMBUID]
           ,[EMRecSts]
           ,[UCrDt]
           ,[UCrBy]
  FROM [dbo].[Event] 
  where   EMID='''+ @EMID +''' --'+@WhereClouse+' 
  order by '+@OrderBy +' '+  @ShortOrder

  
  print(@query)

-- 
  exec(@query)
END



if lower(@RequestType)=lower('GetFiltered')
		begin  
		

		--	SPEvent @ColName='EMName', @FilterValue='eve',   @OrderBy='EMName',@ShortOrder='asc', @RequestType='GetFiltered', @UCrBy = 'admin@gmail.com'

		--	SPEvent @ColName='EMName', @FilterValue='eve',   @OrderBy='EMName',@ShortOrder='asc', @RequestType='GetFiltered', @UCrBy = 'admin@gmail.com'
		
		--	SPEvent @ColName='EMName', @FilterValue='ev',   @OrderBy='EMName',@ShortOrder='asc', @RequestType='GetFiltered', @UCrBy = 'user@gmail.com'

		--	SPEvent @ColName='all', @OrderBy='EMName',@ShortOrder='asc', @RequestType='GetFiltered', @UCrBy = 'user@gmail.com'

	 
		set @WhereClouse = case when @UCrBy = 'admin@gmail.com' then '  1=1 ' else ' UCrBy='''+ @UCrBy+''' ' end;
		-------------------------------
		if( lower(@ColName)=lower('EMName') or  lower(@ColName)=lower('EMDescription')  or  lower(@ColName)=lower('EMCity') )
		begin
		set @filtercondition ='  where '+@ColName+' like ''%'+@FilterValue+'%''  and '+  @WhereClouse +'  order by '+@OrderBy +' '+  @ShortOrder
		end
		else if lower(@ColName)=lower('all')
		begin 
		set  @filtercondition ='   where '+  @WhereClouse +'  order by ' + @OrderBy +' '+  @ShortOrder
		end
		else  
		begin 
		set @filtercondition =' where '+ @ColName+'='''+@FilterValue+'''  and '+  @WhereClouse +'  order by '+@OrderBy +' '+  @ShortOrder
		end
		-------------------------------
		print (@filtercondition)



		set @query='select [EMID]
		   ,[EMName]
           ,[EMCoverImg]
           ,[EMType]
           ,[EMDescription]
           ,[EMMaxCap]
           ,
		    CONVERT(VARCHAR(10), [EMDate],103) EMDate
           , convert(varchar, [EMTime], 8) EMTime
           ,[EMCity]
           ,[EMArea]
           ,[EMLocDesc]
           ,[EMLocLink]
           ,[EMCode]
           ,[EMStsID]
           ,[EMUID]
           ,[EMMBUID]
           ,[EMRecSts]
           ,[UCrDt]
           ,[UCrBy]
		  FROM [dbo].[Event]  '
		  print( @query + @filtercondition )

  


		  exec( @query + @filtercondition)
END

 
if @RequestType='Delete'
begin   
DELETE FROM [dbo].[Event] 
  where EMID=@EMID
END

 
GO
