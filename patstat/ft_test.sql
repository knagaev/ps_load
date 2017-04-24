use patscape
go

-- в пределах 3 слов
-- порядок не важен
SELECT appln_id, appln_abstract
FROM tls203_appln_abstr_en 
INNER JOIN CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((detector, scintillator), 3, FALSE)' ) AS KEY_TBL
  ON tls203_appln_abstr_en.appln_id = KEY_TBL.[KEY]
WHERE KEY_TBL.RANK > 50
ORDER BY KEY_TBL.RANK DESC
GO


-- в пределах 5 слов
-- порядок важен
SELECT appln_id, appln_abstract
FROM tls203_appln_abstr_en 
INNER JOIN CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((detector, scintillator), 5, TRUE)' ) AS KEY_TBL
  ON tls203_appln_abstr_en.appln_id = KEY_TBL.[KEY]
WHERE KEY_TBL.RANK > 50
ORDER BY KEY_TBL.RANK DESC
GO

-- в пределах 3 слов
-- порядок не важен
SELECT count(*)
FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((detector, scintillator), 3, FALSE)' ) 
 
Go


-- в пределах 5 слов
-- порядок важен
SELECT *
FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((detector, scintillator), 5, TRUE)' )
GO


-- получение результата из двух таблиц, английской и немецкой
SELECT appln_id, appln_abstract COLLATE DATABASE_DEFAULT, 'en'
FROM tls203_appln_abstr_en 
INNER JOIN CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' ) AS KEY_TBL
  ON tls203_appln_abstr_en.appln_id = KEY_TBL.[KEY]
--WHERE KEY_TBL.RANK > 50
union all
SELECT appln_id, appln_abstract COLLATE DATABASE_DEFAULT, 'de'
FROM tls203_appln_abstr_de 
INNER JOIN CONTAINSTABLE(tls203_appln_abstr_de, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' ) AS KEY_TBL
  ON tls203_appln_abstr_de.appln_id = KEY_TBL.[KEY]
--WHERE KEY_TBL.RANK > 50

GO


/*
-- создание "тонкой" таблицы
-- данные (идентификатор документа, год публикации и страна публикации) 
-- берём из таблицы tls211_pat_publn и создаём таблицу appln_search
--select appln_id, YEAR(publn_date) publn_year, publn_auth
-- into appln_search 
--from tls211_pat_publn
--GO

-- truncate table appln_search;

select appln_id, appln_filing_year appln_year, appln_auth 
 into appln_search 
from tls201_appln
GO

-- создаем уникальный кластерный индекс на appln_search по всем полям 
-- (для оптимизации чтения всех полей в запросах)
-- PAD_INDEX: fillfactor применяется к страницам индекса промежуточного уровня
-- STATISTICS_NORECOMPUTE: устаревшие статистики распределения не пересчитываются автоматически
-- SORT_IN_TEMPDB: временные результаты сортировки не сохраняются в базе данных tempdb
-- IGNORE_DUP_KEY: ошибка на повторяющиеся значения ключа выключена
-- DROP_EXISTING: индекс с указанным именем ещё не существует
-- ONLINE: во время создания индекса таблица не доступна
-- ALLOW_ROW_LOCKS: блокировки записей не используются (таблица не будет обновляться)
-- ALLOW_PAGE_LOCKS: блокировки страниц не используются (таблица не будет обновляться)
-- FILLFACTOR: таблица не будет обновляться, коэффициент заполнения для отсутствия резервирования
-- PRIMARY: индекс создаётся на первичной файловой группе
CREATE UNIQUE CLUSTERED INDEX ndx_appln_search ON appln_search
(
  appln_id ASC,
  appln_year ASC,
  appln_auth ASC
)
WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, 
  DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF, FILLFACTOR = 100) 
ON [PRIMARY]
GO

-- обновляем статистику оптимизации запросов для таблицы
UPDATE STATISTICS appln_search;
GO
*/

-- статистика распределения документов с требуемыми термами по годам
-- используется объединение результатов выполнения функций CONTAINSTABLE 
-- с соединением с "тонкой" таблицей по ключу полнотекстового индекса
select appln_year, count(*)
from 
(
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_de, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
) KEYS
inner 
-- loop -- хинт, с ним у меня самые быстрые запросы получались (альтернатива hash, merge), можно его включить 
join appln_search ayc
on ayc.appln_id = KEYS.[KEY]
group by appln_year
order by count(*) desc;

-- статистика распределения документов с требуемыми термами по годам и странам
select appln_year, appln_auth, count(*)
from 
(
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_de, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
) KEYS
inner 
-- loop -- хинт, с ним у меня самые быстрые запросы получались (альтернатива hash, merge), можно его включить 
join appln_search ayc
on ayc.appln_id = KEYS.[KEY]
group by appln_year, appln_auth
order by count(*) desc;

-- статистика распределения документов с требуемыми термами по годам и странам
select appln_auth, count(*)
from 
(
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_de, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
) KEYS
inner 
-- loop -- хинт, с ним у меня самые быстрые запросы получались (альтернатива hash, merge), можно его включить 
join appln_search ayc
on ayc.appln_id = KEYS.[KEY]
where appln_year in ('2011', '1996', '2006')
group by appln_auth
order by count(*) desc;



SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_ar, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_bg, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_cs, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_da, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_de, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_el, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_en, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_es, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_et, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_fr, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_hr, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_it, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_ja, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_ko, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_lt, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_lv, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_nl, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_no, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_pl, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_pt, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_ro, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_ru, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_sh, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_sk, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_sl, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_sr, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_sv, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_tr, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_uk, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
union all
SELECT [KEY]
FROM CONTAINSTABLE(tls203_appln_abstr_zh, appln_abstract,
  'NEAR((laser, form), 3, FALSE)' )
