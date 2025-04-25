I successfully started the btcd server and created a wallet using btcwallet
My command-line interface via btcctl is working fine
Mempool-related functionality is partially working:
- `getrawmempool` works correctly and returns transaction IDs when mempool is non-empty
- `getrawmempool true` also works, returning detailed mempool entry info
- `getmempoolinfo` works and shows the current size and bytes of the mempool
- `getmempoolentry` is not yet implemented in btcd and returns an error



$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --notls getinfo
% {
%   "version": 240200,
%   "protocolversion": 70002,
%   "walletversion": 8,
%   "balance": 0,
%   "blocks": 0,
%   "timeoffset": 0,
%   "connections": 0,
%   "proxy": "",
%   "difficulty": 1,
%   "testnet": false,
%   "keypoololdest": 0,
%   "keypoolsize": 0,
%   "unlocked_until": 0,
%   "paytxfee": 1000,
%   "relayfee": 0.00001,
%   "errors": ""
% }
 

$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --wallet --notls generate 101
<!-- // Successfully generated 101 blocks to mature coinbase transactions -->

$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --wallet --notls getbalance
%  Check wallet balance after mining
%  100

$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --wallet --notls listunspent
<!--List available UTXOs (unspent outputs)
[
  {
    "txid": "2406b21d79f33cc5f3c82d140d3f2d2554e3b95d09d6c8551fccf90f3c0d2b72",
    "vout": 0,
    "address": "n1t9PH8NpYFXhi68S96Nf7VCgJMUAj1Dfz",
    "account": "default",
    "scriptPubKey": "76a914df6482271320ff857593e566f3d42b4737dd71be88ac",
    "amount": 50,
    "confirmations": 100,
    "spendable": true
  },
  {
    "txid": "f44cf3874b7d7cd801e5cb0ca3b4bca546cdae046e5bc1794d6b280f85c5ee7c",
    "vout": 0,
    "address": "n1t9PH8NpYFXhi68S96Nf7VCgJMUAj1Dfz",
    "account": "default",
    "scriptPubKey": "76a914df6482271320ff857593e566f3d42b4737dd71be88ac",
    "amount": 50,
    "confirmations": 101,
    "spendable": true
  }
] -->

<!-- f4743b6f5bf6c6822101c85c82eae1a8d4f80ccd51dc5d5c0c3168a70d16cb17 -->
<!-- Then I unlock my wallet using passphse  -->


$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --wallet --notls sendtoaddress mjWLDv7oDTfKsjQPpK3MS9uG4KX6k85V8d 1.0
% Send 1 BTC to mjWLDv7oDTfKsjQPpK3MS9uG4KX6k85V8d
% TXID: ac23ccd43fa31a0bef5a63ca582545d554769649e21e260319781e31730228df


$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --notls getrawmempool
 <!-- Check that transaction is now in the mempool
 [
   "ac23ccd43fa31a0bef5a63ca582545d554769649e21e260319781e31730228df"
 ] -->

$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --notls getmempoolentry   ac23ccd43fa31a0bef5a63ca582545d554769649e21e260319781e31730228df

%  Try to inspect mempool entry - currently not implemented in btcd
%  -1: Command unimplemented


$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --wallet --notls generate 1
 <!-- Mine 1 block to confirm the pending transaction
[
   "4a9e66dd43f15a8d1c4d732b5ef70e1d05bf4061f9a464f10ebaeaccd2e2b51a"
] -->




$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --notls getrawmempool true
% {
%   "4a9e66dd43f15a8d1c4d732b5ef70e1d05bf4061f9a464f10ebaeaccd2e2b51a": {
%     "size": 225,
%     "vsize": 225,
%     "weight": 900,
%     "fee": 0.00000227,
%     "time": 1745447031,
%     "height": 203,
%     "startingpriority": 8012820512.820513,
%     "currentpriority": 8076923076.923077,
%     "depends": []
%   }
% }

$ btcctl --regtest --rpcserver=127.0.0.1:18332 -u rpcuser -P rpcpass --notls getmempoolinfo
 <!--{
     <!-- "size": 1,
     "bytes": 225
} -->
