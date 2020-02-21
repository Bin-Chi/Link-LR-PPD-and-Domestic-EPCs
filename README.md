
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


### 3.2 Evaluation of data linkage 
(1) House price distribution of original data and linked data

(2) K-S test and J-divergence method

### 3.3 Linked PPD between 2011 and 2019
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Table 1** Summary of the matching for property type, 2011-2019
 

| Property type | Land Registry PPD | Linked data | Match rate |
|  ---      |    ---       |     ---   |   ---    |
| Detached   | 1,802,813     | 1,682,801    |93.34%    |
| Flats/Maisonettes    | 1,369,376       | 1,213,548     | 88.62%      |
| Semi-Detached    | 2,001,380       | 1,901,929      | 95.03%   |
| Terraced    | 2,075,690      | 1,955,057    | 94.19%     |



## 4. Data cleaning 

6,753,307 records of linked data can be geo-referenced by linking the NSPL between 1/1/2011 and 31/10/2019 in England and Wales. This data comprises the transaction information in the Land Registry PPD together with property size (total floor area and number of habitable rooms) in EPCs. Some properties’ total floor area and number of habitable rooms are recorded in EPCs with missing or untenable values (e.g. total floor area records as 0.01). This data is excluded prior to analysis. Code for this section is **Data_clean.R**.


## 5. User note for the linked data
One final data set is associated with this work – the linked geo-referenced  PPD dataset for January 2011 to October 2019. This new linked dataset details 5,732,838 transactions in England and Wales along with each property's total floor area and the number of habitable rooms, but also includes a new unique identifier (epcid) allowing us to link properties within the EPC dataset. Codes for other commonly used spatial units from Output Area (OA) to region are also included in the dataset. Table 2 shows the description of the   fields in the newly linked data.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Table 2** Explanations of information fields in the new attribute-linked residential property price dataset
 


| Field name | Explanation| Data resource |  |
|  ---      |    ---       |     ---   |   ---    |


|  priceper|   house price per square metre   |   Authors' own  |    |
|  price    |           |  HM Land Registry    |      |
| transactionid  |    |  HM Land Registry   |    |
| postcode  |      |    HM Land Registry |  |
|   |      |  HM Land Registry   |   |
|   |      |  HM Land Registry   |    |
|   |      |  HM Land Registry   |    |
|   |      |   HM Land Registry  |    |
|   |      |   HM Land Registry  |    |
|   |      |   HM Land Registry  |    |
|   |      |    HM Land Registry |    |
|   |      |    HM Land Registry |    |
|   |      |    HM Land Registry |    |
|   |      |   Authors' own  |    |
|   |      |   Authors' own  |    |
|   |      |    MHCLG |    |
|   |      |   MHCLG |    |
|   |      |   MHCLG|    |
|   |      |   NSPL  |    |
|   |      |   NSPL |    |
|   |      |   NSPL |    |

***NOTE:*** Since for the address string of same property between Land Registry PPD and Domestic EPCs are sometime different (e.g. 'WOODLANDS PARK' VS 'WOODLAND PARK'; 'CLEATOR STREET' VS 'CLEATER STREET'), we only manual correct this mismatched address string for the property located in England between 1995 to 2016 in this datalinkage. This potential makes the match rate in Wales is relatively lower than it in England. We will correct this kind of mismatched situation in Wales in the future.


## 6. Acknowledgements

The authors would like to thank David Lockett and Caroline Bray of Land Registry, who offered guidance on the Land Registry PPD. Thanks also to Jessica Williamson and Jake Mulley, who helped to transfer our questions on EPCs to the teams in MHCLG, allowing the authors to deepen their understanding of this data set at the end of this research. The authors also would like to thank Rob Liddiard of the UCL Energy Institute for sharing his expertise regarding EPC data during the earlier stages of this research.  
