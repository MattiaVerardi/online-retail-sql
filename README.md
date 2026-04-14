# Online Retail SQL Analysis


## Obiettivi:

Questo progetto analizza le transazioni di un e-commerce inglese, realizzate tra il 01/12/2010 e il 09/12/2011, con l'obiettivo di comprendere l'andamento delle vendite, il comportamento dei clienti e i prodotti più richiesti sul mercato.

In particolare, vengono analizzate:

* le transazioni effettuate, con un focus su quantità richieste, prezzi unitari e valore medio di spesa
* l'impatto delle vendite nel tempo
* la distribuzione del fatturato per nazione e continente
* i prodotti più venduti
* la clientela, attraverso Pareto Analysis e RFM Score



## Dataset:

Il dataset oggetto di analisi è Online Retail.csv.

Durante il **data profiling**, è emerso che il dataset presenta le seguenti caratteristiche:

* 541909 righe e 8 colonne
* le colonne *Description* e *CustomerID* presentano dei valori null
* le colonne *Quantity* e *UnitPrice* presentano dei valori negativi
* 4879 righe presentano valori duplicati

Con il **data cleaning** si è proceduto a:

* eliminare le righe duplicate
* gestire i valori mancanti
* escludere i valori negativi

Successivamente, il **feature engineering** ha permesso la creazione delle seguenti colonne:

* *Continent*, dedotta dalla colonna *Country* tramite una tabella di mapping
* *TotalPrice*, data dal prodotto tra *Quantity* e *UnitPrice*
* *Year*, *Month*, *Day* e *DayName*, estratte dalla colonna *InvoiceDate*



## Risultati principali:

Nella **business overview** è venuto fuori che, durante il periodo oggetto di analisi, l'azienda ha realizzato incassi per circa 11 milioni di sterline, con 4339 clienti, circa 21.000 fatture emesse e circa 3900 prodotti venduti.

La **transaction analysis** evidenza una forte asimmetria positiva della distribuzione. Infatti, la maggior parte delle transazioni si concentra su valori relativamente bassi, mentre una piccola percentuale di ordini di valore molto elevato genera una coda lunga nella distribuzione. In particolare, il valore mediano risulta significativamente inferiore rispetto alla media, indicando la presenza di outlier che influenza l'alto valore medio delle transazioni. Un comportamento simile si osserva anche nell'**average basket size**, dove la distribuzione mostra una forte variabilità: la maggior parte delle fatture contiene un numero contenuto di articoli, mentre pochi ordini includono quantità molto elevate, con valori massimi che arrivano fino alle 81.000 unità.

Nella **time analysis** si osserva che il fatturato è ben distribuito durante l'anno, con una progressiva crescita che culmina nel mese di ottobre, dove si registra il picco massimo delle vendite. Per il mese di dicembre 2011 non è possibile trarre delle conclusioni definitive, poiché sono disponibili solo i primi nove giorni del mese; tuttavia, i valori osservati suggeriscono un livello di vendite già significativo, lasciando presupporre un'ulteriore crescita nel periodo natalizio.
Analizzando, invece, la distribuzione delle vendite per giorno della settimana, il fatturato risulta stabile nei giorni feriali, con una lieve contrazione nella giornata di domenica. Si osserva, inoltre, l'assenza di transazioni nella giornata di sabato, elemento che lascia ipotizzare una possibile chiusura aziendale e una posticipazione delle fatture nei giorni seguenti.

Nella **geographic analysis** emerge una forte concentrazione del business nel mercato domestico. In particolare, circa l'85% del fatturato è generato da clienti residenti nel Regno Unito, mentre il 98% è attribuibile al continente europeo. Questo indica che l'azienda opera prevalentemente in Europa, con una presenza marginale negli altri mercati.
Un pattern analogo si osserva nella distribuzione dei clienti: circa il 90% dei clienti risiede nel Regno Unito e il 99% in Europa, confermando una base clienti fortemente localizzata.
Tuttavia, analizzando il fatturato medio per cliente, emergono dinamiche differenti. L’Irlanda presenta il valore medio più elevato, seguita da Paesi Bassi, Singapore e Australia, mentre il Regno Unito si posiziona soltanto al 17° posto. Anche a livello continentale si osserva un cambiamento significativo: l’Oceania risulta il continente con il fatturato medio più alto per cliente, mentre l’Europa, pur dominando in termini di volumi, scende al terzo posto.
Questa discrepanza tra volumi e valore medio suggerisce la presenza di mercati esteri con clienti meno numerosi ma mediamente più profittevoli.

