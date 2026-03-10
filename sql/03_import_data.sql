/*
Project: Online Retail SQL Analysis
File: 03_import_data.sql
Description: Import dei dati CSV nella tabella staging
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go


bulk insert stg_online_retail
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\online-retail-sql\data\Online Retail.csv'
with(
	fieldterminator = ';',
	rowterminator = '0x0a',
	firstrow = 2
	);