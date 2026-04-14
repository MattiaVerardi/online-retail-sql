/*
Project: Online Retail SQL Analysis
File: 11_product_analysis.sql
Description: Analisi dei prodotti più venduti dall'azienda
	in termini di quantità richiesta e di fatturato generato
Author: Mattia Verardi
Date: April 2026
*/

use OnlineRetailDB;
go

-- Top 10 prodotti più venduti per quantità
select top 10 StockCode, Description,
	sum(Quantity) as Quantity
from clean_online_retail
group by StockCode, Description
order by Quantity desc;

-- Top 10 prodotti più venduti per fatturato
select top 10 StockCode, Description,
	sum(TotalPrice) as Revenue
from clean_online_retail
group by StockCode, Description
order by Revenue desc;

-- Prodotti più venduti in assoluto
with Top10Quantity as(
			select top 10 StockCode, Description,
				sum(Quantity) as Quantity
			from clean_online_retail
			group by StockCode, Description
			order by Quantity desc
			),
		Top10Revenue as(
			select top 10 StockCode, Description,
				sum(TotalPrice) as Revenue
			from clean_online_retail
			group by StockCode, Description
			order by Revenue desc
			)
select q.StockCode, q.Description
from Top10Quantity as q
inner join Top10Revenue as r
	on q.StockCode = r.StockCode;