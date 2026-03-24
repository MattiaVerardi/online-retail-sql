/*
Project: Online Retail SQL Analysis
File: 07_eda.sql
Description: EDA del dataset clean_online_retail. 
	L'analisi parte con un business overview iniziale,
	per poi approfondire le vendite:
	- per transazioni
	- nel tempo
	- per nazione
	- per prodotto
	- per cliente
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go

--=======================================
--Business Overview
--=======================================

---- Fatturato totale
--select sum(TotalPrice) as TotalRevenue
--from clean_online_retail;

---- Numero clienti
--select count(distinct CustomerID) as TotalCustomers
--from clean_online_retail;

---- Numero fatture
--select count(distinct InvoiceNo) as TotalInvoices
--from clean_online_retail;

---- Numero prodotti
--select count(distinct StockCode) as TotalProducts
--from clean_online_retail;

--=======================================
-- Transaction Analysis
--=======================================

-- Fatturato per transazione
--with InvoiceRevenue as(
--			select InvoiceNo, sum(TotalPrice) as InvoiceRevenue
--			from clean_online_retail
--			group by InvoiceNo
--			),
--		Aggregates as(
--			select avg(InvoiceRevenue) as Mean,
--				stdevp(InvoiceRevenue) as Std,
--				min(InvoiceRevenue) as Min,
--				max(InvoiceRevenue) as Max
--			from InvoiceRevenue
--			),
--		Quartiles as(
--			select distinct
--				percentile_cont(0.25) within group(
--					order by InvoiceRevenue) over() as Q1,
--				percentile_cont(0.5) within group(
--					order by InvoiceRevenue) over() as Q2,
--				percentile_cont(0.75) within group(
--					order by InvoiceRevenue) over() as Q3
--			from InvoiceRevenue
--			)
--select convert(decimal(18,2), a.Mean) as Mean,
--	convert(decimal(18,2), a.Std) as Std,
--	convert(decimal(18,2), a.Min) as Min,
--	convert(decimal(18,2), q.Q1) as Q1,
--	convert(decimal(18,2), q.Q2) as Q2,
--	convert(decimal(18,2), q.Q3) as Q3,
--	convert(decimal(18,2), a.Max) as Max
--from Aggregates as a
--cross join Quartiles as q;

---- Average Basket Size
--with BasketSize as(
--			select InvoiceNo, sum(Quantity) as BasketSize
--			from clean_online_retail
--			group by InvoiceNo
--			),
--		Aggregates as(
--			select avg(BasketSize) as Mean,
--				stdevp(BasketSize) as Std,
--				min(BasketSize) as Min,
--				max(BasketSize) as Max
--			from BasketSize
--			),
--		Quartiles as(
--			select distinct
--				percentile_cont(0.25) within group(
--					order by BasketSize) over() as Q1,
--				percentile_cont(0.5) within group(
--					order by BasketSize) over() as Q2,
--				percentile_cont(0.75) within group(
--					order by BasketSize) over() as Q3
--			from BasketSize
--			)
--select convert(decimal(18,2), a.Mean) as Mean,
--	convert(decimal(18,2), a.Std) as Std,
--	convert(decimal(18,2), a.Min) as Min,
--	convert(decimal(18,2), q.Q1) as Q1,
--	convert(decimal(18,2), q.Q2) as Q2,
--	convert(decimal(18,2), q.Q3) as Q3,
--	convert(decimal(18,2), a.Max) as Max
--from Aggregates as a
--cross join Quartiles as q;

---- Distribuzione di Quantity
--with Aggregates as(		
--			select avg(convert(decimal(18,2), Quantity)) as Mean,
--				stdevp(convert(decimal(18,2), Quantity)) as Std,
--				min(convert(decimal(18,2), Quantity)) as Min,
--				max(convert(decimal(18,2), Quantity)) as Max
--			from clean_online_retail
--			),
--		Quartiles as(
--			select distinct
--				percentile_cont(0.25) within group(
--					order by Quantity) over() as Q1,
--				percentile_cont(0.5) within group(
--					order by Quantity) over() as Q2,
--				percentile_cont(0.75) within group(
--					order by Quantity) over() as Q3
--			from clean_online_retail
--			)
--select convert(decimal(18,2), a.Mean) as Mean,
--	convert(decimal(18,2), a.Std) as Std,
--	convert(decimal(18,2), a.Min) as Min,
--	convert(decimal(18,2), q.Q1) as Q1,
--	convert(decimal(18,2), q.Q2) as Q2,
--	convert(decimal(18,2), q.Q3) as Q3,
--	convert(decimal(18,2), a.Max) as Max
--from Aggregates as a
--cross join Quartiles as q;

---- Distribuzione di UnitPrice
--with Aggregates as(
--			select avg(UnitPrice) as Mean,
--				stdevp(UnitPrice) as Std,
--				min(UnitPrice) as Min,
--				max(UnitPrice) as Max
--			from clean_online_retail
--			),
--		Quartiles as(
--			select distinct
--				percentile_cont(0.25) within group(
--					order by UnitPrice) over() as Q1,
--				percentile_cont(0.5) within group(
--					order by UnitPrice) over() as Q2,
--				percentile_cont(0.75) within group(
--					order by UnitPrice) over() as Q3
--			from clean_online_retail
--			)
--select convert(decimal(18,2), a.Mean) as Mean,
--	convert(decimal(18,2), a.Std) as Std,
--	convert(decimal(18,2), a.Min) as Min,
--	convert(decimal(18,2), q.Q1) as Q1,
--	convert(decimal(18,2), q.Q2) as Q2,
--	convert(decimal(18,2), q.Q3) as Q3,
--	convert(decimal(18,2), a.Max) as Max
--from Aggregates as a
--cross join Quartiles as q;

--=======================================
--Time Analysis
--=======================================

-- Vendite per anno e mese
--select Year, Month, sum(TotalPrice) as Revenue
--from clean_online_retail
--group by Year, Month
--order by Year, Month;

---- Vendite per giorno della settimana
--select DayName, sum(TotalPrice) as Revenue
--from clean_online_retail
--group by DayName
--order by case when DayName = 'Monday' then 1
--			  when DayName = 'Tuesday' then 2
--			  when DayName = 'Wednesday' then 3
--			  when DayName = 'Thursday' then 4
--			  when DayName = 'Friday' then 5
--			  when DayName = 'Saturday' then 6
--			  when DayName = 'Sunday' then 7
--			  end;

--=======================================
--Geographic Analysis
--=======================================

---- Fatturato per nazione
--with CountryRevenue as(
--		select Country,
--			sum(TotalPrice) as Revenue
--		from clean_online_retail
--		group by Country
--		)
--select Country, 
--	Revenue / sum(Revenue) over() as RevenueShare
--from CountryRevenue
--order by RevenueShare desc;

---- Clienti per nazione
--with CountryCustomers as(
--		select Country,
--			count(distinct CustomerID) as Customers
--		from clean_online_retail
--		group by Country
--		),
--	TotalCustomers as(
--		select count(distinct CustomerID) as TotalCustomers
--		from clean_online_retail
--		)
--select cc.Country,
--	cc.Customers * 1.0 / tc.TotalCustomers as CustomersShare
--from CountryCustomers as cc
--cross join TotalCustomers as tc
--order by CustomersShare desc;

---- Fatturato medio per nazione
--with CustomersRevenue as(
--		select CustomerID, Country,
--			sum(TotalPrice) as Revenue
--		from clean_online_retail
--		where CustomerID is not null
--		group by CustomerID, Country
--		)
--select Country, avg(Revenue) as AverageRevenue
--from CustomersRevenue
--group by Country
--order by AverageRevenue desc;

--=======================================
--Product Analysis
--=======================================

---- Top 10 prodotti più venduti per quantità
--select top 10 StockCode, Description,
--	sum(Quantity) as Quantity
--from clean_online_retail
--group by StockCode, Description
--order by Quantity desc;

---- Top 10 prodotti più venduti per fatturato
--select top 10 StockCode, Description,
--	sum(TotalPrice) as TotalPrice
--from clean_online_retail
--group by StockCode, Description
--order by TotalPrice desc;

---- Prodotti più venduti in assoluto
--with Top10Quantity as(
--			select top 10 StockCode, Description,
--				sum(Quantity) as Quantity
--			from clean_online_retail
--			group by StockCode, Description
--			order by Quantity desc
--			),
--		Top10Revenue as(
--			select top 10 StockCode, Description,
--				sum(TotalPrice) as TotalPrice
--			from clean_online_retail
--			group by StockCode, Description
--			order by TotalPrice desc
--			)
--select q.StockCode, q.Description
--from Top10Quantity as q
--inner join Top10Revenue as r
--	on q.StockCode = r.StockCode;

--=======================================
--Customer Analysis
--=======================================


