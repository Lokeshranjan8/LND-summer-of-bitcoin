This script demonstrates how to perform an RBF (Replace-By-Fee) transaction
- on Bitcoin Regtest using bitcoin-cli. We'll:
- Create a wallet and mine some BTC
- Send a transaction with RBF enabled
-  View the mempool to check transaction status
- Bump the transaction fee using `bumpfee`
- Confirm the bumped transaction by mining more blocks



$ bitcoin-cli --regtest -rpcwallet=rbf-A getnewaddress
% bcrt1q5xctzdw2l730w4arnqfsjdtk76fsy7z9ym6u3q


$ bitcoin-cli --regtest -rpcwallet=rbf-A generatetoaddress 101 bcrt1q5xctzdw2l730w4arnqfsjdtk76fsy7z9ym6u3q
<!-- successfully genrated 101 blocks -->



$ bitcoin-cli -regtest -rpcwallet=rbf-A sendtoaddress bcrt1qkaea9m988vyr3nj4am0y8jnhecdg8c469ygf3c 0.01 "" "" true
% output=e6c3ec795690526f6c309e27c6541cefb4eed99afde3d76cbb5e6e44eec1cfdc
% enabled rbf and sending 0.01 btc to bcrt1qkaea9m988vyr3nj4am0y8jnhecdg8c469ygf3c


$ bitcoin-cli -regtest -rpcwallet=rbf-A listtransactions
<!-- "address": "bcrt1qkaea9m988vyr3nj4am0y8jnhecdg8c469ygf3c",
 "category": "send",
 "amount": -0.00999859,
 "vout": 0,
 "fee": -0.00000141,
 "confirmations": 0,
 "trusted": true,
 "txid": "e6c3ec795690526f6c309e27c6541cefb4eed99afde3d76cbb5e6e44eec1cfdc",
 "wtxid": "eb8e96d78d4ca310c0d2a9d9aa14a4f9b729eb66f64c9a07b02b66a599ba5ef5",
 "walletconflicts": [
 ],
 "time": 1745011011,
 "timereceived": 1745011011,
 "bip125-replaceable": "yes",
 "abandoned": false -->


$ bitcoin-cli -regtest getmempoolentry e6c3ec795690526f6c309e27c6541cefb4eed99afde3d76cbb5e6e44eec1cfdc
% viewing our memppol entry here 
%  {
%    "vsize": 141,
%    "weight": 561,
%    "time": 1745011011,
%    "height": 593,
%    "descendantcount": 1,
%    "descendantsize": 141,
%    "ancestorcount": 1,
%    "ancestorsize": 141,
%    "wtxid": "eb8e96d78d4ca310c0d2a9d9aa14a4f9b729eb66f64c9a07b02b66a599ba5ef5",
%    "fees": {
%      "base": 0.00000141,
%      "modified": 0.00000141,
%      "ancestor": 0.00000141,
%      "descendant": 0.00000141
%    },
%    "depends": [
%    ],
%    "spentby": [
%    ],
%    "bip125-replaceable": true,
%    "unbroadcast": true
%  }

$ bitcoin-cli -regtest -rpcwallet=rbf-A bumpfee e6c3ec795690526f6c309e27c6541cefb4eed99afde3d76cbb5e6e44eec1cfdc
 <!-- Fee increased from 0.00000141 to 0.00000847
 New txid = 0c085b791f66c8fe10585127074bc2f0ac2e489477ddf04d7ca831a89b8853e3
using bumpfee to increase the fee to process the transaction faster
 {
   "txid": "0c085b791f66c8fe10585127074bc2f0ac2e489477ddf04d7ca831a89b8853e3",
   "origfee": 0.00000141,
   "fee": 0.00000847,
   "errors": [
   ]
 } -->


$ bitcoin-cli -regtest getmempoolentry e6c3ec795690526f6c309e27c6541cefb4eed99afde3d76cbb5e6e44eec1cfdc
% not in mempool as new txid is replace this with higher fee rate 



$ bitcoin-cli -regtest getmempoolentry 0c085b791f66c8fe10585127074bc2f0ac2e489477ddf04d7ca831a89b8853e3
<!-- here the fee get updated to 0.00000847 as intiia it was 0.00000141
this indicate the transaction is in mempool with hgiher fee rate 
 {
     "vsize": 141,
     "weight": 561,
     "time": 1745014240,
     "height": 593,
     "descendantcount": 1,
     "descendantsize": 141,
     "ancestorcount": 1,
     "ancestorsize": 141,
     "wtxid": "b2a624fb449586cb6be8b05c75f43140d398ba4241b84b20929cf76d90e97865",
     "fees": {
       "base": 0.00000847,
       "modified": 0.00000847,  
       "ancestor": 0.00000847,
       "descendant": 0.00000847
     },
     "depends": [
     ],
     "spentby": [
     ],
     "bip125-replaceable": true,
     "unbroadcast": true
   } -->


$ bitcoin-cli -regtest generatetoaddress 5 bcrt1qkaea9m988vyr3nj4am0y8jnhecdg8c469ygf3c to confirmed the transaction
% uccessfully transaction got confirmed 