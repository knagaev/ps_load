CREATE FULLTEXT INDEX ON tls206_person
(   
  person_name,
  doc_std_name,
  psn_name
 ) 
  KEY INDEX PK_tls206_person
  ON tls_ft
  WITH STOPLIST = SYSTEM, CHANGE_TRACKING OFF, NO POPULATION;
GO                

ALTER FULLTEXT INDEX ON tls206_person
              START FULL POPULATION;
GO

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
--SELECT OBJECTPROPERTY(object_id('tls206_person'), 'TableFulltextPopulateStatus')

select * from sys.dm_fts_index_population;
GO
*/
