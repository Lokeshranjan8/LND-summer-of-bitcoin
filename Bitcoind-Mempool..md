Testing Bitcoin Daemon (bitcoind) with a loaded wallet (rbf-A):
 - Checking mempool status
 - Sending a transaction
 - Verifying transaction inclusion in the mempool
 - Verifying transaction confirmation on the blockchain


$ bitcoin-cli --regtest -rpcwallet=rbf-A getmempoolinfo
% {
%     "loaded": true,
%     "size": 0,
%     "bytes": 0,
%     "usage": 0,
%     "total_fee": 0.00000000,
%     "maxmempool": 300000000,
%     "mempoolminfee": 0.00001000,
%     "minrelaytxfee": 0.00001000,
%     "incrementalrelayfee": 0.00001000,
%     "unbroadcastcount": 0,
%     "fullrbf": false
% }
% //the mempool is currenlty empty with zero transactions 


reciever address= bcrt1qhhuykvfx5t3c8t7fy3cl326nnj3twlc2q5q37m
sender address= bcrt1qrwmjtpttpe9dee078ld9xsr2hv82j7kw6lzfhc


$ bitcoin-cli --regtest -rpcwallet=rbf-A sendtoaddress bcrt1qhhuykvfx5t3c8t7fy3cl326nnj3twlc2q5q37m 2 
<!-- output=ece7a7280379ee681f692fa5b2e4c496a0c964f39cd9ecf879d537bb59c7c05c
successfully sended 2 btc to given address  -->

$ bitcoin-cli --regtest -rpcwallet=rbf-A getrawmempool
% [
%   "ece7a7280379ee681f692fa5b2e4c496a0c964f39cd9ecf879d537bb59c7c05c"
% ]
% the mempool is not empty and the transaction is added to the mempool


$ bitcoin-cli --regtest -rpcwallet=rbf-A getrawmempool true
<!-- Detailed mempool entry: -->
<!-- {
    "ece7a7280379ee681f692fa5b2e4c496a0c964f39cd9ecf879d537bb59c7c05c": {
      "vsize": 141,
      "weight": 561,
      "time": 1745150923,
      "height": 594,
      "descendantcount": 1,
      "descendantsize": 141,
      "ancestorcount": 1,
      "ancestorsize": 141,
      "wtxid": "b5ad3eb3ec921aefd0d9d662a69fef17d735e2e0c434c60bb92470036a3be90e",
      "fees": {
        "base": 0.00000141,
        "modified": 0.00000141,
        "ancestor": 0.00000141,
        "descendant": 0.00000141
      },
      "depends": [
      ],
      "spentby": [
      ],
      "bip125-replaceable": true,
      "unbroadcast": true
    }
  } -->



$ bitcoin-cli -regtest getmempoolentry ece7a7280379ee681f692fa5b2e4c496a0c964f39cd9ecf879d537bb59c7c05c
% Verify whether the txid is exist or not .


bitcoin-cli --regtest -rpcwallet=rbf-A getrawmempool true
% The transaction is no longer in the mempool — it's now in the blockchain
% {

% }
