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