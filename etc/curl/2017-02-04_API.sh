#!/usr/bin/env sh

# A script that downloads an event log file
# Requires cURL http://curl.haxx.se/

# Event Type: API
# Log Date: 2017-02-04
# File Size (in Bytes): 2,710,932.0
curl --compressed "https://eu11.salesforce.com/services/data/v32.0/sobjects/EventLogFile/0AT0Y000000lIfLWAU/LogFile" -H "Authorization: Bearer 00D0Y000000bhrn!ARAAQMT9IcmQE0rsja4d0RlsMjuJbohc.uLn4QBOIfZtPfDPeagPF9xg_PBAJtQgyN4dKNBF6Bx1kWFq5hjTDh6AZD2JKZ4h" -o "2017-02-04_API.csv"
