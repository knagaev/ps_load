USE [patstat2016b]
GO
/****** Object:  Table [dbo].[tls202_appln_title]    Script Date: 07/07/2015 08:16:03 ******/
/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP TABLE [dbo].[tls202_appln_title_ru]
GO
CREATE TABLE [dbo].[tls202_appln_title_ru](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[appln_title_lg] [char](2) NOT NULL DEFAULT (''),
	[appln_title] [varchar](max) COLLATE Cyrillic_General_CI_AS NOT NULL ,
) ON [PRIMARY]


truncate table [dbo].tls202_appln_title_ru
GO

BULK INSERT [dbo].tls202_appln_title_ru
FROM 'C:\work\others\Patstat\test_ru.txt'
WITH
(
--FIELDTERMINATOR ='"',  
--ROWTERMINATOR = '\n',  
--FIRSTROW = 3,
--DATAFILETYPE = 'char',
FORMATFILE = 'C:\work\others\Patstat\tls202_part01.fmt'
--,TABLOCK
)
GO

ALTER TABLE [dbo].tls202_appln_title_ru
ADD CONSTRAINT PK_tls202_appln_title_ru PRIMARY KEY CLUSTERED (appln_id);
*/

SELECT TOP 1000 [appln_id]
      ,[appln_title_lg]
      ,[appln_title]
  FROM [patstat2016b].[dbo].[tls202_appln_title_ru];
GO

select * from [patstat2016b].[dbo].[tls202_appln_title_ru]
where CONTAINS(appln_title, 'FORMSOF(INFLECTIONAL, "������")');
GO