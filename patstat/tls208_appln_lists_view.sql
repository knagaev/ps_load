SELECT t201.appln_id, t201.appln_auth,
  CASE 
    WHEN t201.appln_auth in ('RU','SU') THEN t211rusu.pat_publn_id
    ELSE t201.earliest_pat_publn_id
  end AS [base_pat_publn_id]
FROM tls201_appln t201
  LEFT JOIN (SELECT t211.appln_id, t211.pat_publn_id 
              FROM 
              (SELECT appln_id, pat_publn_id, ROW_NUMBER() OVER (PARTITION BY appln_id ORDER BY publn_date DESC) rn 
                FROM tls211_pat_publn WHERE publn_date <> '9999-12-31') t211
              WHERE t211.rn = 1) t211rusu ON t211rusu.appln_id = t201.appln_id AND t201.appln_auth in ('RU','SU')
where t201.appln_auth in ('RU','SU')
;
GO


select person_id from tls207_pers_appln where appln_id = 1 and applt_seq_nr > 0
select person_name from tls206_person  where person_id = 1;

select appln_id, [base_pat_publn_id] from tls208_appln_lists where appln_id = 42669886;
113625	EP	113626
113708	EP	113709
113977	EP	113978
114077	EP	114078
114160	EP	114161
114243	EP	114244
44881431	SU	303732832
44881474	SU	303469087
42669886	RU	296785979
42669969	RU	295739039