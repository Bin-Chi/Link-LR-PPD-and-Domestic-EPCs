# ------------------------------------------------
# PPD_EPC_linkage.R
# ------------------------------------------------
# Code provided as is and can be used or modified freely. 
#
# ------------------------------------------------
# Author: BIN CHI
# UCL Centre for Advanced Spatial Analysis
# bin.chi.16@ucl.ac.uk
# Date: 19/12/2019



####### Read in data from postgis ######
# Packages
library("ggplot2")
library("sqldf")
library("RPostgreSQL")
library("stringr")


drv <- dbDriver("PostgreSQL")
# Creates a connection to the postgres database
con <- dbConnect(drv, dbname = "datajournal",port=5432, user="postgres",password=******)
# Import data
tran <- dbGetQuery(con,"select * from tranexit")
epc <- dbGetQuery(con,"select * from epcformatch")

#understand the data time coverage
min(epc$lodgementdate)
#"2008-10-01"
max(epc$lodgementdate)
#"2019-08-31"
max(tran$dateoftransfer)
#"2019-10-31"
min(tran$dateoftransfer)
#"1995-01-01"