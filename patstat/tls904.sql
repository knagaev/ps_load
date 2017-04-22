USE patscape
GO

/****** Object:  Table [dbo].[tls904_nuts]    Script Date: 10/19/2016 18:13:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls904_nuts](
	[nuts3] [varchar](5) NOT NULL DEFAULT (''),
	[nuts3_name] [varchar](250) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[nuts3] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls904_nuts]
		FROM 'C:\PLR\Patstat\tls\processed\tls904.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls904.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls904.fmt'
		)
GO
