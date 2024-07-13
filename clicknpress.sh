today=$(date '+%m-%d')
yest=$(date --date="yesterday" '+%m-%d')

reqtoday=$(curl -s "http://localhost:5600/api/0/buckets/aw-watcher-input_arch/events?start=2024-${today}T04:00:00%2B05:30&end=2024-${today}T22:30:00.000Z" | jq )
reqyest=$(curl -s "http://localhost:5600/api/0/buckets/aw-watcher-input_arch/events?start=2024-${yest}T04:00:00%2B05:30&end=2024-${yest}T22:30:00.000Z" | jq )


clickstoday=$(echo "$reqtoday" | jq '.[] | .data.clicks' |  awk '{s+=$1} END {print s}')
pressestoday=$(echo "$reqtoday" | jq '.[] | .data.presses' |  awk '{s+=$1} END {print s}')

clicksyest=$(echo "$reqyest" | jq '.[] | .data.clicks' |  awk '{s+=$1} END {print s}')
pressesyest=$(echo "$reqyest" | jq '.[] | .data.presses' |  awk '{s+=$1} END {print s}')



echo "Today: ${pressestoday} - ${clickstoday} | Yest: ${pressesyest} - ${clicksyest}"
