# Decentralized Crowdfunding Smart Contract 🌐

A Web3 alternative to traditional crowdfunding platforms (like Kickstarter or GoFundMe), built with Solidity. This smart contract acts as a trustless escrow, allowing a project creator to raise funds in Ethereum (ETH) while pegging the funding goal to a stable USD value using Chainlink Decentralized Oracles.

## 🚀 Overview

Traditional crowdfunding platforms take hefty percentage cuts and require users to trust a centralized middleman. This smart contract eliminates the middleman. 

**How it works:**
1. The contract is deployed with a strict **7-day deadline** and a predefined **USD funding goal**.
2. Backers fund the project using ETH. 
3. **If the goal is met:** The project creator can withdraw all accumulated funds. The contract allows for **overfunding** (exceeding the minimum goal) to maximize raised capital.
4. **If the goal fails:** The creator is locked out, and backers can autonomously withdraw their exact initial pledges.

## ✨ Key Features

* **Chainlink Price Feeds Integration:** Uses the `AggregatorV3Interface` to fetch real-time ETH/USD conversion rates. This ensures the campaign's funding goal remains mathematically accurate despite cryptocurrency market volatility.
* **Overfunding Enabled:** Designed to continue accepting funds even after the minimum target is reached, mimicking real-world campaign behavior.
* **Trustless Refunds:** Refund logic is built directly into the contract state. No admin intervention is required for backers to reclaim funds if the deadline passes without success.
* **Gas Optimized:** Prevents duplicate address entries in the funder array by checking mapping states prior to array pushes.
* **Secure Architecture:** Built utilizing the **Checks-Effects-Interactions (CEI)** pattern to completely neutralize Reentrancy vulnerabilities during fund withdrawals.

## 🛠️ Technical Stack

* **Language:** Solidity `^0.8.18`
* **Oracle:** Chainlink Data Feeds (ETH/USD)
* **Environment:** Ethereum Virtual Machine (EVM)

## 🏗️ Contract Architecture

### Core Functions
* `Fund()`: Allows users to send ETH to the contract. Tracks individual contributions in a mapping and adds first-time contributors to an array. Reverts if the 7-day deadline has passed.
* `WithdrawOwner()`: Can only be called by the contract deployer. Reverts if the USD funding goal has not been met. Transfers the entire contract balance to the creator.
* `Withdraw()`: Can be called by any backer to retrieve their funds. Reverts if the deadline has not passed OR if the funding goal was successfully met. 

### Modifiers
* `DeadlineNotReached` / `DeadlineReached`: Enforces temporal states using `block.timestamp`.
* `GoalCompleted` / `GoalNotCompleted`: Calculates the real-time USD value of the contract's ETH balance against the target goal.
* `OnlyOwner`: Restricts administrative execution to the deployer's address.

## 💻 Quick Start & Testing

1. Clone the repository and open the files in [Remix IDE](https://remix.ethereum.org/).
2. Ensure you are using a Solidity compiler version `0.8.18` or higher.
3. This contract uses the Chainlink **Sepolia Testnet** ETH/USD price feed address (`0x694AA1769357215DE4FAC081bf1f309aDC325306`).
4. To test, inject your Web3 provider (like MetaMask), switch to the Sepolia test network, and deploy the `CrowdFunding` contract.

---
*Developed by Kanak Agarwal*
