USE patscape
GO

/****** Object:  Table [dbo].[tls206_person]    Script Date: 02/03/2016 08:18:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls206_person](
	[person_id] [int] NOT NULL DEFAULT ('0'),
	[person_name] [nvarchar](500) NOT NULL DEFAULT (''),
	[person_address] [nvarchar](1000) NOT NULL DEFAULT (''),
	[person_ctry_code] [char](2) NOT NULL DEFAULT (''),
	[doc_std_name_id] [int] NOT NULL DEFAULT ('0'),
	[doc_std_name] [nvarchar](500)  NOT NULL DEFAULT (''),
	[psn_id] [int] NOT NULL DEFAULT ('0'),
	[psn_name] [nvarchar](500) NOT NULL DEFAULT (''),
	[psn_level] [tinyint] NOT NULL DEFAULT ('0'),
	[psn_sector] [varchar](50) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[person_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls205_tech_rel]
		FROM 'C:\PLR\Patstat\tls\processed\tls206.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls206.fmt'
		)
GO
