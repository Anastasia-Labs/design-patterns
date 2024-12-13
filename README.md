# design-patterns

This project is dedicated to simplifying complex Plutus smart contract design patterns on the Cardano blockchain through the creation of two distinct libraries: one for [Plutarch](https://github.com/Anastasia-Labs/plutarch-design-patterns) and another for [Aiken](https://github.com/Anastasia-Labs/aiken-design-patterns). These libraries are designed to abstract away some of the more unintuitive and lesser-known design patterns, making them more accessible to developers. Below is an overview of the key features and design patterns these libraries address:

## Key Features

- **Transaction Level Validation**: Abstracts the intricacies of spending validator validation through:
  - Stake Validators using the "withdraw zero" trick.
  - Minting Policies for enhanced control and security.

- **Input/Output Indexing with Redeemers**: Simplifies the management of input/output indexing, streamlining the process of associating redeemers with their respective inputs or outputs.

- **Strict Boolean Validation Checks**: Offers a robust framework for implementing boolean binary operators, ensuring strict validation checks across Plutus, Plutarch, and Aiken.

- **PlutusTypeEnum Redeemers**: Introduces an efficient data encoding method for simple redeemers, utilizing Enums to minimize complexity and optimize performance.

- **Normalization Techniques**: Enhances data integrity and contract reliability through:
  - **TxInfoMint Normalization**: Cleanses txInfoMint data to eliminate 0 lovelace value entries, ensuring cleaner and more accurate data representation.
  - **Validity Range Normalization**: Standardizes the treatment of validity ranges, ensuring consistent and predictable contract behavior.

## Documentation Overview

Each of the following documents provides a deep dive into the specific design patterns and features implemented in the libraries:

- [ENUM REDEEMERS](enum-redeemers/ENUM-REDEEMERS.md): Explores the implementation of PlutusTypeEnum Redeemers for efficient data encoding.
- [STAKE VALIDATOR](stake-validator/STAKE-VALIDATOR.md): Details the abstraction of transaction level validation through Stake Validators.
- [STRICT-AND-CHECKS](strict-and-checks/STRICT-AND-CHECKS.md): Discusses the framework for strict boolean validation checks.
- [TRANSACTION-LEVEL-VALIDATION-MINTING-POLICY](transaction-level-validator-minting-policy/TRANSACTION-LEVEL-VALIDATION-MINTING-POLICY.md): Explains the use of Minting Policies for transaction level validation.
- [TXINFOMINT-NORMALIZATION](txinfomint-normalization/TXINFOMINT-NORMALIZATION.md): Introduction to the normalization of txInfoMint data.
- [UTXO-INDEXERS](utxo-indexers/UTXO-INDEXERS.md): Covers the simplification of input/output indexing with redeemers.
- [VALIDITY-RANGE-NORMALIZATION](validity-range-normalization/VALIDITY-RANGE-NORMALIZATION.md): Discusses the standardization of validity range handling.

For more detailed information on each feature and design pattern, please refer to the individual documents.
