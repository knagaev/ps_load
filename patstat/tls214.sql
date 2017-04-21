USE patscape
GO

/****** Object:  Table [dbo].[tls214_npl_publn]    Script Date: 02/03/2016 08:20:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls214_npl_publn](
	[npl_publn_id] [int] NOT NULL DEFAULT ('0'),
	[npl_type] [char](1) NOT NULL DEFAULT (''),
	[npl_biblio] [nvarchar](max) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[npl_publn_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


BULK INSERT [dbo].[tls214_npl_publn]
		FROM 'C:\PLR\Patstat\tls\processed\tls214.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls214.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls214.fmt'
		)
GO
