Often in a plutus validator you want to check "a particular Plutus script checked this transaction", but it's annoying (and wasteful) to have to
lock an output in a script and then check if that output is consumed, or mint a token, to trigger script validation. 

Perhaps the most pervasive use-case of this is to allow logic that is shared across multiple validators which otherwise would be redundently executed many times to be executed only once. 

This is commonly referred to as the forwarding validator design pattern. In this design pattern, the validator (typically a spending validator) defers its logic to another validator by checking that a state token is present in one of the transaction inputs:
```haskell
forwardNFTValidator :: AssetClass -> BuiltinData -> BuiltinData -> ScriptContext -> () 
forwardNFTValidator stateToken _ _ ctx = assetClassValueOf stateToken (valueSpent (txInfo ctx)) == 1
```
The above validator is *forwarding* its validation logic to the spending validator where the state token is locked that would the shared / global validation logic. By enforcing that one of the transaction inputs contains the state token, 
we guarantee that the spending validator with the state token successfully executes in the transaction.  

This pattern is a core component of the batcher architecture. Some protocols improve on this pattern by including the index of the input with the state token in the redeemer:

```haskell
forwardNFTValidator :: AssetClass -> BuiltinData -> Integer -> ScriptContext -> () 
forwardNFTValidator stateToken _ tkIdx ctx =  assetClassValueOf stateToken (txInInfoResolved (elemAt tkIdx (txInfoInputs (txInfo ctx)))) == 1 
```

With this pattern DApps are able to process roughly 8-15 forwardNFTValidator UTxO's  per transaction without exceeding script budget limitations.
The time complexity of unlocking a UTxO from the **O(n)** per UTxO being spent from the forwardNFTValidator where n is the number of tx inputs. This logic is executed once per input that is spent from the forwardNFTValidator in the transaction. 

The redundant execution of searching the inputs for a token a huge throughput bottleneck for these DApps; the total complexity is **O(n*m)** where n is the number of inputs and m is the number of `forwardValidator` inputs + `forwardValidator` minting policies.
Using the stake validator trick, the time complexity of the forwarding logic is improved to **O(1)**. The forwardValidator logic becomes:
```haskell
forwardWithStakeTrick:: StakingCredential -> BuiltinData -> BuiltinData -> ScriptContext -> ()
forwardWithStakeTrick obsScriptCred tkIdx ctx = fst (head stakeCertPairs) == obsScriptCred 
  where 
    info = txInfo ctx 
    stakeCertPairs = AssocMap.toList (txInfoWdrl info)
```
IE check that the StakingCredential is in the first pair in the `txInfoWdrl`.  This script is **O(1)** in the case where you limit it to one shared logic validator (staking validator), or if you don't want to break composability with other staking validator, 
then it becomes** O(obs_N)** where `obs_N` is the number of Observe validators that are executed in the transaction as you have to verify that the StakingCredential is present in `txInfoWdrl`.

