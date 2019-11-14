# ------------------------------------------------
# ReadEPCcsv.R
# ------------------------------------------------
# Code provided as is and can be used or modified freely. 
#
# ------------------------------------------------
# Author: BIN CHI
# UCL Centre for Advanced Spatial Analysis
# Date: 14/11/2019

setwd("D:/EPC")
#Domestic EPCs: to 31 August 2019
x1 <- list.files(path = ".", pattern = NULL, all.files = FALSE,
                 full.names = FALSE, recursive = FALSE)

folder <- paste("D:/EPC",x1,"certificates.csv",sep="/")


library(data.table)
myfiles = data.table::rbindlist(lapply(folder, data.table::fread, showProgress = FALSE))
dim(myfiles)
#18575357 
#myfiles[!duplicated(myfiles), ]
# no duplicated records

head(myfiles)
myfiles[, LMK_KEY:=NULL]
setDF(myfiles)

library("RPostgreSQL")
library("sqldf")
library("dplyr")
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "datajournal",port=5432, user="postgres",password=232323)
dbWriteTable(con, "data20190831",value =myfiles, append = TRUE, row.names = FALSE)




myfiles[!duplicated(myfiles), ]
dim(myfiles)

myfiles$add1 <- toupper(myfiles$ADDRESS1)
myfiles$add2 <- toupper(myfiles$ADDRESS2)
myfiles$add3 <- toupper(myfiles$ADDRESS3)
myfiles$add <- toupper(myfiles$ADDRESS)
myfiles$id<- rownames(myfiles)
head(myfiles)
epc<-myfiles[,c("add1","add2","add3","add","POSTCODE","PROPERTY_TYPE","INSPECTION_DATE","LODGEMENT_DATE","TOTAL_FLOOR_AREA","NUMBER_HABITABLE_ROOMS","id")]
head(epc)
dim(epc)
colnames(epc)<-c("address1","address2","address3","address","postcode","propertytype","inspectiondate","lodgementdate","tfarea","numberrooms","id")
#18575357       11
dbWriteTable(con, "epc",value =epc, append = TRUE, row.names = FALSE)
