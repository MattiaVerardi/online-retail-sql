/*
Project: Online Retail SQL Analysis
File: 03_import_data.sql
Description: Import dei dati CSV nella tabella staging
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go

-- NOTA: Aggiorna il path in base al tuo ambiente locale
bulk insert stg_online_retail
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\online-retail-sql\data\online_retail.csv'
with(
	fieldterminator = ';',
	rowterminator = '0x0a',
	firstrow = 2
	);