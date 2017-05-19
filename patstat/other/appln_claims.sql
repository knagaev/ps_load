ALTER FULLTEXT INDEX ON tls203_appln_abstr_' + @lang + '
ADD (appln_claims Language , appln_descr Language 
	 ) 
	  KEY INDEX PK_tls203_appln_abstr_' + @lang + '
	  ON tls_ft WITH STOPLIST = SYSTEM, CHANGE_TRACKING OFF, NO POPULATION;

ALTER FULLTEXT INDEX ON tls203_appln_abstr_ar ADD (appln_claims Language 1025, appln_descr Language 1025) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_bg ADD (appln_claims Language 1026, appln_descr Language 1026) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_cs ADD (appln_claims Language 1029, appln_descr Language 1029) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_da ADD (appln_claims Language 1030, appln_descr Language 1030) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_de ADD (appln_claims Language 1031, appln_descr Language 1031) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_el ADD (appln_claims Language 1032, appln_descr Language 1032) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_en ADD (appln_claims Language 1033, appln_descr Language 1033) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_es ADD (appln_claims Language 3082, appln_descr Language 3082) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_et ADD (appln_claims Language 1033, appln_descr Language 1033) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_fr ADD (appln_claims Language 1036, appln_descr Language 1036) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_hr ADD (appln_claims Language 1050, appln_descr Language 1050) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_it ADD (appln_claims Language 1040, appln_descr Language 1040) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_ja ADD (appln_claims Language 1041, appln_descr Language 1041) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_ko ADD (appln_claims Language 1042, appln_descr Language 1042) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_lt ADD (appln_claims Language 1063, appln_descr Language 1063) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_lv ADD (appln_claims Language 1062, appln_descr Language 1062) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_nl ADD (appln_claims Language 1043, appln_descr Language 1043) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_no ADD (appln_claims Language 1044, appln_descr Language 1044) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_pl ADD (appln_claims Language 1045, appln_descr Language 1045) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_pt ADD (appln_claims Language 2070, appln_descr Language 2070) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_ro ADD (appln_claims Language 1048, appln_descr Language 1048) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_ru ADD (appln_claims Language 1049, appln_descr Language 1049) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_sh ADD (appln_claims Language 1050, appln_descr Language 1050) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_sk ADD (appln_claims Language 1051, appln_descr Language 1051) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_sl ADD (appln_claims Language 1060, appln_descr Language 1060) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_sr ADD (appln_claims Language 2074, appln_descr Language 2074) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_sv ADD (appln_claims Language 1053, appln_descr Language 1053) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_tr ADD (appln_claims Language 1055, appln_descr Language 1055) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_uk ADD (appln_claims Language 1058, appln_descr Language 1058) WITH NO POPULATION;
ALTER FULLTEXT INDEX ON tls203_appln_abstr_zh ADD (appln_claims Language 3076, appln_descr Language 3076) WITH NO POPULATION;