# ------------------------------------------------
# Read_NSPL.sql
# ------------------------------------------------
# Code provided as is and can be used or modified freely. 
#
# ------------------------------------------------
# Author: BIN CHI
# UCL Centre for Advanced Spatial Analysis
# Date: 19/12/2019


CREATE TABLE nspl2019
(
pcd text, 
pcd2 text,
pcds text,
dointr text,
doterm text, 
usertype int,
oseast1m text,
osnrth1m text,
osgrdind int,
oa11 text, 
cty text, 
ced text,
laua text, 
ward text, 
hlthau text, 
nhser text, 
ctry text, 
gor text, 
pcon text, 
eer text, 
teclec text, 
ttwa text, 
pct text, 
nuts text, 
park text, 
lsoa11 text, 
msoa11 text, 
wz11 text, 
ccg text, 
bua11 text, 
buasd11 text, 
ru11ind text,
oac11 text, 
lat numeric,
long numeric,
lep1 text, 
lep2 text, 
pfa text, 
imd int,
calncv text,
stp text

)

COPY nspl2019 FROM 'D:/NSPL_NOV_2019_UK.csv' DELIMITERS ',' CSV HEADER;
##Query returned successfully:  2636604 rows affected, 52.6 secs execution time.