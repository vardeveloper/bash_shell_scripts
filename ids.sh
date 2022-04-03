#! /bin/bash

#FILE_LOG="/var/log/snort/alert"
FILE_LOG="./log"

LOG=$(egrep -i --color "Priority: 1|Priority: 2" $FILE_LOG)
echo "$LOG" > log.txt

cat log.txt | head -n 20 | tail -n 10  > message.txt

COUNTER=$(egrep -c "Priority: 1|Priority: 2" $FILE_LOG)
echo $COUNTER


# Read counter
FILE_COUNTER="./counter.txt"
while IFS= read -r line
do
  echo $line
  if [ $COUNTER -gt $line ] ; then
    echo "$COUNTER" > counter.txt
    echo "Alerta de Prevención de Intrusos" ;
  else
    echo '' ; 
  fi
done < "$FILE_COUNTER"
