/*
Project: Online Retail SQL Analysis
File: 04_data_profiling.sql
Description: Controlli sul dataset importato
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go


-- Controllo numero di righe importate
select count(*) as NumeroRighe
from stg_online_retail;


-- Controllo prime righe importate
select top 10 *
from stg_online_retail;


-- Controllo valori null
select count(*) as ValoriNulli
from stg_online_retail
where InvoiceNo is null;

select count(*) as ValoriNulli
from stg_online_retail
where StockCode is null;

select count(*) as ValoriNulli
from stg_online_retail
where Description is null;

select count(*) as ValoriNulli
from stg_online_retail
where Quantity is null;

select count(*) as ValoriNulli
from stg_online_retail
where InvoiceDate is null;

select count(*) as ValoriNulli
from stg_online_retail
where UnitPrice is null;

select count(*) as ValoriNulli
from stg_online_retail
where CustomerID is null;

select count(*) as ValoriNulli
from stg_online_retail
where Country is null;


-- Controllo lunghezza dei valori testuali
select top 1 len(InvoiceNo) as LunghezzaValore
from stg_online_retail
order by len(InvoiceNo) desc;

select top 1 len(StockCode) as LunghezzaValore
from stg_online_retail
order by len(StockCode) desc;

select top 1 len(Description) as LunghezzaValore
from stg_online_retail
order by len(Description) desc;

select top 1 len(Country) as LunghezzaValore
from stg_online_retail
order by len(Country) desc;


-- Controllo valori anomali o negativi
select Quantity
from stg_online_retail
where Quantity <= 0;

select UnitPrice
from stg_online_retail
where UnitPrice <= 0;

select UnitPrice
from stg_online_retail
where UnitPrice < 0;


-- Controllo valori duplicati
with cte as(
	select InvoiceNo, StockCode, Quantity,
		UnitPrice, CustomerID, count(*) as ConteggioDuplicati
	from stg_online_retail
	group by InvoiceNo, StockCode, Quantity,
		UnitPrice, CustomerID
	having count(*) > 1
	)
select sum(ConteggioDuplicati) - count(*) as RigheDuplicate
from cte;