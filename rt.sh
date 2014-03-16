#!/bin/bash

startTime=$2
endTime=$3
minRt=$4

echo $startTime
echo $endTime
echo $minRt



awk  'BEGIN{FS=" "} $3>$4 {print $3,$5,$8 > "tt.log"}'  test.log 
# awk  '$1>=10 && $2 >="[15/Mar/2014:23:57" && $2 <="[15/Mar/2014:23:58" {print $1,$2,$3}' tt.log 
awk  '$1>='"$minRt"' && $2>="'"$startTime"'" && $2<="'"$endTime"'" {print $1,$2,$3 > "result.log"}' tt.log 
awk 'BEGIN {
	    printf "start1\n"
    array_100ms[0]="0-100ms"
	array_200ms[0]="100-200ms"


    printf "start\n"
}
#运行中
{
    if($1 >0 && $1<10000){
    	array_100ms[$1]=$3
    }
    if($1 >=10000 && $1<20000){
    	array_200ms[$1]=$3
    }
}
#运行后
END {

	for(k in array_100ms){if(k!=0){print k,array_100ms[k];}}
	# for(i=1;i<length(array_100ms);i++){print array_100ms[i];}
	# for(i=1;i<length(array_200ms);i++){print array_200ms[i];}

}' result.log

rm -fr  tt.log
rm -fr result.log
