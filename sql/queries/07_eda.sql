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

-- Fatturato totale
select sum(TotalPrice) as TotalRevenue
from clean_online_retail;

-- Numero clienti
select count(distinct CustomerID) as TotalCustomers
from clean_online_retail;

-- Numero fatture
select count(distinct InvoiceNo) as TotalInvoices
from clean_online_retail;

-- Numero prodotti
select count(distinct StockCode) as TotalProducts
from clean_online_retail;


--=======================================
--Transaction Analysis
--=======================================

--=======================================
--Time Analysis
--=======================================

--=======================================
--Geografic Analysis
--=======================================

--=======================================
--Product Analysis
--=======================================

--=======================================
--Customer Analysis
--=======================================

