/*** создание FT каталога с оптимизацией (на другом диске) ***/
USE master
GO
ALTER DATABASE patscape ADD FILEGROUP FT_FILEGROUP
GO

-- здесь указать каталог на другом диске по отношению к диску, на котором лежит основная база patscape
ALTER DATABASE patscape 
	ADD FILE (NAME = N'patscape_ft', 
				FILENAME = N'C:\MSSQL\FT\patscape_ft.mdf', 
				SIZE = 10240KB, 
				FILEGROWTH = 5120KB) 
	TO FILEGROUP FT_FILEGROUP
GO

USE patscape
GO

CREATE FULLTEXT CATALOG tls_ft 
	ON FILEGROUP FT_FILEGROUP
	WITH ACCENT_SENSITIVITY = OFF
	AS DEFAULT
GO

/*** создание индексов 
CREATE FULLTEXT INDEX ON tls203_appln_abstr_en
	(   
	  appln_abstract  
		 Language English     
		STATISTICAL_SEMANTICS 
	 ) 
  KEY INDEX PK_tls203_appln_abstr_en
  ON tls_ft
  WITH STOPLIST = SYSTEM, CHANGE_TRACKING OFF, NO POPULATION;
GO

ALTER FULLTEXT INDEX ON tls203_appln_abstr_en 
   START UPDATE POPULATION;
GO
***/

/*
-- проверка статуса процесса создания FT индекса
DECLARE @CatalogName VARCHAR(MAX)
SET     @CatalogName = 'tls_ft'

SELECT
    DATEADD(ss, FULLTEXTCATALOGPROPERTY(@CatalogName,'PopulateCompletionAge'), '1/1/1990') AS LastPopulated
    ,(SELECT CASE FULLTEXTCATALOGPROPERTY(@CatalogName,'PopulateStatus')
        WHEN 0 THEN 'Idle'
        WHEN 1 THEN 'Full Population In Progress'
        WHEN 2 THEN 'Paused'
        WHEN 3 THEN 'Throttled'
        WHEN 4 THEN 'Recovering'
        WHEN 5 THEN 'Shutdown'
        WHEN 6 THEN 'Incremental Population In Progress'
        WHEN 7 THEN 'Building Index'
        WHEN 8 THEN 'Disk Full.  Paused'
        WHEN 9 THEN 'Change Tracking' END) AS PopulateStatus;
--SELECT OBJECTPROPERTY(object_id('tls203_appln_abstr'), 'TableFulltextPopulateStatus')

select * from sys.dm_fts_index_population;
GO
*/

/*
--статистика термов в FT индексе
SELECT display_term, count(*)
FROM sys.dm_fts_index_keywords_by_document(db_id('patscape'), object_id('tls203_appln_abstr_en'))
group by display_term
order by count(*) desc; 
*/