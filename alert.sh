#!/bin/bash

FILE_LOG="/var/log/snort/alert"

LOG=$(egrep -i --color "Priority: 1|Priority: 2" $FILE_LOG)
echo "$LOG" > log.txt

cat log.txt | head -n 20 | tail -n 10  > message.txt

COUNTER=$(egrep -c "Priority: 1|Priority: 2" $FILE_LOG)
#echo $COUNTER


# Read counter
VAR_COUNTER=$(cat /root/projects/alerts/counter.txt)
#echo $VAR_COUNTER

if [ $COUNTER -gt $VAR_COUNTER ] ; then
  echo $COUNTER > counter.txt
  echo "Alerta de Prevención de Intrusos" ;

  # Send alert
  to=$1
  sb=$2
  bd=$(cat /root/projects/alerts/message.txt)

  fecha=$(date +"%Y-%m-%d %H:%M:%S.%N")

  sb1=$(echo $sb | tr -d '\n')
  sb2=$(echo $sb1 | tr -d '\r')

  bd1=$(echo $bd | tr -d '\n')
  bd2=$(echo $bd1 | tr -d '\r')

  respuesta=$(curl -s --user 'api:key-2tegd5ku7qmsbltod6vhl9e635bz0vn1' https://api.mailgun.net/v3/teamempresa.com/messages -F from='endianfw@teamsourcing.com.ec' -F to="$to" -F subject="$sb" -F text="$bd")

  resp1=$(echo $respuesta | tr -d '\n')

  resp=$(echo $resp1 | tr -d ' ')

  echo "$fecha --> resp   :$resp " >> /var/log/email_notification.log

else
  echo '' ;
fi