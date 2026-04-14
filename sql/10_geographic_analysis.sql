/*
Project: Online Retail SQL Analysis
File: 10_geographic_analysis.sql
Description: Analisi geografica del fatturato,
	dei clienti e del fatturato medio, a livello
	nazionale e continentale
Author: Mattia Verardi
Date: April 2026
*/

use OnlineRetailDB;
go

-- Fatturato per nazione
select cor.Country, 
	sum(cor.TotalPrice) / bo.TotalRevenue as RevenueShare
from clean_online_retail as cor,
	business_overview as bo
group by cor.Country,
	bo.TotalRevenue
order by RevenueShare desc;

-- Fatturato per continente
select cor.Continent,
	sum(cor.TotalPrice) / bo.TotalRevenue as RevenueShare
from clean_online_retail as cor
cross join business_overview as bo
group by cor.Continent,
	bo.TotalRevenue
order by RevenueShare desc;

-- Clienti per nazione
select cor.Country,
	count(distinct cor.CustomerID) * 1.0 /
		bo.TotalCustomers as CustomersShare
from clean_online_retail as cor
cross join business_overview as bo
where cor.CustomerID is not null
group by cor.Country,
	bo.TotalCustomers
order by CustomersShare desc;

-- Clienti per continente
select cor.Continent,
	count(distinct cor.CustomerID) * 1.0 /
	bo.TotalCustomers as CustomersShare
from clean_online_retail as cor
cross join business_overview as bo
where cor.CustomerID is not null
group by cor.Continent,
	bo.TotalCustomers
order by CustomersShare desc;

-- Fatturato medio per nazione
with CustomersRevenue as(
		select CustomerID, Country,
			sum(TotalPrice) as Revenue
		from clean_online_retail
		where CustomerID is not null
		group by CustomerID, Country
		)
select Country, avg(Revenue) as AverageRevenue
from CustomersRevenue
group by Country
order by AverageRevenue desc;

-- Fatturato medio per continente
with CustomersRevenue as(
	select CustomerID, Continent,
		sum(TotalPrice) as Revenue
	from clean_online_retail
	where CustomerID is not null
	group by CustomerID, Continent
	)
select Continent,
	avg(Revenue) as AverageRevenue
from CustomersRevenue
group by Continent
order by AverageRevenue desc;
