#!/bin/bash

# Config
WALLET="rbf-A"  
LIMIT_BYTES=$((2 * 1024 * 1024 * 1024))  # 2GB
AVG_TX_SIZE=600
CHECK_INTERVAL=50
UNLOCK_SECONDS=99999999  

BITCOIN_CLI="bitcoin-cli --regtest -rpcwallet=$WALLET"

echo "Starting mempool filler for bitcoind..."

for ((i = 1; i <= 10000000; i++)); do
  ADDR=$($BITCOIN_CLI getnewaddress)

  $BITCOIN_CLI sendtoaddress "$ADDR" 0.0001 > /dev/null

  if (( i % CHECK_INTERVAL == 0 )); then
    SIZE_BYTES=$($BITCOIN_CLI getmempoolinfo | jq .bytes)
    SIZE_MB=$(echo "scale=2; $SIZE_BYTES / 1024 / 1024" | bc)

    echo "[#${i}] Mempool Size: $SIZE_MB MB"

    if (( SIZE_BYTES >= LIMIT_BYTES )); then
      echo "Mempool reached ~2GB. Done."
      break
    fi
  fi
done



# some line from output 
# Starting mempool filler for bitcoind...
# [#50] Mempool Size: 0 MB
# [#100] Mempool Size: .01 MB
# [#150] Mempool Size: .02 MB
# [#200] Mempool Size: .02 MB
# [#250] Mempool Size: .03 MB
# [#300] Mempool Size: .04 MB
# [#350] Mempool Size: .04 MB
# [#400] Mempool Size: .05 MB
# [#450] Mempool Size: .06 MB
# [#500] Mempool Size: .06 MB
# ...................................


# bitcoin-cli --regtest getmempoolinfo
# {
#   "loaded": true,
#   "size": 401,
#   "bytes": 56534,
#   "usage": 469616,
#   "total_fee": 0.00056541,
#   "maxmempool": 300000000,
#   "mempoolminfee": 0.00001000,
#   "minrelaytxfee": 0.00001000,
#   "incrementalrelayfee": 0.00001000,
#   "unbroadcastcount": 401,
#   "fullrbf": false
# }