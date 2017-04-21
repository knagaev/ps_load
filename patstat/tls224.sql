USE patscape
GO

/****** Object:  Table [dbo].[tls224_appln_cpc]    Script Date: 07/07/2015 04:32:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tls224_appln_cpc](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[cpc_class_symbol] [varchar](19) NOT NULL DEFAULT (''),
	[cpc_scheme] [varchar](5) NOT NULL DEFAULT (''),
	[cpc_version] [date] NOT NULL DEFAULT ('9999-12-31'),
	[cpc_value] [char](1) NOT NULL DEFAULT (''),
	[cpc_position] [char](1) NOT NULL DEFAULT (''),
	[cpc_gener_auth] [char](2) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[appln_id] ASC,
	[cpc_class_symbol] ASC,
	[cpc_scheme] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

BULK INSERT [dbo].[tls224_appln_cpc]
		FROM 'C:\PLR\Patstat\tls\processed\tls224.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls224.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls224.fmt'
		)
GO

