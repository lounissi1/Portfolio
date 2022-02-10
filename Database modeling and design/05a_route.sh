#!/bin/ksh

userid="ab391926"
psw="EQmzhNXd"
cstring="localhost"

#/home/ab391926
#INF3080_20193

datafilename="/home/ab391926/05a_route.txt"
ctlfilename="/home/ab391926/05a_route.ctl"
logfilename="/home/ab391926/05a_route.log"

sqlldr $userid/$psw data=$datafilename control=$ctlfilename log=$logfilename bad="/home/ab391926/05a_route.bad"

result=$?

if [[ $result -eq 0 ]] then
echo 'Data loaded successfully.'
else
echo 'Data load failed.'
fi

exit $result
