#!/bin/bash

startTime=$2
endTime=$3
minRt=$4
logFile=$1

touch result.log

awk  'BEGIN{FS=" "} $3>='"$minRt"' && substr($5,2)>="'"$startTime"'" && substr($5,2)<="'"$endTime"'" {print $3,substr($5,2),$8 > "result.log"}' $logFile 
awk 'BEGIN {
    array_100ms[0]="0-100ms"
	array_200ms[0]="100-200ms"
	array_300ms[0]="200-300ms"
	array_500ms[0]="300-500ms"
    array_1000ms[0]="500-1000ms"
	array_2000ms[0]="1000-2000ms"
	array_3000ms[0]="2000-3000ms"
	array_4000ms[0]="3000-5000ms"
	array_5000ms[0]="5000"
	methodRtArray[0,0]=""
		methodNumArray[0]=""
}
#运行中
{
    if($1 >0 && $1<100000){
    	calc(methodRtArray, $3, $2,1,methodNumArray)
    }
    if($1 >=100000 && $1<200000){
    	calc(methodRtArray, $3, $2,2,methodNumArray)
    }
    if($1 >=200000 && $1<300000){
    	calc(methodRtArray, $3, $2,3,methodNumArray)
    }
    if($1 >=300000 && $1<500000){
    	calc(methodRtArray, $3, $2,4,methodNumArray)
    }
    if($1 >=500000 && $1<1000000){
    	calc(methodRtArray, $3, $2,5,methodNumArray)
    }
    if($1 >=1000000 && $1<2000000){
    	calc(methodRtArray, $3, $2,6,methodNumArray)
    }
    if($1 >=2000000 && $1<3000000){
    	calc(methodRtArray, $3, $2,7,methodNumArray)
    }
    if($1 >=3000000 && $1<5000000){
    	calc(methodRtArray, $3, $2,8,methodNumArray)
    }
    if($1 >=5000000 ){
    	calc(methodRtArray, $3, $2,9,methodNumArray)
    }                 
}
#运行后
END {
	for(k in methodNumArray){  
		if(k!=0){
	        printf k": "
	        if(methodRtArray[k,1]){
	       		printf "0ms-100ms: "methodRtArray[k,1]";"
	        }	        
	        if(methodRtArray[k,2]){
	       		printf "100ms-200ms: "methodRtArray[k,2]";"
	        }
	        if(methodRtArray[k,3]){
	       		printf "200ms-300ms: "methodRtArray[k,3]";"
	        }
	        if(methodRtArray[k,4]){
	       		printf "300ms-500ms: "methodRtArray[k,4]";"
	        }
	        if(methodRtArray[k,5]){
	       		printf "500ms-1s: "methodRtArray[k,5]";"
	        }
	        if(methodRtArray[k,6]){
	       		printf "1s-2s: "methodRtArray[k,6]";"
	        }
	        if(methodRtArray[k,7]){
	       		printf "2s-3s: "methodRtArray[k,7]";"
	        }
	        if(methodRtArray[k,8]){
	       		printf "3s-5s: "methodRtArray[k,8]";"
	        }
	        if(methodRtArray[k,9]){
	       		printf "5s以上: "methodRtArray[k,9]";"
	        }       
	        printf"\n"  			
		}
        
   }					

}

function calc(array, line, time,timeIndex,methodNumArray){
	lastIndex = index(line,"?")
	startIndex =  index(line,"com")
	method=""
	if(lastIndex>0){
		method = substr(line,startIndex+4,(lastIndex-startIndex-4))
	}else{
		method = substr(line,startIndex+4)
		method = substr(method,1,length(method)-1)
	}
	array[method,timeIndex]++
	methodNumArray[method]=method
}
' result.log

rm -fr result.log
