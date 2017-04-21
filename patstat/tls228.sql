USE patscape
GO

/****** Object:  Table [dbo].[tls228_docdb_fam_citn]    Script Date: 07/07/2015 18:32:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls228_docdb_fam_citn](
	[docdb_family_id] [int] NOT NULL DEFAULT ('0'),
	[cited_docdb_family_id] [int] NOT NULL DEFAULT ('0'),
PRIMARY KEY CLUSTERED 
(
	[docdb_family_id] ASC,
	[cited_docdb_family_id] ASC
)WITH (IGNORE_DUP_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]

BULK INSERT [dbo].[tls228_docdb_fam_citn]
		FROM 'C:\PLR\Patstat\tls\processed\tls228.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls228.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls228.fmt'
		)
GO
