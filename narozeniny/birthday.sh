#!/bin/bash

#Setting the initial variables
set -euo pipefail
IFILE="./birthday.csv";
MAILID="sar.kolaru@gmail.com";

# Retrieving today's date and month

DAT=`date '+%d %m'`;
DAY=${DAT:0:2};
MON=`echo ${DAT:3} | awk '{print toupper($0);}'`;

# Reading the bday.csv file and finding the users whose 
# date matches with today and writing to OFILE

while IFS=";" read -r name day month bs;
do
        echo "Jmeno: $name";
        echo "Den: $day";
        echo "Mesic: $month";
     
        if [ $day = $DAY -a $month = $MON ]
        then
            n=$name;
        fi
done < $IFILE;

#If OFILE has some data, header is added and the file
#is mailed to the respective users in MAILID.

if [ "$n" != "" ]
then
   echo "$n" | mail -s "Narozeniny dne: $DAT má $n" $MAILID
   
else
   echo "Dnes nemá žádný kolega narozeniny";
fi

