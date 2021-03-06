USE patscape
GO

/****** Object:  Table [dbo].[tls901_techn_field_ipc]    Script Date: 07/07/2015 08:13:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls901_techn_field_ipc](
	[ipc_maingroup_symbol] [varchar](8) NOT NULL DEFAULT (''),
	[techn_field_nr] [tinyint] NOT NULL DEFAULT ('0'),
	[techn_sector] [varchar](50) NOT NULL DEFAULT (''),
	[techn_field] [varchar](50) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[ipc_maingroup_symbol] ASC	
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls901_techn_field_ipc]
		FROM 'C:\PLR\Patstat\tls\processed\tls901.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls901.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls901.fmt'
		)
GO
