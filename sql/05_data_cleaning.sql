/*
Project: Online Retail SQL Analysis
File: 05_data_cleaning.sql
Description: Eliminazione delle righe duplicate,
	gestione dei valori mancanti in Description ed
	esclusione dei valori di Quantity e UnitPrice
	pari o minori di zero
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go

with cte as(
	select *, row_number() over(
		partition by InvoiceNo, StockCode,
		Description, Quantity, InvoiceDate,
		UnitPrice, CustomerID, Country
		order by InvoiceNo) as rn
	from stg_online_retail
	)
select InvoiceNo, StockCode,
		isnull(Description, 'MISSING') as Description,
		Quantity, InvoiceDate,
		UnitPrice, CustomerID, Country
into clean_online_retail
from cte
where rn = 1 
	and Quantity > 0
	and UnitPrice > 0;
