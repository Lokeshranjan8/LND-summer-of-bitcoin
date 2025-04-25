#!/bin/bash

# I successfully tested filling up the mempool using btcd and btcwallet by 
# generating and sending a large number of transactions through bash scripts. 
# The process was functionally successful, but I observed that it takes a significant amount of time to fill up the mempool 
# — especially when aiming for a size close to 2GB



BTCCTL_CMD="btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --wallet --notls"
LIMIT_BYTES=$((2 * 1024 * 1024 * 1024))
AVG_TX_SIZE=600  
CHECK_INTERVAL=50

# Unlock once
$BTCCTL_CMD walletpassphrase "lokesh" 99999999 &

for ((i = 1; i <= 100000; i++)); do
  ADDR=$($BTCCTL_CMD getnewaddress)
  $BTCCTL_CMD sendtoaddress "$ADDR" 0.001 > /dev/null &

  if (( i % CHECK_INTERVAL == 0 )); then
    wait 
    COUNT=$($BTCCTL_CMD getrawmempool | jq 'length')
    SIZE_EST=$((COUNT * AVG_TX_SIZE))
    SIZE_MB=$(echo "scale=2; $SIZE_EST / 1024 / 1024" | bc)

    echo "[#${i}] TX Count: $COUNT | Est. Size: ${SIZE_MB} MB"

    if (( SIZE_EST >= LIMIT_BYTES )); then
      echo "eached ~2 GB mempool. Done."
      break
    fi
  fi
done



# //TOO SLOW PROCESS
# btcctl --regtest --rpcserver=127.0.0.1:18332   -u rpcuser -P rpcpass --wallet --notls getmempoolinfo
# {
#   "size": 501,
#   "bytes": 112942
# }

