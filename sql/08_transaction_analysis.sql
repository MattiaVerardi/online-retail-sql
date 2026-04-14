/*
Project: Online Retail SQL Analysis
File: 08_transaction_analysis.sql
Description: Analisi delle transazioni dell'azienda
	condotta su:
	- fatturato per transazione
	- average basket size
	- distribuzione di Quantity e UnitPrice
Author: Mattia Verardi
Date: April 2026
*/

use OnlineRetailDB;
go

-- Fatturato per transazione
with InvoiceRevenue as(
			select InvoiceNo,
				sum(TotalPrice) as InvoiceRevenue
			from clean_online_retail
			group by InvoiceNo
			),
		Aggregates as(
			select count(InvoiceRevenue) as Count, 
				avg(InvoiceRevenue) as Mean,
				stdevp(InvoiceRevenue) as Std,
				min(InvoiceRevenue) as Min,
				max(InvoiceRevenue) as Max
			from InvoiceRevenue
			),
		Quartiles as(
			select distinct
				percentile_cont(0.25) within group(
					order by InvoiceRevenue) over() as Q1,
				percentile_cont(0.5) within group(
					order by InvoiceRevenue) over() as Q2,
				percentile_cont(0.75) within group(
					order by InvoiceRevenue) over() as Q3
			from InvoiceRevenue
			)
select convert(decimal(18,2), a.Count) as Count,
	convert(decimal(18,2), a.Mean) as Mean,
	convert(decimal(18,2), a.Std) as Std,
	convert(decimal(18,2), a.Min) as Min,
	convert(decimal(18,2), q.Q1) as Q1,
	convert(decimal(18,2), q.Q2) as Q2,
	convert(decimal(18,2), q.Q3) as Q3,
	convert(decimal(18,2), a.Max) as Max
from Aggregates as a
cross join Quartiles as q;

-- Average Basket Size
with BasketSize as(
			select InvoiceNo,
				sum(Quantity) as BasketSize
			from clean_online_retail
			group by InvoiceNo
			),
		Aggregates as(
			select count(BasketSize) as Count, 
				avg(BasketSize) as Mean,
				stdevp(BasketSize) as Std,
				min(BasketSize) as Min,
				max(BasketSize) as Max
			from BasketSize
			),
		Quartiles as(
			select distinct
				percentile_cont(0.25) within group(
					order by BasketSize) over() as Q1,
				percentile_cont(0.5) within group(
					order by BasketSize) over() as Q2,
				percentile_cont(0.75) within group(
					order by BasketSize) over() as Q3
			from BasketSize
			)
select convert(decimal(18,2), a.Count) as Count,
	convert(decimal(18,2), a.Mean) as Mean,
	convert(decimal(18,2), a.Std) as Std,
	convert(decimal(18,2), a.Min) as Min,
	convert(decimal(18,2), q.Q1) as Q1,
	convert(decimal(18,2), q.Q2) as Q2,
	convert(decimal(18,2), q.Q3) as Q3,
	convert(decimal(18,2), a.Max) as Max
from Aggregates as a
cross join Quartiles as q;

-- Distribuzione di Quantity
with Aggregates as(		
			select count(convert(decimal(18,2), Quantity)) as Count,
				avg(convert(decimal(18,2), Quantity)) as Mean,
				stdevp(convert(decimal(18,2), Quantity)) as Std,
				min(convert(decimal(18,2), Quantity)) as Min,
				max(convert(decimal(18,2), Quantity)) as Max
			from clean_online_retail
			),
		Quartiles as(
			select distinct
				percentile_cont(0.25) within group(
					order by Quantity) over() as Q1,
				percentile_cont(0.5) within group(
					order by Quantity) over() as Q2,
				percentile_cont(0.75) within group(
					order by Quantity) over() as Q3
			from clean_online_retail
			)
select convert(decimal(18,2), a.Count) as Count, 
	convert(decimal(18,2), a.Mean) as Mean,
	convert(decimal(18,2), a.Std) as Std,
	convert(decimal(18,2), a.Min) as Min,
	convert(decimal(18,2), q.Q1) as Q1,
	convert(decimal(18,2), q.Q2) as Q2,
	convert(decimal(18,2), q.Q3) as Q3,
	convert(decimal(18,2), a.Max) as Max
from Aggregates as a
cross join Quartiles as q;

-- Distribuzione di UnitPrice
with Aggregates as(
			select count(UnitPrice) as Count,
				avg(UnitPrice) as Mean,
				stdevp(UnitPrice) as Std,
				min(UnitPrice) as Min,
				max(UnitPrice) as Max
			from clean_online_retail
			),
		Quartiles as(
			select distinct
				percentile_cont(0.25) within group(
					order by UnitPrice) over() as Q1,
				percentile_cont(0.5) within group(
					order by UnitPrice) over() as Q2,
				percentile_cont(0.75) within group(
					order by UnitPrice) over() as Q3
			from clean_online_retail
			)
select convert(decimal(18,2), a.Count) as Count, 
	convert(decimal(18,2), a.Mean) as Mean,
	convert(decimal(18,2), a.Std) as Std,
	convert(decimal(18,2), a.Min) as Min,
	convert(decimal(18,2), q.Q1) as Q1,
	convert(decimal(18,2), q.Q2) as Q2,
	convert(decimal(18,2), q.Q3) as Q3,
	convert(decimal(18,2), a.Max) as Max
from Aggregates as a
cross join Quartiles as q;
