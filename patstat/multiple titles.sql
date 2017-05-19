select appln_id, l from
      (
      select appln_id, 'ar' l from tls202_appln_title_ar union all  
      select appln_id, 'bg' l from tls202_appln_title_bg union all  
      select appln_id, 'cs' l from tls202_appln_title_cs union all  
      select appln_id, 'da' l from tls202_appln_title_da union all  
      select appln_id, 'de' l from tls202_appln_title_de union all  
      select appln_id, 'el' l from tls202_appln_title_el union all  
      select appln_id, 'en' l from tls202_appln_title_en union all  
      select appln_id, 'es' l from tls202_appln_title_es union all  
      select appln_id, 'et' l from tls202_appln_title_et union all  
      select appln_id, 'fr' l from tls202_appln_title_fr union all  
      select appln_id, 'hr' l from tls202_appln_title_hr union all  
      select appln_id, 'it' l from tls202_appln_title_it union all  
      select appln_id, 'ja' l from tls202_appln_title_ja union all  
      select appln_id, 'ko' l from tls202_appln_title_ko union all  
      select appln_id, 'lt' l from tls202_appln_title_lt union all  
      select appln_id, 'lv' l from tls202_appln_title_lv union all  
      select appln_id, 'nl' l from tls202_appln_title_nl union all  
      select appln_id, 'no' l from tls202_appln_title_no union all  
      select appln_id, 'pl' l from tls202_appln_title_pl union all  
      select appln_id, 'pt' l from tls202_appln_title_pt union all  
      select appln_id, 'ro' l from tls202_appln_title_ro union all  
      select appln_id, 'ru' l from tls202_appln_title_ru union all  
      select appln_id, 'sh' l from tls202_appln_title_sh union all  
      select appln_id, 'sk' l from tls202_appln_title_sk union all  
      select appln_id, 'sl' l from tls202_appln_title_sl union all  
      select appln_id, 'sr' l from tls202_appln_title_sr union all  
      select appln_id, 'sv' l from tls202_appln_title_sv union all  
      select appln_id, 'tr' l from tls202_appln_title_tr union all  
      select appln_id, 'uk' l from tls202_appln_title_uk union all  
      select appln_id, 'zh' l from tls202_appln_title_zh
       ) t202 where appln_id in (select appln_id from
      (
      select appln_id from tls202_appln_title_ar union all  
      select appln_id from tls202_appln_title_bg union all  
      select appln_id from tls202_appln_title_cs union all  
      select appln_id from tls202_appln_title_da union all  
      select appln_id from tls202_appln_title_de union all  
      select appln_id from tls202_appln_title_el union all  
      select appln_id from tls202_appln_title_en union all  
      select appln_id from tls202_appln_title_es union all  
      select appln_id from tls202_appln_title_et union all  
      select appln_id from tls202_appln_title_fr union all  
      select appln_id from tls202_appln_title_hr union all  
      select appln_id from tls202_appln_title_it union all  
      select appln_id from tls202_appln_title_ja union all  
      select appln_id from tls202_appln_title_ko union all  
      select appln_id from tls202_appln_title_lt union all  
      select appln_id from tls202_appln_title_lv union all  
      select appln_id from tls202_appln_title_nl union all  
      select appln_id from tls202_appln_title_no union all  
      select appln_id from tls202_appln_title_pl union all  
      select appln_id from tls202_appln_title_pt union all  
      select appln_id from tls202_appln_title_ro union all  
      select appln_id from tls202_appln_title_ru union all  
      select appln_id from tls202_appln_title_sh union all  
      select appln_id from tls202_appln_title_sk union all  
      select appln_id from tls202_appln_title_sl union all  
      select appln_id from tls202_appln_title_sr union all  
      select appln_id from tls202_appln_title_sv union all  
      select appln_id from tls202_appln_title_tr union all  
      select appln_id from tls202_appln_title_uk union all  
      select appln_id from tls202_appln_title_zh
       ) t202 group by appln_id having count(*) > 1)
	   order by appln_id