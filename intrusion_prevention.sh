#!/bin/bash

FILE_LOG="/var/log/snort/alert"
OUT_LOG=$(egrep -i --color "Priority: 1|Priority: 2" $FILE_LOG)

LOG_FILTER="/var/log/alerts_IPS_IDS/log.txt"
echo "$OUT_LOG" > $LOG_FILTER
cat $LOG_FILTER | tail -n 50  > /var/log/alerts_IPS_IDS/message.txt

# Get counter log
COUNTER=$(egrep -c "Priority: 1|Priority: 2" $FILE_LOG)

# Read counter temporal
FILE_COUNTER="/var/log/alerts_IPS_IDS/counter.txt"
VAR_COUNTER=$(cat $FILE_COUNTER)

if [ $COUNTER -gt $VAR_COUNTER ] ; then
  echo "$COUNTER" > $FILE_COUNTER
  echo "Notificacion IPS/IDS" ;

  FILE_MSG="/var/log/alerts_IPS_IDS/message.txt"

  # Send alert
  to="help@keos.co"
  sb="Notificacion IPS/IDS"
  bd=$(cat $FILE_MSG)

  fecha=$(date +"%Y-%m-%d %H:%M:%S.%N")

  sb1=$(echo $sb | tr -d '\n')
  sb2=$(echo $sb1 | tr -d '\r')

  bd1=$(echo $bd | tr -d '\n')
  bd2=$(echo $bd1 | tr -d '\r')

  respuesta=$(curl -s --user 'api:key-2tegd5ku7qmsbltod6vhl9e635bz0vn1' https://api.mailgun.net/v3/teamempresa.com/messages -F from='endianfw@teamsourcing.com.ec' -F to="$to" -F subject="$sb" -F text="$bd")

  resp1=$(echo $respuesta | tr -d '\n')

  resp=$(echo $resp1 | tr -d ' ')

  echo "$fecha --> resp   :$resp " >> /var/log/alerts_IPS_IDS/email_notification.log

else
  echo '' ;
fi
