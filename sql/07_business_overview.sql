/*
Project: Online Retail SQL Analysis
File: 07_business_overview.sql
Description: Creazione di una vista di sintesi contenente le 
	principali metrice di business quali:
	- fatturato totale
	- clienti totali
	- fatture totali
	- prodotti totali
Author: Mattia Verardi
Date: April 2026
*/

use OnlineRetailDB;
go

-- Fatturato totale, clienti totali,
-- fatture totali e prodotti totali
if object_id('business_overview', 'v') is not null
	drop view business_overview
go

create view business_overview as
	select sum(TotalPrice) as TotalRevenue,
		count(distinct CustomerID) as TotalCustomers,
		count(distinct InvoiceNo) as TotalInvoices,
		count(distinct StockCode) as TotalProducts
	from clean_online_retail;
go

select *
from business_overview;