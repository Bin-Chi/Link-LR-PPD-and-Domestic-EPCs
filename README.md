
# Linking Land Registry Price Paid Data (PPD) and Domestic Energy Performance Certificates (EPCs)


This project is the code part of authors' article which will submit in Scientific Data, main codes will not open until it accepted from the data journel. The linked dataset is under review of UK Data Service. This research is **not** allowed used in **commercial**.

## 1. Getting Started
All matching rules were written in R with data inputs and outputs stored in a PostGIS database. Figure 1 displays the whole work flowchart.


![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/Workflow.png)

&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Figure 1  A work flow of this project
### 1.1 Create a new spatial database in PostgreSQL
Create a new PostGIS database and named as **datajournal** (https://postgis.net/workshops/postgis-intro/creating_db.html). Here, the password of postgres user is assumed to be **123456**.


### 1.2 Set the working directory for R
Process of setting working directory is listed below:
- Create a directory named "R" in your D Device.
- Create a sub-directory named "matchcasa1" in "R" folder.  
- Put the **rulechi.csv** file in the "matchcasa1" folder.
- Put the **Output_Area_2011_to_Builtup_Area_Subdivision_to_Builtup_Area_to_Local_Authority_District_to_Region_December_2011_Lookup_in_England_and_Wales.csv** file in the "matchcasa1" folder.

***NOTE:*** 
-  If you would like to change your working directory, you also need to change the filepath of **setwd("D:/R/matchcasa1")** and **setwd("D:/R")** in the R code (PPD_EPC_linkage.R).
-  The resource of **Output_Area_2011_to_Builtup_Area_Subdivision_to_Builtup_Area_to_Local_Authority_District_to_Region_December_2011_Lookup_in_England_and_Wales.csv** comes from the Open Geography portal( http://geoportal.statistics.gov.uk/datasets/output-area-2011-to-built-up-area-sub-division-to-built-up-area-to-local-authority-district-to-region-december-2011-lookup-in-england-and-wales ).


### 1.3 Read in the Land Registry PPD in datajournal database
Download Land Registry PPD from UK goverment website (https://www.gov.uk/government/statistical-data-sets/price-paid-data-downloads) and  the save **pp-complete.csv** in your D Device. Here we offer the used version of **pp-complete.csv** in UKDA ReShare(predicted DOI : https://dx.doi.org/10.5255/UKDA-SN-854240). Runing the **Read_LR_PPD.sql** to read in all the Land Registry PPD in **datajournal** database

### 1.4 Read in Domestic EPCs in datajournal database
Domestic EPCs is open and available on-line from the Ministry for Housing, Communities and Local Government - MHCLG (https://epc.opendatacommunities.org/). The current EPC dataset is the third released version and contains certificates issued between 1/10/2008 and 31/5/2019.The third version records 18,575,357 energy performance data records with 84 fields. 


### 1.5 Clean up Land Registry PPD in datajournal database before linkage
 Runing the **Data_cleaning.sql** to clean up the transaction which are not sold in full market value or property type is 'Other'. Before matching, transactions in Land Registry PPD with postcodes in the Domestic EPCs dataset are selected for the following linkage; Domestic EPCs dataset with postcodes in Land Registry PPD are also selected for the following Linkage.


### 1.6 Read in the National Statistics Postcode Lookup(NSPL) in datajournal database
Download NSPL (November 2019) from the Open Geography portal from the Office for National Statistics (ONS) (https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-november-2019) and the save **NSPL_NOV_2019_UK.csv** in your D Device. Runing the **Read_NSPL.sql** to read in all the NSPL in **datajournal** database.

## 2. Data linkage
A matching method containing a four-stage (251 matching rule) process was designed to achieve the address matching. An example of each matching rule is listed in  **linkage_example.csv**. The code for this linkage is **PPD_EPC_linkage.R**. Figure 2 displays a screenshot of PPD_EPC_linkage R code. Utilizing this R code, two result data are achieve:
- ***casa*** is the all the linked results from the four stages matching
- ***result2*** is linked result has the recent EPCs for each transaction , which refers the linked_EPC PPD in figure 1.  
 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/screenshot_of_linkage_code.png)
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Figure 2.** Snapshot of the PPD_EPC_linkage R code
 

 
 
## 3. Evaluation of the data linkage 
Run the **Evaluation.R**. This section evaluates the performance of data linkage for idenitfy a time period which house price informaiton lost related small. It firstly investages overall annual match rate to choose an initial time period. Futher investagtion is conducted for the initial time period by investgate the data information lost before and after linkage with three mehtods( visualizatinon through the data distribution before and after linkege, K-S test and J-divergence method for the dataset before and after linkage). A final time period of the linked dataset are decided by consider the resutls of these three methods.
### 3.1 Annual match rate between 1995 and 2019 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/annual_matchrate.png)
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Figure 3.** Match rate of linked house price in England and Wales,1995-2019

The match rate between 2011 and 2019 is higher than 90%, while the match rate of the rest of the period is considerably lower, this is mainly due to the publicly available EPCs dataset only covering the period between 1/10/2008 and 31/8/2019. The match rate of 56.20% in 2008 is particularly low but rapidly increases to over 88 % after 2010. Since the match rate before 2008 is significantly lower than for the period after 2008, only the linked data between 2009 and 2019 are used to conduct the evaluation of data linkage.
### 3.2 Evaluation of data linkage between 2009 and 2019
####(1) House price distribution of original data and linked data
Match rates offer a crude way to quantify the matching performance, but visual comparison of the house price frequency distributions for the new linked data and unlinked PPD data reveals a clearer picture of matching performance. Detials seen the article.

####(2) K-S test and J-divergence method
The Kolmogorov–Smirnov test (K-S test) and the Jeffreys divergence (J-divergence) can be used to quantify the extent of house price information lost.  Detials seen the article.
### 3.3 Linked PPD between 2011 and 2019
(1) Overall Match rate between 2011 and 2019
The overall match rate for this period is 93.15%. The match rates for detached, semi-detached or terraced houses are around 94%. Address elements for the Flats/Maisonettes category are more detailed than for detached, semi-detached or terraced houses. This makes linking the Flats/Maisonettes transactions with their domestic EPCs more difficult with a lower match rate. The match rate for Flats/Maisonettes (88.62%) is lower than the rates for houses (Table 1). Detials seen the article.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Table 1.** Summary of the matching for property type, 2011-2019
 

| Property type | Land Registry PPD | Linked data | Match rate |
|  ---      |    ---       |     ---   |   ---    |
| Detached   | 1,802,813     | 1,682,801    |93.34%    |
| Flats/Maisonettes    | 1,369,376       | 1,213,548     | 88.62%      |
| Semi-Detached    | 2,001,380       | 1,901,929      | 95.03%   |
| Terraced    | 2,075,690      | 1,955,057    | 94.19%     |

(2) Overall match rate at local authority level
70% of local authorities in England and Wales have an annual match rate over 90% for every year from 2011 to 2019, while 98% have a match rate over 80% for every year. Detials seen the article.

## 4. Data cleaning 

6,753,307 records of linked data can be geo-referenced by linking the NSPL between 1/1/2011 and 31/10/2019 in England and Wales. This data comprises the transaction information in the Land Registry PPD together with property size (total floor area and number of habitable rooms) in EPCs. Since some properties’ total floor area and number of habitable rooms are recorded in EPCs with missing or untenable values (e.g. total floor area records as 0.01), this data is excluded prior to analysis. Code for this section is **Data_cleaning.R**.


## 5. User note for the linked data
One final data set is associated with this work – the linked geo-referenced  PPD dataset for January 2011 to October 2019. This new linked dataset details 5,732,838 transactions in England and Wales along with each property's total floor area and the number of habitable rooms, but also includes a new unique identifier (id) and all the other non-address fields (except LMK_KEY field)in the Domestic EPC dataset. Codes for other commonly used spatial units from Output Area (OA) to region are also included in the dataset. **tran2011_19_example.csv** is a sample  of the newly linked data. It contains 105 fields writen in capital letter or small letter. All the fields written in capital letter comes from Domestic EPCs (MHCLG), the rest of the fields written in the small letter are described in Table 2.

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


***NOTE:*** Since for the address string of same property between Land Registry PPD and Domestic EPCs are sometime different (e.g. 'WOODLANDS PARK' VS 'WOODLAND PARK'; 'CLEATOR STREET' VS 'CLEATER STREET'), we only manual correct this mismatched address string for the property located in England between 1995 to 2016 in this datalinkage. This potential makes the match rate in Wales is relatively lower than it in England. We will correct this kind of mismatched situation in Wales in the future.

*_ User suggestions_ *

:dolphin:Below is a brief description of the datasets in UKDA ReShare along with user suggestions::dolphin:

- tranall2011_19.csv is the newly linked data. example. This is the individual transaction data,which can be subset, aggregated directly basing on certains field. R code for trace regional annual house price trends between 2011 and 2018 is offered (example.R), you will have an idea on how to read, subset, aggreate and plot the data;
- epc_id.csv is the Domestic EPCs data which delete LMK_KE,ADDRESS,ADDRESS1,ADDRESS2,ADDRESS3,INSPECTION_DATE, LODGEMENT_DATE,POSTCODE,PROPERTY_TYPE,TOTAL_FLOOR_AREA, NUMBER_HABITABLE_ROOMS fields. The new unique identifier (id) is included in the dataset;
- pp-complete.csv is the Land Registry PPD download from GOV.UK website in December 20, 2019.
- If you perfer to create a new linked data by yourself, you need to understand and accept the licence and copyright for the data and then download. We removed the address and postcode fields, which comes from EPCs, in the linked data to make sure this data is an open data. Please check your copyright notice when you used the address or postcode fields in EPCs dataset(https://epc.opendatacommunities.org/docs/copyright).

## 6. Acknowledgements

The authors would like to thank David Lockett and Caroline Bray of Land Registry, who offered guidance on the Land Registry PPD. Thanks also to Jessica Williamson and Jake Mulley, who helped to transfer our questions on EPCs to the teams in MHCLG, allowing the authors to deepen their understanding of this data set at the end of this research. The authors also would like to thank Rob Liddiard of the UCL Energy Institute for sharing his expertise regarding EPC data during the earlier stages of this research.  
