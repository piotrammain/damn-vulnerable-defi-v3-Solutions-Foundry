![](cover.png)
# Damn Vulnerable DeFi V3 - Solutions in Foundry

Implementations in Foundry addressing the challenges presented in the Damn Vulnerable DeFi V3 CTF [https://www.damnvulnerabledefi.xyz/](https://www.damnvulnerabledefi.xyz/) (created by 
[tinchoabbate](https://twitter.com/tinchoabbate)).

"Damn Vulnerable DeFi is the wargame to learn offensive security of DeFi smart contracts in Ethereum.
Featuring flash loans, price oracles, governance, NFTs, DEXs, lending pools, smart contract wallets, timelocks, and more!"

The original repository, without solutions, can be found on the [Damn Vulnerable DeFi V3 Github page](https://github.com/tinchoabbate/damn-vulnerable-defi/tree/v3.0.0).

## Disclaimer

All Solidity code, practices and patterns in this repository are DAMN VULNERABLE and for educational purposes only.

DO NOT USE IN PRODUCTION.

## Table of Contents

- [1. How to start?](#How_to_start?)
  - [1.1 Install Foundry](#Install_Foundry)
  - [1.2 Update Foundry](#Update_Foundry)
- [2. Instructions](#Instructions)
  - [2.1 Challenge #1 - Unstoppable](#Challenge#1Unstoppable)
  - [2.2 Challenge #2 - NaiveReceiver](#Challenge#2NaiveReceiver)
- [3. Solutions](#Solutions)
  - [3.1 Solution #1 - Unstoppable](#Solution#1Unstoppable)
  - [3.2 Solution #2 - NaiveReceiver](#Solution#2NaiveReceiver)

<a name="How_to_start?"></a>
## 1. How to start?

<a name="Install_Foundry"></a>
#### 1.1 Install Foundry
To set up Foundry, the Foundry toolchain installer, use the following command: 
```shell
curl -L https://foundry.paradigm.xyz | bash
```

<a name="Update_Foundry"></a>
#### 1.2 Update Foundry
In a fresh terminal session or subsequent to refreshing your PATH environment variable, execute the following command to acquire the most recent versions of the Forge and Cast binaries:
```shell
foundryup
```

<a name="Instructions"></a>
## 2. Instructions


<a name="Challenge#1Unstoppable"></a>
#### 2.1 Challenge #1 - Unstoppable
There’s a tokenized vault with a million DVT tokens deposited. It’s offering flash loans for free, until the grace period ends.

To pass the challenge, make the vault stop offering flash loans.

You start with 10 DVT tokens in balance.

[See the contracts](https://github.com/piotrammain/damn-vulnerable-defi-v3-Solutions-Foundry/tree/master/src/unstoppable)

[Complete the challenge](https://github.com/piotrammain/damn-vulnerable-defi-v3-Solutions-Foundry/tree/master/test/unstoppable/TestUnstoppable.t.sol)


<a name="Challenge#2NaiveReceiver"></a>
#### 2.2 Challenge #2 - Naive Receiver
There’s a pool with 1000 ETH in balance, offering flash loans. It has a fixed fee of 1 ETH.

A user has deployed a contract with 10 ETH in balance. It’s capable of interacting with the pool and receiving flash loans of ETH.

Take all ETH out of the user’s contract. If possible, in a single transaction.

[See the contracts](https://github.com/piotrammain/damn-vulnerable-defi-v3-Solutions-Foundry/tree/master/src/naive-receiver)

[Complete the challenge](https://github.com/piotrammain/damn-vulnerable-defi-v3-Solutions-Foundry/tree/master/test/naive-receiver/TestNaiveReceiver.t.sol)


<a name="Solutions"></a>
## 3. Solutions

<a name="Solution#1Unstoppable"></a>
#### 3.1 Solution #1 - Unstoppable

[Check the solution](https://github.com/piotrammain/damn-vulnerable-defi-v3-Solutions-Foundry/tree/master/test/unstoppable/SolutionUnstoppable.t.sol)

Challenge Objective: DOS Attack on Contract

The primary objective of the initial challenge is to execute a Denial of Service (DOS) attack on the contract.

Vulnerability in flashLoan Function:

The flashLoan function contains a vulnerability identified as follows:
```solidity
uint256 balanceBefore = totalAssets();
if (convertToShares(totalSupply) != balanceBefore) revert InvalidBalance();
```
Explanation:

ERC4626 introduces a standard for tokenized vaults that track user deposit shares to determine rewards for staked tokens. In this context, the asset represents the underlying token deposited/withdrawn into the vault, while the share signifies the vault tokens minted/burned to represent user deposits.

For this challenge, 'DVT' is the underlying token, and the vault token is deployed as 'oDVT'.

Issues Identified:

The condition: 
```solidity
(convertToShares(totalSupply) != balanceBefore)
```
enforces that the totalSupply of vault tokens must always equal the totalAsset of underlying tokens before any flash loan execution. This condition becomes problematic if there are alternative vault implementations diverting asset tokens to other contracts, rendering the flashLoan function inactive.

The totalAssets function is overridden to always return the balance of the vault contract: 
```solidity 
(asset.balanceOf(address(this)))
```
This introduces a separate accounting system based on tracking the supply of vault tokens.

Attack Strategy:

The attack involves creating a conflict between the two accounting systems by manually transferring 'DVT' to the vault.
```solidity
// Sending 2 Wei to the Vault, although even 1 Wei is enough
vm.prank(player);
token.transfer(address(vault), 2);
```
<a name="Solution#2NaiveReceiver"></a>
#### 3.2 Solution #2 - Naive Receiver


