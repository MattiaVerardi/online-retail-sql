# Online Retail SQL Analysis


### Obiettivi:




### Dataset:

Il dataset oggetto di analisi è Online Retail.csv.

Durante il **data profiling**, è emerso che il dataset presenta le seguenti caratteristiche:

* 541909 righe e 8 colonne
* le colonne Description e CustomedID presentano dei valori null
* le colonne Quantity e UnitPrice presentano dei valori negativi
* 4879 righe presentano valori duplicati

Con il **data cleaning** si è proceduto a:

* eliminare le righe duplicate
* gestire i valori mancanti
* escludere i valori negativi

Successivamente, il **feature engineering** ha permesso la creazione delle seguenti colonne:

* TotalPrice, data dal prodotto tra Quantity e UnitPrice
* Year, Month, Day e DayName, estratte dalla colonna InvoiceDate


### Risultati principali:


### Approfondimenti chiave:


### Tools:

* SQL Server


### Struttura della repository:

online_retail-sql/

