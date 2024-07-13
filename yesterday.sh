#!/bin/env bash

today=$(date '+%m-%d')
yesterday=$(date --date="yesterday" '+%m-%d')

request=$(curl -s 'http://localhost:5600/api/0/query/' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Origin: http://localhost:5600' \
  -H 'Pragma: no-cache' \
  -H 'Referer: http://localhost:5600/' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-GPC: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Chromium";v="124", "Brave";v="124", "Not-A.Brand";v="99"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --data-raw '{"query":["afk_events = query_bucket(find_bucket(\"aw-watcher-afk_\"));","events = filter_keyvals(afk_events, \"status\", [\"not-afk\"]);","RETURN = sum_durations(events);",";"],"timeperiods":["2024-'$yesterday'T03:00:00+05:30/2024-'$today'T03:00:00+05:30"]}' | sed 's/\[//g' | sed 's/\]//g')

#echo $request

totaltime=$(date -d@$request -u '+%Hh %Mm')
echo Yesterday: $totaltime
