USE patscape
GO
/****** Object:  Table [dbo].[tls802_legal_event_code]    Script Date: 07/07/2015 08:13:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tls802_legal_event_code](
	[lec_id] [smallint] NOT NULL DEFAULT ('0'),
	[auth_cc] [varchar](2) NOT NULL DEFAULT (''),
	[lec_name] [varchar](4) NOT NULL DEFAULT (''),
	[nat_auth_cc] [varchar](2) NOT NULL DEFAULT (''),
	[nat_lec_name] [varchar](4) NOT NULL DEFAULT (''),
	[impact] [varchar](1) NOT NULL DEFAULT (''),
	[lec_descr] [varchar](250) NOT NULL DEFAULT (''),
	[lecg_id] [tinyint] NOT NULL DEFAULT ('0'),
	[lecg_name] [varchar](6) NOT NULL DEFAULT (''),
	[lecg_descr] [varchar](150) NOT NULL DEFAULT (''),
PRIMARY KEY CLUSTERED 
(
	[lec_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

BULK INSERT [dbo].[tls802_legal_event_code]
		FROM 'C:\PLR\Patstat\tls\processed\tls802.txt'
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = 'char',
		ERRORFILE = 'C:\PLR\Patstat\tls\bad_tls802.txt',
		FORMATFILE = 'C:\PLR\ps_load\patstat\fmt\tls802.fmt'
		)
GO
