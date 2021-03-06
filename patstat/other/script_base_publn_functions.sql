USE [patstat2016b]
GO
/****** Object:  UserDefinedFunction [dbo].[base_pat_publn_id]    Script Date: 03.05.2017 17:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create function [dbo].[base_pat_publn_id](@appln_id int) returns int as begin

declare @appln_auth char(2) set @appln_auth=(select appln_auth from tls201_appln where appln_id=@appln_id)


return

case when @appln_auth in ('RU','SU') then

 (select top 1 pat_publn_id from tls211_pat_publn where appln_id=@appln_id 
	
	
	and publn_date<>'9999-12-31'  ---- ўЄюс√ шёъы■ўшЄ№ "ЇшъЄштэ√х чряшёш" ё яєёЄющ (NOT NULL яю єьюыўрэш■ 9999-12-31) фрЄющ т ёыєўрх, хёыш хёЄ№ эхЇшъЄштэ√х
	
	
	order by publn_date desc)


	else (select earliest_pat_publn_id from  tls201_appln where appln_id=@appln_id) end
end





GO
/****** Object:  UserDefinedFunction [dbo].[base_publn_auth]    Script Date: 03.05.2017 17:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create function [dbo].[base_publn_auth](@appln_id int) returns char(2) as begin

declare @appln_auth char(2) set @appln_auth=(select appln_auth from tls201_appln where appln_id=@appln_id)


return

case when @appln_auth in ('RU','SU') then

 (select top 1 publn_auth from tls211_pat_publn where appln_id=@appln_id 
	
	
	and publn_date<>'9999-12-31'  ---- ўЄюс√ шёъы■ўшЄ№ "ЇшъЄштэ√х чряшёш" ё яєёЄющ (NOT NULL яю єьюыўрэш■ 9999-12-31) фрЄющ т ёыєўрх, хёыш хёЄ№ эхЇшъЄштэ√х
	
	
	order by publn_date desc)


	else (select publn_auth from tls211_pat_publn where pat_publn_id=(select earliest_pat_publn_id from tls201_appln where appln_id=@appln_id)) end
end





GO
/****** Object:  UserDefinedFunction [dbo].[base_publn_date]    Script Date: 03.05.2017 17:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create function [dbo].[base_publn_date](@appln_id int) returns date as begin

declare @appln_auth char(2) set @appln_auth=(select appln_auth from tls201_appln where appln_id=@appln_id)


return

case when @appln_auth in ('RU','SU') then

 (select top 1 publn_date from tls211_pat_publn where appln_id=@appln_id 
	
	
	and publn_date<>'9999-12-31'  ---- ўЄюс√ шёъы■ўшЄ№ "ЇшъЄштэ√х чряшёш" ё яєёЄющ (NOT NULL яю єьюыўрэш■ 9999-12-31) фрЄющ т ёыєўрх, хёыш хёЄ№ эхЇшъЄштэ√х
	
	
	order by publn_date desc)


	else (select earliest_publn_date from  tls201_appln where appln_id=@appln_id) end
end





GO
/****** Object:  UserDefinedFunction [dbo].[base_publn_kind]    Script Date: 03.05.2017 17:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE function [dbo].[base_publn_kind](@appln_id int) returns char(2) as begin

declare @appln_auth char(2) set @appln_auth=(select appln_auth from tls201_appln where appln_id=@appln_id)


return

case when @appln_auth in ('RU','SU') then

 (select top 1 publn_kind from tls211_pat_publn where appln_id=@appln_id 
	
	
	and publn_date<>'9999-12-31'  ---- ўЄюс√ шёъы■ўшЄ№ "ЇшъЄштэ√х чряшёш" ё яєёЄющ (NOT NULL яю єьюыўрэш■ 9999-12-31) фрЄющ т ёыєўрх, хёыш хёЄ№ эхЇшъЄштэ√х
	
	
	order by publn_date desc)


	else (select publn_kind from tls211_pat_publn where pat_publn_id=(select earliest_pat_publn_id from tls201_appln where appln_id=@appln_id)) end
end





GO
/****** Object:  UserDefinedFunction [dbo].[base_publn_nr]    Script Date: 03.05.2017 17:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE function [dbo].[base_publn_nr](@appln_id int) returns varchar(15) as begin

declare @appln_auth char(2) set @appln_auth=(select appln_auth from tls201_appln where appln_id=@appln_id)


return

case when @appln_auth in ('RU','SU') then

 (select top 1 publn_nr from tls211_pat_publn where appln_id=@appln_id 
	
	
	and publn_date<>'9999-12-31'  ---- ўЄюс√ шёъы■ўшЄ№ "ЇшъЄштэ√х чряшёш" ё яєёЄющ (NOT NULL яю єьюыўрэш■ 9999-12-31) фрЄющ т ёыєўрх, хёыш хёЄ№ эхЇшъЄштэ√х
	
	
	order by publn_date desc)


	else (select publn_nr from tls211_pat_publn where pat_publn_id=(select earliest_pat_publn_id from tls201_appln where appln_id=@appln_id)) end
end





GO
