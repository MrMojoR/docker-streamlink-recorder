#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

while [ true ]; do
	Date=$(date +%Y%m%d-%H%M%S)
	streamlink --twitch-proxy-playlist=https://lb-eu.cdn-perfprod.com,https://lb-eu2.cdn-perfprod.com,https://eu.luminous.dev,https://eu2.luminous.dev $apiKey $streamLink $streamQuality -o /home/download/$streamName"-$Date".mkv
	sleep 60s
done
