/*
Project: Online Retail SQL Analysis
File: 09_time_analysis.sql
Description: Analisi temporale delle vendite, condotta
	per anno e mese e per giorno della settimana
Author: Mattia Verardi
Date: April 2026
*/

use OnlineRetailDB;
go

-- Vendite per anno e mese
select Year, Month, sum(TotalPrice) as Revenue
from clean_online_retail
group by Year, Month
order by Year, Month;

-- Vendite per giorno della settimana
select DayName, sum(TotalPrice) as Revenue
from clean_online_retail
group by DayName
order by case when DayName = 'Monday' then 1
			  when DayName = 'Tuesday' then 2
			  when DayName = 'Wednesday' then 3
			  when DayName = 'Thursday' then 4
			  when DayName = 'Friday' then 5
			  when DayName = 'Saturday' then 6
			  when DayName = 'Sunday' then 7
			  end;