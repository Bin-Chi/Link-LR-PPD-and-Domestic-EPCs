
# Linking Land Registry Price Paid Data (PPD) and Domestic Energy Performance Certificates (EPCs)


This project is the code part of authors' article which will submit in Scientific Data, code will not open until it accepted from the data journel. The linked dataset is under review of UK Data Service. This research is **not** allowed used in **commercial**.

## 1. Getting Started
All matching rules were written in R with data inputs and outputs stored in a PostGIS database.


&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Figure 1  A work flow of this project
### 1.1 Create a new PostgreSQL database
Create a new PostgreSQL and named as **datajournal**. Here, the password of postgres user is assumed to be **123456**.


### 1.2 Set the working directory for R
Process of setting working directory is listed below:
- Create a directory named "R" in your D Device.
- Create a sub-directory named "matchcasa1" in "R" folder.  
- Put the **rulechi.csv** file in the "matchcasa1" folder.
- Put the **geo1.csv** file in the "matchcasa1" folder.

***NOTE:*** If you would like to change your working directory, you also need to change the filepath of **setwd("D:/R/matchcasa1")** and **setwd("D:/R")** in the R code (PPD_EPC_linkage.R).


### 1.3 Read in the Land Registry PPD in datajournal database
Download Land Registry PPD from UK goverment website (https://www.gov.uk/government/statistical-data-sets/price-paid-data-downloads) and  the save **pp-complete.csv** in your D Device. Runing the **Read_LR_PPD.sql** to read in all the Land Registry PPD in **datajournal** database

### 1.4 Read in Domestic EPCs in datajournal database
Domestic EPCs is open and available on-line from the Ministry for Housing, Communities and Local Government - MHCLG (https://epc.opendatacommunities.org/).The current EPC dataset is the third released version and contains certificates issued between 1/10/2008 and 31/5/2019.The third version records 18,575,357 energy performance data records with 84 fields. 


### 1.5 Clean up Land Registry PPD in datajournal database before linkage
 Runing the **Data_cleaning1.sql** to clean up the transaction which are not sold in full market value or property type is 'Other'. Before matching, transactions in Land Registry PPD with postcodes in the Domestic EPCs dataset are selected for linkage; Domestic EPCs dataset with postcodes in Land Registry PPD are also selected.


### 1.6 Read in the National Statistics Postcode Lookup(NSPL) in datajournal database
Download NSPL (November 2019) from the Open Geography portal from the Office for National Statistics (ONS) (https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-november-2019) and the save **NSPL_NOV_2019_UK.csv** in your D Device. Runing the **Read_NSPL.sql** to read in all the NSPL in **datajournal** database.

## 2. Data linkage
Run the **PPD_EPC_linkage.R**. A screenshot of PPD_EPC_linkage R code is shown in Figure 2. Utilizing this R code, two result data are achieve:
- ***casa*** is the all the linked results from the four stages matching
- ***result2*** is linked result has the recent EPCs for each transaction  
 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/screenshot_of_linkage_code.png)
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Figure 2.** Snapshot of the PPD_EPC_linkage R code
## 3. Evaluation of the data linkage 
Run the **Evaluation.R**.
### 3.1 Annual match rate between 1995 and 2019 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/annual_matchrate.png)
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Figure 3.** Match rate of linked house price in England and Wales,1995-2019

The match rate between 2011 and 2019 is higher than 90%, while the match rate of the rest of the period is considerably lower, this is mainly due to the publicly available EPCs dataset only covering the period between 1/10/2008 and 31/8/2019. The match rate of 56.20% in 2008 is particularly low but rapidly increases to over 88 % after 2010. Since the match rate before 2008 is significantly lower than for the period after 2008, only the linked data between 2009 and 2019 are used to conduct the evaluation of data linkage.
### 3.2 Evaluation of data linkage between 2009 and 2019
(1) House price distribution of original data and linked data
Match rates offer a crude way to quantify the matching performance, but visual comparison of the house price frequency distributions for the new linked data and unlinked PPD data reveals a clearer picture of matching performance.  Detials seen the article.
(2) K-S test and J-divergence method
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
Looking at annual match rates across local authorities in England and Wales (Figure 7), 70% of local authorities have an annual match rate over 90% for every year from 2011 to 2019, while 98% have a match rate over 80% for every year. Detials seen the article.

## 4. Data cleaning 

6,753,307 records of linked data can be geo-referenced by linking the NSPL between 1/1/2011 and 31/10/2019 in England and Wales. This data comprises the transaction information in the Land Registry PPD together with property size (total floor area and number of habitable rooms) in EPCs. Some properties’ total floor area and number of habitable rooms are recorded in EPCs with missing or untenable values (e.g. total floor area records as 0.01). This data is excluded prior to analysis. Code for this section is **Data_clean.R**.


## 5. User note for the linked data
One final data set is associated with this work – the linked geo-referenced  PPD dataset for January 2011 to October 2019. This new linked dataset details 5,732,838 transactions in England and Wales along with each property's total floor area and the number of habitable rooms, but also includes a new unique identifier (id) allowing us to link properties within the EPC dataset. Codes for other commonly used spatial units from Output Area (OA) to region are also included in the dataset. Table 2 shows the description of the   fields in the newly linked data.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Table 2.** Explanations of information fields in the new attribute-linked residential property price dataset
 


| Field name | Explanation| Data resource |  e.g|
|  ---      |    ---       |     ---   |   ---    |
|  id |  a unique identifier in Domestic EPCs   |    Authors' own |    |
|  transactionid |  Transaction unique identifier    |  HM Land Registry   |   |
|  msoa11 |      |   NSPL  |    |
| postcode  |      |  HM Land Registry   |    |
|  price |   Sale price (transfer deed)   |  HM Land Registry   |    |
| dateoftransfer  | Date when the sale was completed     |   HM Land Registry  |    |
| propertytype  | Indicates the type of house:  D = Detached, S = Semi-Detached, T = Terraced, F = Flats/Maisonettes   |   HM Land Registry  |    |
|  oldnew |  Y refers a newly built property and N refers an established residential building. . If the property is firstly sold since 1995 it will identify as ‘a newly built property’   |   HM Land Registry  |    |
| duration  |  The tenure of property: freehold, leasehold    |    HM Land Registry |    |
|  paon |  Primary Addressable Object Name    |    HM Land Registry |    |
|  saon |    Secondary Addressable Object Name.   |    HM Land Registry |    |
| street  |      |    HM Land Registry |    |
|locality  |      |    HM Land Registry |    |
| towncity  |      |    HM Land Registry |    |
| district  |      |    HM Land Registry |    |
| county  |      |    HM Land Registry |    |
| categorytype |      |    HM Land Registry |    |
| crecordstatus | Indicates additions, changes and deletions to the records: A = Addition; C = Change; D = Delete. |    HM Land Registry |    |
|year |      |    Authors' own |    |
| oa11  |      |   NSPL |    |
|lsoa11   |      |   NSPL |    |
|  laua |      |   NSPL |    |
| ldnm  |      |    |    |
| RGN11NM   |      |     |    |
| gor  |      |     |    |
| classt |      |   Authors' own  |    |
| propertytype_epc  |      |   MHCLG |    |
|  inspectiondate |   The date that the inspection was actually carried out by the energy assessor.   |   MHCLG|    |
|  lodgementdate |  Date lodged on the Energy Performance of Buildings Register.    |   MHCLG|    |
|  tfarea|   The total useful floor area is the total of all enclosed spaces measured to the internal face of the external walls, the gross floor area as measured in accordance with the guidance issued from time to time by the Royal Institute of Chartered Surveyors or by a body replacing that institution.   |   MHCLG|    |
|  numberrooms | Habitable rooms include any living room, sitting room, dining room, bedroom, study and similar; and also a non-separated conservatory. A kitchen/diner having a discrete seating area (with space for a table and four chairs) also counts as a habitable room. A non-separated conservatory adds to the habitable room count if it has an internal quality door between it and the dwelling. Excluded from the room count are any room used solely as a kitchen, utility room, bathroom, cloakroom, en-suite accommodation and similar; any hallway, stairs or landing; and also any room not having a window     |   MHCLG|    |
|  priceper|   house price per square metre   |   Authors' own  |    |


***NOTE:*** Since for the address string of same property between Land Registry PPD and Domestic EPCs are sometime different (e.g. 'WOODLANDS PARK' VS 'WOODLAND PARK'; 'CLEATOR STREET' VS 'CLEATER STREET'), we only manual correct this mismatched address string for the property located in England between 1995 to 2016 in this datalinkage. This potential makes the match rate in Wales is relatively lower than it in England. We will correct this kind of mismatched situation in Wales in the future.


## 6. Acknowledgements

The authors would like to thank David Lockett and Caroline Bray of Land Registry, who offered guidance on the Land Registry PPD. Thanks also to Jessica Williamson and Jake Mulley, who helped to transfer our questions on EPCs to the teams in MHCLG, allowing the authors to deepen their understanding of this data set at the end of this research. The authors also would like to thank Rob Liddiard of the UCL Energy Institute for sharing his expertise regarding EPC data during the earlier stages of this research.  
