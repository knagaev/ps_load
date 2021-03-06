USE [patscape]
GO

-- sp_create_table_tls_202 'ru'

-- truncate table [tls202_appln_title_ru];

INSERT INTO patscape.[dbo].[tls202_appln_title_ru]([appln_id], [appln_title])
SELECT appln_id, appln_title
  FROM [patstat2016a].[dbo].[tls202_appln_title]
  where appln_title_lg like 'ru';

-- sp_create_ft_tls_202 'ru'
-- sp_populate_ft_tls_202 'ru'

-- sp_create_table_tls_203 'ru'

-- truncate table [tls203_appln_abstr_ru];

INSERT INTO patscape.[dbo].[tls203_appln_abstr_ru]([appln_id], [appln_abstract])
  SELECT appln_id, appln_abstract
  FROM [patstat2016a].[dbo].[tls203_appln_abstr]
  where appln_abstract_lg like 'ru';

-- sp_create_ft_tls_203 'ru'
-- sp_populate_ft_tls_203 'ru'


USE [patscape]
GO

INSERT INTO patscape.[dbo].[tls201_appln]
  SELECT *
  FROM [patstat2016a].[dbo].[tls201_appln]
  where appln_id in (select appln_id  FROM [patstat2016a].[dbo].[tls202_appln_title]
  where appln_title_lg like 'ru')
  and appln_id not in (select appln_id from patscape.dbo.tls201_appln)
  ;

INSERT INTO patscape.[dbo].[tls201_appln]
  SELECT *
  FROM [patstat2016a].[dbo].[tls201_appln]
  where appln_id in (select appln_id  FROM [patscape].[dbo].[tls203_appln_abstr_ru])
  and appln_id not in (select appln_id from patscape.dbo.tls201_appln)
  ;

select count(*)
from [patscape].[dbo].[tls203_appln_abstr_ru] t203
inner join patscape.[dbo].[tls201_appln] t201 on t201.appln_id = t203.appln_id
;

select appln_year, count(*)
from 
(
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((питание, напряжение), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_ru, appln_abstract,
  'NEAR((питание, напряжение), 50, FALSE)' )
) KEYS
inner 
-- loop -- хинт, с ним у меня самые быстрые запросы получались (альтернатива hash, merge), можно его включить 
join appln_search ayc
on ayc.appln_id = KEYS.[KEY]
group by appln_year
order by count(*) desc;
