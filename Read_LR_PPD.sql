# ------------------------------------------------
# Read LR PPD in postgis.sql
# ------------------------------------------------
# Code provided as is and can be used or modified freely. 
#
# ------------------------------------------------
# Author: BIN CHI
# UCL Centre for Advanced Spatial Analysis
# Date: 19/12/2019


CREATE TABLE pricepaid
(
  transactionid text NOT NULL,
  price bigint,
  dateoftransfer date,
  postcode text,
  propertytype text,
  oldnew text,
  duration text,
  paon text,
  saon text,
  street text,
  locality text,
  towncity text,
  district text,
  county text,
  categorytype text,
  recordstatus text
)

COPY pricepaid1 FROM 'D:/pp-complete.csv' DELIMITERS ',' CSV QUOTE '"'
##Query returned successfully: 24852949 rows affected, 04:01 minutes execution time.


ALTER TABLE pricepaid ADD yearchi int;

UPDATE pricepaid SET yearchi= date_part('year', dateoftransfer);
#Query returned successfully: 24852949 rows affected, 08:41 minutes execution time.
