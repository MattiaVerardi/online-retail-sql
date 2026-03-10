/*
Project: Online Retail SQL Analysis
File: 02_create_tables.sql
Description: Script per creare la tabella principale
	del dataset
Author: Mattia Verardi
Date: March 2026
*/

use OnlineRetailDB;
go

create table stg_online_retail(
	InvoiceNo varchar(20) not null,
	StockCode varchar(20) not null,
	Description varchar(500),
	Quantity int not null,
	InvoiceDate datetime not null,
	UnitPrice decimal(18,2) not null,
	CustomerID int,
	Country varchar(100)
);