#! /bin/bash
FILE="./log"
STRING="alert"
if  grep -q "$STRING" "$FILE" ; then
  echo 'the string exists' ; 
else
  echo 'the string does not exist' ; 
fi
