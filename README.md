
# Linking Land Registry Price Paid Data (PPD) and Domestic Energy Performance Certificates (EPCs)


This project is the code part of authors' article which will submit in Scientific Data, code will not open until it accepted from the data journel. The linked dataset is under review of UK Data Service. This research is **not** allowed used in **commercial**.

## 1. Getting Started
All matching rules were written in R with data inputs and outputs stored in a PostGIS database.
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

### 1.4 Clean up Land Registry PPD in datajournal database before linkage
 Runing the **Data_cleaning1.sql** to clean up the transaction which are not sold in full market value or property type is 'Other'. Before matching, transactions in Land Registry PPD with postcodes in the Domestic EPCs dataset are selected for linkage; Domestic EPCs dataset with postcodes in Land Registry PPD are also selected.

### 1.5 Read in the ational Statistics Postcode Lookup(NSPL) in datajournal database
Download NSPL (November 2019) from the Open Geography portal from the Office for National Statistics (ONS) (https://geoportal.statistics.gov.uk/datasets/national-statistics-postcode-lookup-november-2019) and the save **NSPL_NOV_2019_UK.csv** in your D Device. Runing the **Read_NSPL.sql** to read in all the NSPL in **datajournal** database.

## 2. Data linkage
Run the **PPD_EPC_linkage.R**.
- ***casa*** is the all the linked results from the four stages matching
- ***result2*** is linked result has the recent EPCs for each transaction  
 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/screenshot_of_linkage_code.png)

## 3. Evaluation of the data linkage 
Run the **Evaluation.R**.
### 3.1 Annual match rate between 1995 and 2019 
![](https://github.com/BINCHI1990/Link-LR-PPD-and-Domestic-EPCs/blob/master/Images/annual_matchrate.png)
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  **Figure 3** Match rate of linked house price in England and Wales,1995-2019


### 3.2 Evaluation of data linkage 
(1) House price distribution of original data and linked data

(2) K-S test and J-divergence method

## 4. Linked PPD between 2011 and 2019

## 5. Data cleaning 

## 6. User note for the linked data


## 7. Acknowledgements

The authors would like to thank David Lockett and Caroline Bray of Land Registry, who offered guidance on the Land Registry PPD. Thanks also to Jessica Williamson and Jake Mulley, who helped to transfer our questions on EPCs to the teams in MHCLG, allowing the authors to deepen their understanding of this data set at the end of this research. The authors also would like to thank Rob Liddiard of the UCL Energy Institute for sharing his expertise regarding EPC data during the earlier stages of this research.  
