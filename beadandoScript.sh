#!/bin/bash

while getopts erh option1
do
case "${option1}"
in
e)
	while getopts f:t:a: option2
	do
	case "${option2}"
	in
	f) from=${OPTARG};;
	t) to=${OPTARG};;
	a) amount=${OPTARG};;

	esac
	done

	data="http://free.currencyconverterapi.com/api/v5/convert?q="
   	data="${data}${from}_"
   	data="${data}${to}&compact=ultra&apiKey=785582b9aa17c0348556"
   	data=$(curl -s $data)

   	rate=${data#*:}
   	rate=${rate::-1}
   	result=$(awk "BEGIN {print $amount * $rate}")

   	echo "The exchange rate: ${rate}"
   	echo "${amount} ${from} equals to ${result} ${to}"
;;
r)
	while getopts f:t: option3
	do
	case "${option3}"
	in
	f) from=${OPTARG}
	   currencyArray=($(echo "$from" | tr ',' '\n'));;
	t) to=${OPTARG};;

	esac
	done

	arrayLength=${#currencyArray[@]}
	data="http://free.currencyconverterapi.com/api/v5/convert?q="
	echo "I------------------------I"
	echo "I CURRENCY || VALUE($to) I"
	echo "I------------------------I"

	for (( i=0; i<$arrayLength; i++ ))
	do
		data="${data}${currencyArray[$i]}_"
		data="${data}${to}&compact=ultra&apiKey=785582b9aa17c0348556"
		data=$(curl -s $data)

		rate=${data#*:}
		rate=${rate::-1}

		echo "    ${currencyArray[$i]}    || $rate  "
		echo "I------------------------I"
		data="http://free.currencyconverterapi.com/api/v5/convert?q="
	done

;;
h)
	echo ""
	echo "I---------------------------------------------------------------------------HELP-----------------------------------------------------------------------------I"
	echo "I Exchanging an amount of money from a currency to another currency. --> -e -f CURRENCYFROM(ex.: USD) -t CURRENCYTO(ex.: HUF) -a AMOUNT                      I" 
	echo "I Listing out the exchange rate(s) of the given currency/currencies to another currency. --> -r -f CURRENCIESFROM(ex.: USD,EUR,RUB) -t CURRENCYTO(ex.: HUF)  I"
	echo "I---------------------------------------------------------------------------HELP-----------------------------------------------------------------------------I"
	echo ""
;;
esac
done



currencyArray=($(echo "$list" | tr ',' '\n'))

