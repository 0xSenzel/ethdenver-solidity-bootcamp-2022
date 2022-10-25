# Solution
## Homework 1
Solution: [Thinking Map](./answers/Ans-Homework_1-Q1.PNG) <br/>

## Homework 2
### 1.1 <br/>
Transaction Hash: <br/>
[0x0ec3f2488a93839524add10ea229e773f6bc891b4eb4794c3337d4495263790b](https://etherscan.io/tx/0x0ec3f2488a93839524add10ea229e773f6bc891b4eb4794c3337d4495263790b)

Comment: <br/>
This transaction hash at block [1718497](https://etherscan.io/block/1718497) shows an [address](https://etherscan.io/address/0x969837498944ae1dc0dcac2d0c65634c88729b2d) to a [contract](https://etherscan.io/address/0xc0ee9db1a9e07ca63e4ff0d5fb6f86bf68d47b89) which initiated a series of transfer from [TheDAO Token](https://etherscan.io/address/0xbb9bc244d798123fde783fcc1c72d3bb8c189413) to [attacker's contract](https://etherscan.io/address/0x304a554a310c7e546dfe434669c62820b7d83490#comments) which moved over 2000 ETH.

**Remark:** <br/>
This is the famous DAO hack which splits Ethereum into Ethereum Class (ETC) and Ethereum (the one we know today). Openzeppelin shared a post mortem on this issue which tells us how to [prevent the hack using 15 line of code](https://blog.openzeppelin.com/15-lines-of-code-that-could-have-prevented-thedao-hack-782499e00942/).

### 1.2 <br/>
0x4fc1580e7f66c58b7c26881cce0aab9c3509afe6e507527f30566fbf8039bcd0

### 1.3 <br>
Transaction Hash: <br/>
[0x552bc0322d78c5648c5efa21d2daa2d0f14901ad4b15531f1ab5bbe5674de34f](https://etherscan.io/tx/0x4fc1580e7f66c58b7c26881cce0aab9c3509afe6e507527f30566fbf8039bcd0)

Comment: <br/>
This transaction hash shows the deployment of [Uniswap V2: Router 2](https://etherscan.io/address/0x7a250d5630b4cf539739df2c5dacb4c659f2488d) 

**Remark:** <br/>
Documentation of [Router02](https://docs.uniswap.org/protocol/V2/reference/smart-contracts/router-02). One of the pioneers in Defi space, instructor mentioned this version of Uniswap marks the real took off of Defi. 

### 1.4 <br/>
Transaction Hash:<br/> [0x7a026bf79b36580bf7ef174711a3de823ff3c93c65304c3acc0323c77d62d0ed](https://etherscan.io/tx/0x7a026bf79b36580bf7ef174711a3de823ff3c93c65304c3acc0323c77d62d0ed)

Comment: <br/>
This transaction hash at block [13011008](https://etherscan.io/block/13011008) shows an [address](https://etherscan.io/address/0xc8a65fadf0e0ddaf421f28feab69bf6e2e589963) initiated a transfer from [Maker: Dai Stablecoin](https://etherscan.io/address/0x6b175474e89094c44da98b954eedeac495271d0f) which is attacker returning 96 million Dai to Maker Dai.

### 1.5 <br/>
Transaction Hash: <br/>
[0x814e6a21c8eb34b62a05c1d0b14ee932873c62ef3c8575dc49bcf12004714eda](https://etherscan.io/tx/0x814e6a21c8eb34b62a05c1d0b14ee932873c62ef3c8575dc49bcf12004714eda)

Comment: <br/>
This transaction hash shows an [address](https://etherscan.io/address/0x583e25de879e90cf5fc637f8dc16db8f10d91c17) transferring 160 ETH to [PolyNetwork Exploiter](https://etherscan.io/address/0xa87fb85a93ca072cd4e5f0d4f178bc831df8a00b)

**Remark:** <br/>
This is a among the series of transaction for [Polynetwork hack](https://coinmarketcap.com/alexandria/article/poly-network-hack-the-largest-confirmed-crypto-hack-in-history) which resulted in over 600 million loss. After communicating to hackers, both party came to a [settlement](https://coinyuppie.com/honor-exploitation-and-code-how-we-lost-610-million-and-got-it-back/).

2.0 
Largest account with ETH balance is [Beacon Deposit Contract](https://etherscan.io/address/0x00000000219ab540356cbb839cbe05303d7705fa) which is a staking contract. [Details](https://ethereum.org/en/upgrades/beacon-chain/).

### 3.1 <br/> 
Account: <br/>
[0x1db3439a222c519ab44bb1144fc28167b4fa6ee6](https://etherscan.io/address/0x1db3439a222c519ab44bb1144fc28167b4fa6ee6)

This account belongs to [Vitalik Buterin](https://vitalik.ca/) founder of Ethereum.

### 3.2 <br/>
Account: <br/>
[0x000000000000000000000000000000000000dEaD](https://etherscan.io/address/0x000000000000000000000000000000000000dead)

This account is a blackhole which means token that is sent to this address will never able to be retrieved by anyone. One of the use case is inflationary control such as in [EIP-1559](https://www.immunebytes.com/blog/eip-1559/).

### 4.1 & 4.2 <br/>
Solution: [Deployment of Contract @ Remix IDE](./answers/Ans-Homework_2-Q4.PNG)

## Homework 3
Solution: [Bootcamp.sol](./answers/Bootcamp.sol)

## Homework 4
Solution: [VolcanoCoin.sol](./answers/VolcanoCoin.sol)