#!/bin/bash

startTime=$2
endTime=$3
minRt=$4


awk  'BEGIN{FS=" "} $3>$4 {print $3,$5,$8 > "tt.log"}'  test.log 
# awk  '$1>=10 && $2 >="[15/Mar/2014:23:57" && $2 <="[15/Mar/2014:23:58" {print $1,$2,$3}' tt.log 
awk  '$1>='"$minRt"' && $2>="'"$startTime"'" && $2<="'"$endTime"'" {print $1,$2,$3 > "result.log"}' tt.log 
awk 'BEGIN {
	    printf "start1\n"
    array_100ms[0]="0-100ms"
	array_200ms[0]="100-200ms"
	array_300ms[0]="200-300ms"
	array_500ms[0]="300-500ms"
    array_1000ms[0]="500-1000ms"
	array_2000ms[0]="1000-2000ms"
	array_3000ms[0]="2000-3000ms"
	array_4000ms[0]="3000-5000ms"
	array_5000ms[0]="5000"

    printf "start\n"
}
#运行中
{
    if($1 >0 && $1<100000){
    	calc(array_100ms, $3, $2)
    }
    if($1 >=100000 && $1<200000){
    	calc(array_200ms, $3, $2)
    }
    if($1 >=200000 && $1<300000){
    	calc(array_300ms, $3, $2)
    }
    if($1 >=300000 && $1<500000){
    	calc(array_400ms, $3, $2)
    }
    if($1 >=500000 && $1<1000000){
    	calc(array_1000ms, $3, $2)
    }
    if($1 >=1000000 && $1<2000000){
    	calc(array_2000ms, $3, $2)
    }
    if($1 >=2000000 && $1<3000000){
    	calc(array_3000ms, $3, $2)
    }
    if($1 >=3000000 && $1<5000000){
    	calc(array_4000ms, $3, $2)
    }
    if($1 >=5000000 ){
    	calc(array_50000ms, $3, $2)
    }                 
}
#运行后
END {

    printf "===============0-100ms  start======================\n"
	for(k in array_100ms){if(k!=0){print k;}}
	printf "===============0-100ms  end======================\n"

	printf "===============100-200ms  start======================\n"
	for(k in array_200ms){if(k!=0){print k;}}
	printf "===============100-200ms  end======================\n"

	printf "===============200-300ms  start======================\n"
	for(k in array_300ms){if(k!=0){print k;}}
	printf "===============200-300ms  end======================\n"

	printf "===============300-500ms  start======================\n"
	for(k in array_400ms){if(k!=0){print k;}}
	printf "===============300-500ms  end======================\n"

	printf "===============500-1000ms  start======================\n"
	for(k in array_1000ms){if(k!=0){print k;}}
	printf "===============500-1000ms  end======================\n"

	printf "===============1-2s  start======================\n"
	for(k in array_2000ms){if(k!=0){print k;}}
	printf "===============1-2s  end======================\n"

	printf "===============2-3s  start======================\n"
	for(k in array_3000ms){if(k!=0){print k;}}
	printf "===============2-3s  end======================\n"

	printf "===============3-5s  start======================\n"
	for(k in array_40000ms){if(k!=0){print k;}}
	printf "===============3-5s  end======================\n"	

	printf "===============5s以上  start======================\n"
	for(k in array_50000ms){if(k!=0){print k;}}
	printf "===============5s以上  end======================\n"					

}

function calc(array, line, time){
	lastIndex = index(line,"?")
	startIndex =  index(line,"com")
	method=""
	if(lastIndex>0){
		method = substr(line,startIndex+4,(lastIndex-startIndex-4))
	}else{
		method = substr(line,startIndex+4)
	}
	array[method]=time
}
' result.log

rm -fr  tt.log
rm -fr result.log
