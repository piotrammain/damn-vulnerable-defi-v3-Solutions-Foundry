# Damn Vulnerable DeFi V3 - Solutions in Foundry

Implementations in Foundry addressing the challenges presented in the Damn Vulnerable DeFi V3 CTF [https://www.damnvulnerabledefi.xyz/](https://www.damnvulnerabledefi.xyz/) (created by 
[tinchoabbate](https://twitter.com/tinchoabbate)).

"Damn Vulnerable DeFi is the wargame to learn offensive security of DeFi smart contracts in Ethereum.
Featuring flash loans, price oracles, governance, NFTs, DEXs, lending pools, smart contract wallets, timelocks, and more!"

The original repository, without solutions, can be found on the [Damn Vulnerable DeFi V3 Github page](https://github.com/tinchoabbate/damn-vulnerable-defi/tree/v3.0.0).

## How to start?

#### 1. Install Foundry
To set up Foundry, the Foundry toolchain installer, use the following command: 
```shell
curl -L https://foundry.paradigm.xyz | bash
```

#### 2. Update Foundry
In a fresh terminal session or subsequent to refreshing your PATH environment variable, execute the following command to acquire the most recent versions of the Forge and Cast binaries:
```shell
foundryup
```

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```