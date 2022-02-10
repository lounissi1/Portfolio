LOAD DATA
APPEND
INTO TABLE Route
fields terminated by ',' optionally enclosed by '"'
(pRoute "NULL",
cRoute "NULL",
nLatOri FLOAT,
nLongOri FLOAT,
nLatDes FLOAT,
nLongDes FLOAT,
nDistance FLOAT)
