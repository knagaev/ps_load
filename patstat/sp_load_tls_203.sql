use patscape
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Константин Нагаев
-- Create date: 15.04.2014
-- Description:	Загрузка tls_203 Patstat
-- =============================================
CREATE PROCEDURE SP_LOAD_TLS_203 
	@lang varchar(2),
	@datafile varchar(255) = 'C:\PLR\patstat\tls\processed', 
	@formatfile varchar(255) = 'C:\PLR\ps_load\patstat\fmt\tls203.fmt' 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @SQLString VARCHAR(MAX)
	SET @SQLString = 'BULK INSERT [dbo].tls203_appln_abstr_' + @lang + '
		FROM ''' + @datafile + '\tls203_' + @lang + '.txt''
		WITH
		(
		BATCHSIZE = 20000, 
		DATAFILETYPE = ''char'',
		FORMATFILE = ''' + @formatfile + '''
		)
		';

	--select @SQLString
	exec (@SQLString) 

END
GO
