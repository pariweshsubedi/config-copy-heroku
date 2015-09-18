#!/bin/bash

set -e

sourceApp="$1"
targetApp="$2"
configPayload=()

while read key value; do
  key=${key%%:}
  echo "Reading $key=$value"
  
  if [ $key != "DATABASE_URL" ]
  	then
  	configPayload+=("$key=$value")	
  fi
  
done  < <(heroku config --app "$sourceApp" | sed -e '1d')

heroku config:set "${configPayload[@]}" --app $targetApp
