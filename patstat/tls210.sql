USE patscape
GO

/****** Object:  Table [dbo].[tls210_appln_n_cls]    Script Date: 07/07/2015 08:19:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls210_appln_n_cls](
	[appln_id] [int] NOT NULL DEFAULT ('0'),
	[nat_class_symbol] [varchar](15) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[appln_id] ASC,
	[nat_class_symbol] ASC
)WITH (IGNORE_DUP_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

BULK INSERT [dbo].[tls210_appln_n_cls]
		FROM 'C:\PLR\Patstat\tls\processed\tls210.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls210.fmt'
		)
GO
