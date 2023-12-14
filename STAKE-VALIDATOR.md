# Stake Validator Design pattern

## Table of Contents

- [Stake Validator Design pattern](#stake-validator-design-pattern)
  - [Table of Contents](#table-of-contents)
  - [How to use this document](#how-to-use-this-document)
  - [Introduction](#introduction)
  - [Main Features](#main-features)
  - [Why Staking Validators?](#why-staking-validators)
  - [Cardano model](#cardano-model)
  - [Address type](#address-type)
  - [Script Address](#script-address)
  - [Implementation](#implementation)

## How to use this document
The documentation is organized sequentially, starting with basics and progressing to advanced topics for
building your smart contract application.
You can read it in any order or directly access pages relevant to your use case. 
A table of contents on the top facilitates easy navigation between sections.

## Introduction
In this comprehensive guide, you will discover how to strategically implement the Staking Validator design pattern to enhance your protocol's performance and introduce composability by employing the innovative "withdraw zero trick." 



## Main Features
- receive staking rewards
- withdraw staking rewards


##  Why Staking Validators?

Consider a scenario with multiple UTXOs at a `Spending Validator`; if your entire protocol logic resides within it, the logic has to run for each UTXO, quickly reaching transaction limits and increasing CPU and memory usage.

The solution involves the `Spending Validator` checking that the `Staking validator` is called in the same transaction, consolidating the logic to run once at the `Staking Validator`. This significantly reduces script size and simplifies business logic.

`Staking Validators` play a crucial role, not only in adding logic to stake control but also in minimizing script size and optimizing CPU and memory usage. 
It's essential to note that staking validators aren't a one-size-fits-all solution; careful evaluation is needed to determine if this design pattern aligns with your specific purpose.

## Cardano model
Cardano is composed of two model
- The Extended Unspent Transaction Output (EUTXO) model:
    - each unspent output is linked to a specific address. 
    - the spending of this input is controlled by the payment credential
- The Accounting model (Staking):
    - Each utxo can be associated with an address containing a staking credential
    - Staking credential owners have control over delegation and possess the capability to withdraw rewards.

## Address type
Cardano address consists of two crucial components.
 - Payment Credential
    - Controls the spending of the UTXO associated with the payment credential address.
 - Staking Credential
    - Controls the registration, de-registration, delegation, and withdrawal of rewards 
> Note: While it is possible to construct addresses without a staking credential, this document will not delve into that aspect.

## Script Address
Addresses are not only used in wallet, but also in smart contracts, often referred to as scripts.

One can created a script address by hashing the Spending Validator and the Staking Validator. 

```mermaid
graph TD
  SA(Script Address)
  SA -->|Payment Credential| ScriptCredentialSA
  subgraph ScriptCredentialSA[ScriptCredential]
  subgraph ScriptHashSA[ScriptHash]
  end
  end
  SA -->|Staking Credential| StakingHash
  subgraph StakingHash
  subgraph ScriptCredential
  subgraph ScriptHash
  end
  end
  end
```

UTXO are associated with an Address with both components `Payment Credential` and `Staking Credential`

```mermaid
graph TD
  subgraph UTXO
  SA(Script Address)
  SA -->|Payment Credential| ScriptCredentialSA
  subgraph ScriptCredentialSA[ScriptCredential]
  subgraph ScriptHashSA[ScriptHash]
  end
  end
  SA -->|Staking Credential| StakingHash
  subgraph StakingHash
  subgraph ScriptCredential
  subgraph ScriptHash
  end
  end
  end
  end
```
## Implementation

The strategy involves enforcing the spending validator to invoke the staking validator upon each attempted expenditure of the script input.
Following this, the staking validator assumes the responsibility of validating each spending script input to ensure strict adherence to the protocol specifications.

```mermaid
graph LR
    TX[ Transaction ]
    subgraph Spending Scripts
    S1((UTxO 1))
    S2((UTxO 2))
    S3((UTxO 3))
    end
    S1 --> TX
    S2 --> TX
    S3 --> TX
    ST{{Staking Script}} -.-o TX
    TX --> A1[Address]
    TX --> A2[Address]
    TX --> A3[Address]
```


WIP ...