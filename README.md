
# Linking Land Registry Price Paid Data (PPD) and Domestic Energy Performance Certificates (EPCs)


This project shows the code developed as part of the authors' article which was accepted by Scientific Data on the 3rd July 2020. The linked dataset and code are deposited in the UK Data Service, which have been published in 4/11/2020. This research is **not** allowed to be used  **commercially**. 

Scientific Data declined the publication in 11/11/2020 due to data is **open access** not the **open data** as they request, the manuscripted are revised and submited to another Journal. The linked dataset and codes are under a temporary embargo in UKDA. It will be published again once we it accepted of a new Journal.

## 1. Getting Started
All matching rules were written in R with data inputs and outputs stored in a PostGIS database. Figure 1 displays the whole work flowchart.


![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/Workflow.png)

&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Figure 1  A work flow of this project
### 1.1 Create a new spatial database in PostgreSQL
Create a new PostGIS database and named as **datajournal** (https://postgis.net/workshops/postgis-intro/creating_db.html). Here, the password of postgres user is assumed to be **123456**.


### 1.2 Set the working directory for R
The process for setting the working directory is listed below:
- Create a directory named "R" on your D: drive.
- Create a sub-directory named "matchcasa1" in "R" folder.  
- Put the **rulechi.csv** file in the "matchcasa1" folder.
- Put the **Output_Area_2011_to_Builtup_Area_Subdivision_to_Builtup_Area_to_Local_Authority_District_to_Region_December_2011_Lookup_in_England_and_Wales.csv** file in the "matchcasa1" folder.

***NOTE:*** 
-  If you would like to change your working directory, you also need to change the filepath of **setwd("D:/R/matchcasa1")** and **setwd("D:/R")** in the R code (PPD_EPC_linkage.R).
-  The resource of **Output_Area_2011_to_Builtup_Area_Subdivision_to_Builtup_Area_to_Local_Authority_District_to_Region_December_2011_Lookup_in_England_and_Wales.csv** comes from the Open Geography portal( http://geoportal.statistics.gov.uk/datasets/output-area-2011-to-built-up-area-sub-division-to-built-up-area-to-local-authority-district-to-region-december-2011-lookup-in-england-and-wales ).


### 1.3 Read the Land Registry PPD into datajournal database
Download the Land Registry PPD from the UK goverment website (https://www.gov.uk/government/statistical-data-sets/price-paid-data-downloads) and  the save **pp-complete.csv** in your D: drive. Here we offer the version used in this research of of **pp-complete.csv** in UKDA ReShare(predicted DOI : https://dx.doi.org/10.5255/UKDA-SN-854240). Runing the **Read_LR_PPD.sql** to read all the Land Registry PPD into **datajournal** database

### 1.4 Read in Domestic EPCs in datajournal database
The Domestic EPC dataset is open and available on-line from the Ministry for Housing, Communities and Local Government - MHCLG (https://epc.opendatacommunities.org/). The EPC dataset used in this research is download in 24/10/2019 (the third released version). It contains 18,575,357 certificates issued between 1/10/2008 and 31/5/2019.


### 1.5 Clean up Land Registry PPD in datajournal database before linkage
 Run the **Data_cleaning.sql** to clean up the transactions which are not sold at full market value or for which the property type is 'Other'. Before matching, transactions in Land Registry PPD with postcodes in the Domestic EPC dataset are selected for using in the  following linkage (section 2); Domestic EPC dataset with postcodes in Land Registry PPD are also selected for using in the the following linkage (section 2).


### 1.6 Read in the National Statistics Postcode Lookup(NSPL) in datajournal database
Download NSPL (November 2019) from the Open Geography portal of the Office for National Statistics (ONS) (https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-november-2019) and save **NSPL_NOV_2019_UK.csv** in your D Drive. Run the **Read_NSPL.sql** to read the NSPL into **datajournal** database.

## 2. Data linkage
A matching method containing a four-stage (251 matching rule) process was designed to achieve the address matching. An example of each matching rule is listed in  **linkage_example.csv**. The code for this linkage is **PPD_EPC_linkage.R**. Figure 2 displays a screenshot of PPD_EPC_linkage R code. Utilizing this R code, two results are achieved:
- ***casa*** is the linked results from the four stages matching
- ***result2*** is the linked result with the recent EPC matched by transaction date for each transaction. It refers the linked_EPC PPD in figure 1.  
 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/screenshot_of_linkage_code.png)
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Figure 2.** Snapshot of the PPD_EPC_linkage R code
 

 
 
## 3. Evaluation of the data linkage 
Run **Evaluation.R**. This process evaluates the performance of data linkage to idenitfy for which years information loses through matching are relatively small. It firstly investigates overall annual match rate to choose an initial time period. Futher investigation is conducted for the initial time period by iinvestigating the data information lost before and after linkage with three methods( visualization through the data distribution before and after linkage, K-S test and J-divergence method for the dataset before and after linkage). A final time period of the linked dataset is decided by considering the results of these three methods.


### 3.1 Annual match rate between 1995 and 2019 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/annual_matchrate.png)
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Figure 3.** Match rate of linked house price in England and Wales,1995-2019

The match rate between 2011 and 2019 is higher than 90%, while the match rate of the rest for the period is considerably lower, this is mainly due to the EPC dataset only covering the period between 1/10/2008 and 31/8/2019. The match rate of 56.20% in 2008 is particularly low but rapidly increases to over 88 % after 2010. Since the match rate before 2008 is significantly lower than for the period after 2008, only the linked data between 2009 and 2019 are used to conduct the evaluation of data linkage.
### 3.2 Evaluation of data linkage between 2009 and 2019

(1) Compare of the house price frequency distributions for the Land Registry PPD and the linked PPD data to offers a clearer picture of matching performance(for detials seen the article).

(2) K-S test and J-divergence method
The Kolmogorov–Smirnov test (K-S test) and the Jeffreys divergence (J-divergence) are used to quantify the extent of house price information lost (fro detials seen the article).

### 3.3 Linked PPD between 2011 and 2019
(1) Overall Match rate between 2011 and 2019

The overall match rate for this period is 93.15%. The match rates for detached, semi-detached or terraced houses are around 94%. Address elements for the Flats/Maisonettes category are more detailed than for detached, semi-detached or terraced houses. This makes linking the Flats/Maisonettes transactions with their domestic EPCs more difficult with a lower match rate. The match rate for Flats/Maisonettes (88.62%) is lower than the rates for houses (Table 1). 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Table 1.** Summary of the matching for property type, 2011-2019
 

| Property type | Land Registry PPD | Linked data | Match rate |
|  ---      |    ---       |     ---   |   ---    |
| Detached   | 1,802,813     | 1,682,801    |93.34%    |
| Flats/Maisonettes    | 1,369,376       | 1,213,548     | 88.62%      |
| Semi-Detached    | 2,001,380       | 1,901,929      | 95.03%   |
| Terraced    | 2,075,690      | 1,955,057    | 94.19%     |

(2) Overall match rate at local authority level
70% of local authorities in England and Wales have an annual match rate over 90% for every year from 2011 to 2019, while 98% have a match rate over 80% for every year (for detials seen the article).

## 4. Data cleaning 

6,753,307 records of linked data can be geo-referenced by linking the NSPL between 1/1/2011 and 31/10/2019 in England and Wales. This data comprises the transaction information in the Land Registry PPD together with property size (total floor area and number of habitable rooms) in EPCs. Since some properties’ total floor area and number of habitable rooms are recorded in EPCs with missing or untenable values (e.g. total floor area records as 0.01), this data is excluded prior to analysis. Code for this section is **Data_cleaning.R**.


## 5. User note for the linked data
One final data set is associated with this work – the linked geo-referenced  PPD dataset for January 2011 to October 2019. This new linked dataset details 5,732,838 transactions in England and Wales along with each property's total floor area and the number of habitable rooms, but also includes a new unique identifier (id) and all the other non-address fields (except LMK_KEY field) in the Domestic EPC dataset. Codes for other commonly used spatial units from Output Area (OA) to region are also included in the dataset. **tran2011_19_example.csv** is a sample  of the newly linked data. It contains 105 fields writen in capital letter or small letter. All the fields written in upper case come from Domestic EPCs (MHCLG), the remaining fields written in lower case are described in Table 2.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Table 2.** Explanations of important fields in the new attribute-linked residential property price dataset


| Field name | Explanation| Data resource | example|
|  ---      |    ---       |     ---   |   ---    |
|  id |  A unique identifier in Domestic EPCs   |    Authors' own |  10000000  |
|  transactionid |  Transaction unique identifier    |  HM Land Registry   |   {5F2B8B60-B9D0-4F00-8561-8BBF0C991BE1}|
| oa11  | The 2011 Census Output Area (OA) code  |   NSPL |  E00155821  |
| postcode  |  Postcode information of the property    |  HM Land Registry   |   KT22 7LN |
|  price |   Sale price (transfer deed)   |  HM Land Registry   | 187250   |
| dateoftransfer  | Date when the sale was completed     |   HM Land Registry  | 2014-07-11   |
| propertytype  | Indicates the type of house:  D = Detached, S = Semi-Detached, T = Terraced, F = Flats/Maisonettes   |   HM Land Registry  |  F  |
|  oldnew |  Y refers a newly built property and N refers an established residential building. . If the property is firstly sold since 1995 it will identify as ‘a newly built property’   |   HM Land Registry  |  N  |
| duration  |  The tenure of property: freehold, leasehold    |    HM Land Registry |   L |
|  paon |  Primary Addressable Object Name    |    HM Land Registry |   BURLEIGH COURT  |
|  saon |    Secondary Addressable Object Name.   |    HM Land Registry |  FLAT 10  |
| street  |      |    HM Land Registry |  BELMONT ROAD   |
|locality  |      |    HM Land Registry |  NULL  |
| towncity  |      |    HM Land Registry | LEATHERHEAD   |
| district  |      |    HM Land Registry |  MOLE VALLEY  |
| county  |      |    HM Land Registry |  SURREY  |
| categorytype |  A = Standard Price Paid entry, includes single residential property sold for full market value    |    HM Land Registry |  A  |
| recordstatus | Indicates additions, changes and deletions to the records: A = Addition; C = Change; D = Delete. |    HM Land Registry |  A  |
|year |    Year when the sale was completed   |    Authors' own |  2014  |
|lsoa11   |  The 2011 Census Lower Layer Super Output Area (LSOA) code    |   NSPL |    E01030550 |
|  msoa11 | The 2011 Census Middle Layer Super Output Area (MSOA) code     |   NSPL  |   E02006364 |
|  laua |   The 2011 Census local authority district code   | Output Area (2011) to Built-up Area Sub-division to Built-up Area to Local Authority District to Region (December 2011) Lookup in England and Wales  |  E07000210  |
| lad11nm  |     The 2011 Census local authority district name  |  Output Area (2011) to Built-up Area Sub-division to Built-up Area to Local Authority District to Region (December 2011) Lookup in England and Wales  |   Mole Valley |
| gor  |   The 2011 Census region district code  |  Output Area (2011) to Built-up Area Sub-division to Built-up Area to Local Authority District to Region (December 2011) Lookup in England and Wales   | E12000008   |
| rgn11nm  |  The 2011 Census region name    |   Output Area (2011) to Built-up Area Sub-division to Built-up Area to Local Authority District to Region (December 2011) Lookup in England and Wales  |   South East |
| classt |Indicates for 1:1 and 1:n relationship of the linked data in the address mathcing.  11 refers to 1:1  relationship; 12 refers refers to 1:n relationship   |   Authors' own  |  12  |
| propertytype_epc  |  Describes the type of property. e.g. Maisonette, Flat, House, Bungalow, Park home.    |   MHCLG |  Flat  |
|  inspectiondate |   The date that the inspection was actually carried out by the energy assessor.   |   MHCLG|  2019-05-08   |
|  lodgementdate |  Date lodged on the Energy Performance of Buildings Register.    |   MHCLG|  2019-05-08   |
|  tfarea|  Total floor area: The total useful floor area is the total of all enclosed spaces measured to the internal face of the external walls, the gross floor area as measured in accordance with the guidance issued from time to time by the Royal Institute of Chartered Surveyors or by a body replacing that institution.   |   MHCLG|  46  |
|  numberrooms |Number of habitable rooms: Habitable rooms include any living room, sitting room, dining room, bedroom, study and similar; and also a non-separated conservatory. A kitchen/diner having a discrete seating area (with space for a table and four chairs) also counts as a habitable room. A non-separated conservatory adds to the habitable room count if it has an internal quality door between it and the dwelling. Excluded from the room count are any room used solely as a kitchen, utility room, bathroom, cloakroom, en-suite accommodation and similar; any hallway, stairs or landing; and also any room not having a window     |   MHCLG|  2  |
|  priceper|   House price per square metre   |   Authors' own  |  4070.652  |


***NOTE:*** Since the address strings for the same property in the Land Registry PPD and Domestic EPC dataset sometimes differ (e.g. 'WOODLANDS PARK' VS 'WOODLAND PARK'; 'CLEATOR STREET' VS 'CLEATER STREET'), we manualy correct this type of mismatch address string for the properties located in England between 1995 to 2016. This potentially makes the match rate in Wales relatively lower than in England. We will correct this kind of mismatch for Wales in the future.

:dolphin: **User suggestions:** :dolphin:

Below is a brief description of the datasets in UKDA ReShare along with user suggestions:

- tranall2011_19.csv is the newly linked data in this project. This is the individual transaction data,which can be subset or aggregated directly based on certain fields. R code for tracing regional annual house price trends between 2011 and 2018 is offered (example.R);
- epc_id.csv is the Domestic EPCs data which delete LMK_KE, **ADDRESS, ADDRESS1, ADDRESS2, ADDRESS3**, **POSTCODE** fields. The new unique identifier (id) is included in the dataset;
- pp-complete.csv is the Land Registry PPD download from GOV.UK website in December 20, 2019;
-  **`We removed the address and postcode fields (which comes from EPC dataset) in the linked data (tranall2011_19.csv) to make sure this data is an open data `**. If you prefer to create a new linked data yourself, you need to understand and accept the licence and copyright for the data and then download. Please check your copyright notice when you use the address or postcode fields in the EPC dataset (https://epc.opendatacommunities.org/docs/copyright).



## 6. Acknowledgements

The authors would like to thank David Lockett and Caroline Bray of Land Registry, who offered guidance on the Land Registry PPD. Thanks also to Jessica Williamson and Jake Mulley, who helped to transfer our questions on EPCs to the teams in MHCLG, allowing the authors to deepen their understanding of this data set at the end of this research. The authors also would like to thank Rob Liddiard of the UCL Energy Institute for sharing his expertise regarding EPC data during the earlier stages of this research.  

## 7.Attribution statement
Contains HM Land Registry data © Crown copyright and database right 2020. This data is licensed under the Open Government Licence v3.0.

Postcode and address elements in the new data are subject to Royal Mail copyright. The Royal Mail(address.management@royalmail.com) confirmed on the 25th August 2020 that this new data can be shared both by Bin Chi and by the UK Data Service with certain restrictions namely:
>The data must be shared on the same terms as the data was originally obtained. These terms are set out in the URL links below, and if someone intends to use the data for purposes outside of this, then they must obtain permission from Royal Mail by contacting address.management@royalmail.com  (exactly as they would have to do if obtaining the data directly from the relevant Open Data government websites). Royal Mail will retain attribution rights to the addressing data in both Price Paid Data (PPD) and Energy Performance Certificate (EPC) data because the data includes addresses and Postcodes which are the intellectual property of Royal Mail because they originate from our Postcode Address File (PAF).What this means in practice is that when the data is (re)published the relevant PPD and EPC licence terms must be referenced as they are published on the relevant Open Data websites at https://epc.opendatacommunities.org/docs/copyright and https://www.gov.uk/government/statistical-data-sets/price-paid-data-downloads#address-data.
