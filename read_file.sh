#! /bin/bash
input="./log"
while IFS= read -r line
do
  echo "$line"
done < "$input"