Nella **product analysis** sono stati analizzati i 10 prodotti più richiesti dal mercato sulla base della quantità venduta e del fatturato generato. Dal confronto tra le due classifiche emerge che solo cinque prodotti sono presenti in entrambe, evidenziando come un alto volume non corrisponda necessariamente a un elevato fatturato e viceversa.

L'analisi termina con la **customer analysis**, dove sono stati esaminati i clienti sulla base del fatturato generato e del comportamento d'acquisto. 
In primo luogo, è stata analizzata la classifica dei top 10 spender, i cui fatturati variano tra le 77.000 e le 280.000 sterline, evidenziando la presenza di clienti ad altissimo valore per l'azienda. La distribuzione della spesa clienti risulta fortemente right-skewed: la media è significativamente superiore sia alla mediana sia al terzo quartile. Questo indica che la maggior parte dei clienti genera un fatturato contenuto, mentre una quota ridotta contribuisce in maniera sproporzionata ai ricavi complessivi.
E' stato, poi, calcolato il valore medio di spesa per ordine, confrontando quello dei top 10 spender con quello medio globale. Da questo confronto emerge che i clienti con più fatturato presentano una spesa media per ordine piuttosto elevata rispetto alla media globale.
Dalla **pareto analysis** è emerso che l'80% del fatturato è prodotto dal 26% dei clienti: seppur leggermente al di sopra del classico rapporto 80-20, tale dato conferma come il business sia trainato da una quota ridotta di clienti ad alto valore.
L'analisi termina con la costruzione del modello RFM e la successiva segmentazione della clientela. Nello specifico, ogni cliente è stato valutato sulla base dei seguenti indicatori, ciascuno classificato con un punteggio da 1 a 5:

* *Recency*, che misura il tempo trascorso dall'ultimo acquisto
* *Frequency*, che indica il numero di ordini effettuati
* *Monetary*, che rappresenta il fatturato generato

Dalla combinazione dei punteggi di questi tre indicatori è stato calcolato il **RFM score**, necessario per procedere con la segmentazione della clientela in gruppi omogenei.
Dall'analisi emerge che circa 1300 clienti rientrano dei segmenti *Lost* o *Hibernating*, ossia quei clienti che non acquistano da molto tempo, spendono poco ed effettuano pochi ordini. Al contrario, circa 550 clienti sono classificati come *Champion*, ovvero clienti ad altissimo valore per l'azienda in termini di frequenza, volumi e valore di acquisto. Particolarmente rilevanti sono quei 1600 clienti circa, appartenenti ai segmenti *Potential loyalist*, *Promising*, *New customer* e *Need attention*, sui quali l'azienda può lavorare per aumentare il valore nel tempo e favorirne la fidelizzazione.



## Approfondimenti chiave:

* Il fatturato dell'azienda presenta una distribuzione fortemente right-skewed, con una media di 500 sterline e valori outlier che raggiungono il picco di 17.000 sterline
* Il fatturato dell'azienda è prodotto per l'85% da clienti residenti nel Regno Unito e per il 99% da clienti europei, evidenziando una forte concentrazione geografica
* L'80% del fatturato aziendale è prodotto dal 26% dei clienti
* Circa 550 clienti sono classificati come *Champion* secondo il RFM score



## Tools:

* SQL Server



## Struttura della repository:

```

online_retail-sql/
│
├──	data/
│	│
│	├─ online_retail.csv
│	└─ RFM_customers_segmentation.csv
│
├──	sql/
│	│
│	├─ 01_create_database.sql
│	├─ 02_create_tables.sql
│	├─ 03_import_data.sql
│	├─ 04_data_profiling.sql
│	├─ 05_data_cleaning.sql
│	├─ 06_feature_engineering.sql
│	├─ 07_business_overview.sql
│	├─ 08_transaction_analysis.sql
│	├─ 09_time_analysis.sql
│	├─ 10_geographic_analysis.sql
│	├─ 11_product_analysis.sql
│	└─ 12_customer_analysis.sql
│
├──	.gitignore
│
└──	README.md

```