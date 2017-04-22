USE [patscape]
GO

/****** Object:  Table [dbo].[tls801_country]    Script Date: 07/07/2015 08:13:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls801_country](
	[ctry_code] [char](2) NOT NULL DEFAULT (''),
	[iso_alpha3] [char](3) NOT NULL DEFAULT (''),
	[st3_name] [varchar](100) NOT NULL DEFAULT (''),
	[state_indicator] [char](1) NOT NULL DEFAULT (''),
	[continent] [varchar](25) NOT NULL DEFAULT (''),
	[eu_member] [char](1) NOT NULL DEFAULT (''),
	[epo_member] [char](1) NOT NULL DEFAULT (''),
	[oecd_member] [char](1) NOT NULL DEFAULT (''),
	[discontinued] [char](1) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[ctry_code] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls801_country]
		FROM 'C:\PLR\Patstat\tls\processed\tls801.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls801.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls801.fmt'
		)
GO
