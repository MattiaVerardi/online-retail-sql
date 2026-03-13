/*
Project: Online Retail SQL Analysis
File: 05_data_cleaning.sql
Description: Eliminazione delle righe duplicate,
	gestione dei valori mancanti in Description ed
	esclusione dei valori di Quantity e UnitPrice
	negativi
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go


if object_id('clean_online_retail', 'u') is not null
    drop table clean_online_retail;

with cte as(
	select *, row_number() over(
		partition by InvoiceNo, 
		StockCode collate SQL_Latin1_General_CP1_CS_AS,
		Description, Quantity, InvoiceDate,
		UnitPrice, CustomerID, Country
		order by InvoiceNo) as rn
	from stg_online_retail
	)
select InvoiceNo,
		StockCode collate SQL_Latin1_General_CP1_CS_AS as StockCode,
		isnull(Description, 'MISSING') as Description,
		Quantity, InvoiceDate,
		UnitPrice, CustomerID, Country
into clean_online_retail
from cte
where rn = 1 
	and Quantity >= 0
	and UnitPrice >= 0;
