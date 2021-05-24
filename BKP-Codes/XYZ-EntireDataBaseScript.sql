USE [xyzdb]
GO
/****** Object:  StoredProcedure [dbo].[SPUser]    Script Date: 5/22/2021 5:25:47 PM ******/
DROP PROCEDURE [dbo].[SPUser]
GO
/****** Object:  StoredProcedure [dbo].[SPEvent]    Script Date: 5/22/2021 5:25:47 PM ******/
DROP PROCEDURE [dbo].[SPEvent]
GO
/****** Object:  StoredProcedure [dbo].[SPEnquiry]    Script Date: 5/22/2021 5:25:47 PM ******/
DROP PROCEDURE [dbo].[SPEnquiry]
GO
/****** Object:  StoredProcedure [dbo].[SpCredentialsResetRequest]    Script Date: 5/22/2021 5:25:47 PM ******/
DROP PROCEDURE [dbo].[SpCredentialsResetRequest]
GO
/****** Object:  StoredProcedure [dbo].[SPAttendee]    Script Date: 5/22/2021 5:25:47 PM ******/
DROP PROCEDURE [dbo].[SPAttendee]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/22/2021 5:25:47 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
DROP TABLE [dbo].[User]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 5/22/2021 5:25:47 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Event]') AND type in (N'U'))
DROP TABLE [dbo].[Event]
GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 5/22/2021 5:25:47 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Enquiry]') AND type in (N'U'))
DROP TABLE [dbo].[Enquiry]
GO
/****** Object:  Table [dbo].[CredentialsResetRequest]    Script Date: 5/22/2021 5:25:47 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CredentialsResetRequest]') AND type in (N'U'))
DROP TABLE [dbo].[CredentialsResetRequest]
GO
/****** Object:  Table [dbo].[Attendee]    Script Date: 5/22/2021 5:25:47 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attendee]') AND type in (N'U'))
DROP TABLE [dbo].[Attendee]
GO
USE [master]
GO
/****** Object:  Database [xyzdb]    Script Date: 5/22/2021 5:25:47 PM ******/
DROP DATABASE [xyzdb]
GO
/****** Object:  Database [xyzdb]    Script Date: 5/22/2021 5:25:47 PM ******/
CREATE DATABASE [xyzdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'xyzdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\xyzdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'xyzdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\xyzdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [xyzdb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [xyzdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [xyzdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [xyzdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [xyzdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [xyzdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [xyzdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [xyzdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [xyzdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [xyzdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [xyzdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [xyzdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [xyzdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [xyzdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [xyzdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [xyzdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [xyzdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [xyzdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [xyzdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [xyzdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [xyzdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [xyzdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [xyzdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [xyzdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [xyzdb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [xyzdb] SET  MULTI_USER 
GO
ALTER DATABASE [xyzdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [xyzdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [xyzdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [xyzdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [xyzdb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [xyzdb] SET QUERY_STORE = OFF
GO
USE [xyzdb]
GO
/****** Object:  Table [dbo].[Attendee]    Script Date: 5/22/2021 5:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendee](
	[EAID] [int] IDENTITY(1,1) NOT NULL,
	[EACN] [nvarchar](50) NULL,
	[EAName] [nvarchar](50) NULL,
	[EAEmail] [nvarchar](50) NULL,
	[EMID] [int] NULL,
	[EAAddedBy] [nvarchar](50) NULL,
	[UCrDt] [smalldatetime] NULL,
	[UCrBy] [nvarchar](50) NULL,
	[EMMdDt] [date] NULL,
	[EMMdBy] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CredentialsResetRequest]    Script Date: 5/22/2021 5:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CredentialsResetRequest](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](50) NULL,
	[created] [date] NULL,
	[status] [nvarchar](50) NULL,
	[remarks] [nvarchar](250) NULL,
	[updatedby] [nvarchar](50) NULL,
	[updated] [date] NULL,
 CONSTRAINT [PK_CredentialsResetRequest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 5/22/2021 5:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EEID] [int] IDENTITY(1,1) NOT NULL,
	[EECname] [nvarchar](max) NULL,
	[EECPName] [nvarchar](13) NULL,
	[EECNumber] [nvarchar](30) NOT NULL,
	[EEEmail] [nvarchar](50) NOT NULL,
	[EEMessage] [nvarchar](max) NOT NULL,
	[EEstatus] [nvarchar](10) NOT NULL,
	[EERemark] [nvarchar](max) NULL,
	[EECreated] [date] NULL,
	[EECreatedBy] [nvarchar](50) NULL,
	[EEUpdated] [date] NULL,
	[EEUpdatedBy] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 5/22/2021 5:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[EMID] [int] IDENTITY(1,1) NOT NULL,
	[EMName] [nvarchar](50) NULL,
	[EMCoverImg] [nvarchar](max) NULL,
	[EMType] [nvarchar](50) NULL,
	[EMDescription] [nvarchar](250) NULL,
	[EMMaxCap] [int] NULL,
	[EMDate] [date] NULL,
	[EMTime] [time](7) NULL,
	[EMCity] [nvarchar](50) NULL,
	[EMArea] [nvarchar](100) NULL,
	[EMLocDesc] [nvarchar](300) NULL,
	[EMLocLink] [nvarchar](max) NULL,
	[EMCode] [nvarchar](50) NULL,
	[EMStsID] [int] NULL,
	[EMUID] [int] NULL,
	[EMMBUID] [int] NULL,
	[EMRecSts] [bit] NULL,
	[UCrDt] [smalldatetime] NULL,
	[UCrBy] [nvarchar](50) NULL,
	[EMMdDt] [date] NULL,
	[EMMdBy] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/22/2021 5:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[UCName] [nvarchar](max) NULL,
	[UCPName] [nvarchar](100) NULL,
	[UPhone] [nvarchar](20) NULL,
	[UMobile] [nvarchar](20) NULL,
	[UCity] [nvarchar](50) NULL,
	[UOffAdd] [nvarchar](max) NULL,
	[UEmail] [nvarchar](50) NULL,
	[UPwd] [nvarchar](30) NULL,
	[UUName] [nvarchar](12) NULL,
	[UTlicns] [nvarchar](200) NULL,
	[URole] [nvarchar](50) NULL,
	[UCrDt] [smalldatetime] NULL,
	[UCrBy] [nvarchar](12) NULL,
	[UMdDt] [smalldatetime] NULL,
	[UMdBy] [nvarchar](12) NULL,
PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SPAttendee]    Script Date: 5/22/2021 5:25:48 PM ******/
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

--	SPAttendee @RequestType='GetAll'

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
/****** Object:  StoredProcedure [dbo].[SpCredentialsResetRequest]    Script Date: 5/22/2021 5:25:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--		SpCredentialsResetRequest @email='admin@gmail.com', @RequestType='Add'


CREATE proc [dbo].[SpCredentialsResetRequest]
@email nvarchar(50)=null,
@created date=null,
@status nvarchar(50)=null,
@remarks nvarchar(250)=null,
@updatedby nvarchar(50)=null, 
@RequestType nvarchar(15)
 
 as
if @RequestType='Add'
begin
INSERT INTO [dbo].[CredentialsResetRequest]
           ([email]
           ,[created])
     VALUES
           (@email,
		   getdate())
end


if @RequestType='GetAll'
begin  
SELECT *
  FROM [dbo].[CredentialsResetRequest] order by id desc
end


if @RequestType='GetOne'
begin  
 
SELECT *
  FROM [dbo].[CredentialsResetRequest]
  where email=@email  order by id desc
end


if @RequestType='Delete'
begin  
DELETE  [dbo].[CredentialsResetRequest]
  where email=@email
end

if @RequestType='Update'
begin 
UPDATE [dbo].[CredentialsResetRequest]
   SET  [status] = @status,
[remarks]= @remarks,
[updatedby]=@updatedby,
updated=getdate()
  where email=@email
end
GO
/****** Object:  StoredProcedure [dbo].[SPEnquiry]    Script Date: 5/22/2021 5:25:48 PM ******/
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

@RequestType nvarchar(15)

as

if @RequestType='Add'
begin
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
           @EECreatedBy)
END

if @RequestType='GetAll'
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
END

if @RequestType='GetOne'
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
 
if @RequestType='Delete'
begin  
DELETE FROM [dbo].[Enquiry] 
  where EEID=@EEID
END

 
if @RequestType='Update'
begin   
UPDATE [dbo].[Enquiry]
   SET 
      [EEstatus] = @EEstatus,  
      [EERemark] = @EERemark ,
      [EEUpdated] =  getdate(),
      [EEUpdatedBy] = @EEUpdatedBy
 
  where EEID=@EEID
END


GO
/****** Object:  StoredProcedure [dbo].[SPEvent]    Script Date: 5/22/2021 5:25:48 PM ******/
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



if @RequestType='GetAll'
begin 
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
  order by '+@OrderBy +' '+  @ShortOrder
  
  
--	SPEvent @OrderBy='EMName',@ShortOrder='asc', @RequestType='GetAll'
    
  print(@query)
  exec(@query)
END


-- exec SPEvent @RequestType=N'GetOne',@OrderBy=N'ASC',@EMID=N'4'

if lower(@RequestType)='getone'
begin 
print(1)
print(@EMID)
print(@OrderBy)
print(@ShortOrder)

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
  where   EMID='''+ @EMID +''' 
  order by '+@OrderBy +' '+  @ShortOrder

  
  print(@query)

-- 
  exec(@query)
END



if lower(@RequestType)=lower('GetFiltered')
		begin  
		declare @filtercondition nvarchar(max)

		if( lower(@ColName)=lower('EMName') or  lower(@ColName)=lower('EMDescription')  or  lower(@ColName)=lower('EMCity') )
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

  


		--	SPUser @ColName='UCName', @FilterValue='User',   @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetFiltered'

		--	SPUser @ColName='UMobile', @FilterValue='798669',   @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetFiltered'

		--	SPUser @ColName='UPhone', @FilterValue='9797',   @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetFiltered'

		  exec( @query + @filtercondition)
END

 
if @RequestType='Delete'
begin   
DELETE FROM [dbo].[Event] 
  where EMID=@EMID
END

 
GO
/****** Object:  StoredProcedure [dbo].[SPUser]    Script Date: 5/22/2021 5:25:48 PM ******/
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

if @RequestType='Add'
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
  where   UEMail='''+@UEmail+''' 
  order by '+@OrderBy +' '+  @ShortOrder


--	SPUser  @UEmail='user@gmail.com' , @OrderBy='UCPName',@ShortOrder='asc', @RequestType='GetOne'

  print(@query)
  exec(@query)
END

if @RequestType='GetMyMailId'
begin  
SELECT *
  FROM [dbo].[User]   with (nolock)
  where [UEmail]=@UEmail 
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
UPDATE [dbo].[User]
   SET [UCName] =@UCName,  
      [UCPName] =@UCPName,  
      [UPhone] =@UPhone, 
      [UMobile] =@UMobile,  
      [UCity] =@UCity,  
      [UOffAdd] =@UOffAdd,  
      [UEmail] =@UEmail,  
      [UPwd] =@UPwd,  
      [UUName] =@UUName,  
      [UTlicns] =@UTlicns,  
      [URole] =@URole,  
      [UMdDt] =getdate(),
      [UMdBy] =@UMdBy 
 
  where [UEmail] =@UEmail
END
GO
USE [master]
GO
ALTER DATABASE [xyzdb] SET  READ_WRITE 
GO
