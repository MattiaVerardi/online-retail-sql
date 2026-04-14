/*
Project: Online Retail SQL Analysis
File: 12_customer_analysis.sql
Description: Analisi della clientela condotta tramite:
	- top 10 spender
	- distribuzione della spesa clienti
	- average order value
	- pareto analysis
	- rfm analysis
	- customer segmentation
Author: Mattia Verardi
Date: April 2026
*/

use OnlineRetailDB;
go

if object_id('customers_view', 'v') is not null
	drop view customers_view
go

create view customers_view as
	select CustomerID,
		sum(TotalPrice) as Revenue,
		count(distinct InvoiceNO) as Orders
	from clean_online_retail
	where CustomerID is not null
	group by CustomerID;
go

-- Top 10 Spender
select top 10 CustomerID,
	Revenue
from customers_view
order by Revenue desc;

-- Distribuzione della spesa clienti
with Aggregates as(
			select count(Revenue) as Count,
				avg(Revenue) as Mean,
				stdevp(Revenue) as Std,
				min(Revenue) as Min,
				max(Revenue) as Max
			from customers_view
			),
		Quartiles as(
			select distinct
				percentile_cont(0.25) within group(
					order by Revenue) over() as Q1,
				percentile_cont(0.5) within group(
					order by Revenue) over() as Q2,
				percentile_cont(0.75) within group(
					order by Revenue) over() as Q3
			from customers_view
			)
select a.Count, a.Mean,
	a.Std, a.Min,
	q.Q1, q.Q2,
	q.Q3, a.Max
from Aggregates as a
cross join Quartiles as q;

-- Average Order Value
select top 10 CustomerID,
	Revenue, Orders,
	Revenue * 1.0 / Orders as AOV
from customers_view
order by Revenue desc;

select avg(Revenue * 1.0 / Orders) as MeanAOV
from customers_view;

-- Pareto Analysis
with TotalRevenue as(
			select sum(TotalPrice) as TotalRevenue
			from clean_online_retail
			where CustomerID is not null
			),
		TotalCustomers as(
			select
				count(distinct CustomerID) as TotalCustomers
			from clean_online_retail
			where CustomerID is not null
			)
select top 1 CumRevenuePct,
	CumCustomersPct
from(
	select cv.CustomerID,
		cv.Revenue,
		sum(cv.Revenue) over(order by cv.Revenue desc) * 1.0 /
			tr.TotalRevenue * 100 as CumRevenuePct,
		row_number() over(order by cv.Revenue desc) * 1.0 /
			tc.TotalCustomers * 100 as CumCustomersPct
	from customers_view as cv
	cross join TotalRevenue as tr
	cross join TotalCustomers as tc
	) as ParetoAnalysis
where CumRevenuePct >= 80
order by CumRevenuePct;

-- RFM Analysis
if object_id('rfm_view', 'v') is not null
	drop view rfm_view;
go

create view rfm_view as
with LastDate as(
		select max(InvoiceDate) as LastDate
		from clean_online_retail
		),
	LastOrderDate as(
		select CustomerID,
			max(InvoiceDate) as LastOrderDate
		from clean_online_retail
		where CustomerID is not null
		group by CustomerID
		),
	CustomersRFM as(
		select lod.CustomerID,
			datediff(day, lod.LastOrderDate, ld.LastDate) as Recency,
			cv.Orders as Frequency,
			cv.Revenue as Monetary
		from LastOrderDate as lod
			cross join LastDate as ld
			inner join customers_view as cv
				on lod.CustomerID = cv.CustomerID
		),
	RecencyPct as(
		select CustomerID,
			percent_rank() over(order by Recency) as R_Pct
		from CustomersRFM
		),
	MonetaryPct as(
		select CustomerID,
			percent_rank() over(order by Monetary) as M_Pct
		from CustomersRFM
		)
select CustomerID,
	Recency,
	Frequency,
	Monetary,
	R_score,
	F_score,
	M_score,
	concat(R_score, F_score, M_score) as RFM_score
from(
	select crfm.CustomerID,
		crfm.Recency,
		crfm.Frequency,
		crfm.Monetary,
		case when rpct.R_pct <= 0.2 then 5
			 when rpct.R_pct <= 0.4 then 4
			 when rpct.R_pct <= 0.6 then 3
			 when rpct.R_pct <= 0.8 then 2
			 else 1
			 end as R_score,
		case when crfm.Frequency between 0 and 1 then 1
			 when crfm.Frequency between 2 and 3 then 2
			 when crfm.Frequency between 4 and 6 then 3
			 when crfm.Frequency between 7 and 10 then 4
			 else 5
			 end as F_score,
		case when mpct.M_Pct <= 0.2 then 1
			 when mpct.M_Pct <= 0.4 then 2
			 when mpct.M_Pct <= 0.6 then 3
			 when mpct.M_Pct <= 0.8 then 4
			 else 5
			 end as M_score
	from CustomersRFM as crfm
	inner join RecencyPct as rpct
		on crfm.CustomerID = rpct.CustomerID
	inner join MonetaryPct as mpct
		on crfm.CustomerID = mpct.CustomerID
	)as RFM_score;
go

select *
from rfm_view;

-- Customer Segmentation
if object_id('customers_segment', 'u') is not null
	drop table customers_segment;
go

create table customers_segment(
	Segment varchar(20),
	RFM_score varchar(3)
	);

-- NOTA: Aggiorna il path in base al tuo ambiente locale
bulk insert customers_segment
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\online-retail-sql\data\RFM_customers_segmentation.csv' 
with(
	firstrow = 2,
	fieldterminator = ';',
	rowterminator = '\n'
	);

select cs.Segment,
	count(*) as Customers,
	sum(rw.Monetary) as Revenue
from rfm_view as rw
inner join customers_segment as cs
	on  rw.RFM_score = cs.RFM_score
group by cs.Segment
order by count(*);