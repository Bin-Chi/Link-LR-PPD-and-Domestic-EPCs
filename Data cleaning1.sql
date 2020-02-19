# ------------------------------------------------
# Data_cleaning1.sql
# ------------------------------------------------
# Code provided as is and can be used or modified freely. 
#
# ------------------------------------------------
# Author: BIN CHI
# UCL Centre for Advanced Spatial Analysis
# Date: 19/12/2019


###clean the Land Registry PPD before the do the linkage with EPC

DELETE FROM  pricepaid WHERE categorytype='B';
#Query returned successfully: 719831 rows affected, 01:06 minutes execution time.

DELETE FROM  pricepaid WHERE propertytype='O';
#Query returned successfully: 0 rows affected, 5.4 secs execution time.

SELECT * INTO tranexit FROM pricepaid WHERE postcode IN (SELECT DISTINCT postcode FROM epc)
####Query returned successfully: 23999656 rows affected, 05:47 minutes execution time.

SELECT * INTO epcformatch FROM epc WHERE  postcode IN (SELECT DISTINCT postcode FROM tranexit)
######Query returned successfully: 17160851 rows affected, 14:01 minutes execution time.
#### tranexit and epcformatch are used to go the linkage process
