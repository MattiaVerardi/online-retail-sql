/*
Project: Online Retail SQl Analysis
File: 06_feature_engineering.sql
Description: Creazione di nuove colonne quali
	Continent, TotalPrice, Year, Month, Day e DayName
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go

if col_length('clean_online_retail', 'Continent') is null
begin
	alter table clean_online_retail
	add Continent varchar(20);
end


if col_length('clean_online_retail', 'TotalPrice') is null
begin
	alter table clean_online_retail
	add TotalPrice decimal(18,2);
end

if col_length('clean_online_retail', 'Year') is null
begin
	alter table clean_online_retail
	add Year int;
end

if col_length('clean_online_retail', 'Month') is null
begin
	alter table clean_online_retail
	add Month int;
end

if col_length('clean_online_retail', 'Day') is null
begin
	alter table clean_online_retail
	add Day int;
end

if col_length('clean_online_retail', 'DayName') is null
begin
	alter table clean_online_retail
	add DayName varchar(10);
end

go

set language English;

update clean_online_retail
set Continent = case when Country in ('RSA')
						then 'Africa'
					 when Country in ('Brazil', 'Canada', 
						'USA') then 'America'
					 when Country in ('Bahrain', 'Hong Kong', 
						'Israel', 'Japan', 'Lebanon',
						'Saudi Arabia', 'Singapore',
						'United Arab Emirates') then 'Asia'
					 when Country in ('Austria', 'Belgium', 
						'Channel Islands', 'Cyprus',
						'Czech Republic', 'Denmark', 'EIRE',
						'European Community', 'Finland',
						'France','Germany', 'Greece',
						'Iceland', 'Italy', 'Lithuania',
						'Malta', 'Netherlands', 'Norway',
						'Poland', 'Portugal', 'Spain',
						'Sweden', 'Switzerland',
						'United Kingdom') then 'Europe'
					 when Country in ('Australia')
						then 'Oceania'
					 else 'Other'
					 end,
	TotalPrice = Quantity * UnitPrice,
	Year = year(InvoiceDate),
	Month = month(InvoiceDate),
	Day = day(InvoiceDate),
	DayName = datename(weekday, InvoiceDate);