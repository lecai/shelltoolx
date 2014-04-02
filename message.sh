#!/bin/bash

startTime=$2
endTime=$3
logFile=$1

touch result.log

awk  'BEGIN{FS=","} $1=='1'&&$3>='"$startTime"'&& $3<='"$endTime"' {print $6,$11,$12 > "result.log"}' $logFile 
awk 'BEGIN {
	msgCategoryStatus[0,0]=""
	msgCategory[0]=""
	tables[0]=""
	msgCount=0
}
#运行中
{
	msgCategoryStatus[$2,$3]++
	tables[$1%16]++ 
	msgCategory[$2]++
	msgCount++               
}
#运行后
END {
	for(i in msgCategoryStatus){  
       split(i, array2, SUBSEP);  
       print array2[1]" * "array2[2]" = " msgCategoryStatus[i];  
    } 
    printf"消息类目\n" 
    printf"================================================================================================\n"

	for(category in msgCategory){  
       print category ":" msgCategory[category]
    } 

    printf"分库\n" 
    printf"================================================================================================\n"

	for(table in tables){  
       print table ":" tables[table]
    }  

    printf"消息量\n" 
    printf  msgCount "\n"
   					
}
' result.log

rm -fr result.log
