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
