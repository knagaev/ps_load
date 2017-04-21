USE patscape
GO

/****** Object:  Table [dbo].[tls215_citn_categ]    Script Date: 07/07/2015 08:21:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls215_citn_categ](
	[pat_publn_id] [int] NOT NULL DEFAULT ('0'),
	[citn_id] [smallint] NOT NULL DEFAULT ('0'),
	[citn_categ] [char](1) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[pat_publn_id] ASC,
	[citn_id] ASC,
	[citn_categ] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls215_citn_categ]
		FROM 'C:\PLR\Patstat\tls\processed\tls215.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls215.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls215.fmt'
		)
GO
