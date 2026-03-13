/*
Project: Online Retail SQl Analysis
File: 06_feature_engineering.sql
Description: Creazione di nuove colonne, quali
	TotalPrice, Year, Month, Day e DayName
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go

alter table clean_online_retail
add TotalPrice decimal(18,2),
	Year int,
	Month int,
	Day int,
	DayName varchar(10);
go

set language English;

update clean_online_retail
set TotalPrice = Quantity * UnitPrice,
	Year = year(InvoiceDate),
	Month = month(InvoiceDate),
	Day = day(InvoiceDate),
	DayName = datename(weekday, InvoiceDate);
