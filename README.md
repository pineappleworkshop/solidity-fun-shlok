# Overview

This minting solution is designed for an abstracted and upgradeable contract mechanism
This system uses the ERC721 Upgradeable standard by OpenZeppelin along with a seperate Minting contract to abstract away ownership management, also removing away ERC20 ownership away from the Token contract.
There are 2 main contracts in theis set:
1. Minter.sol: This is the token minter and also is supposed to be set as the owner of the token contract, allowing for this ownership contract to be upgradeable by replacement, this contract can also transfer ownership to a new implementation.
2. TokenGen.sol: This is the NFT Token contract that generates the Non-Fungible Tokens, this contract follows the ERC 721 Upgradeable standard and is upgrableable as per the standard.
---
# Deployment:
1. Minter: 
  1. Input wallet #1 & #2 to be used as owners and withdrawal wallets
  2. The mint price in erc20
  3. The mint price in eth, (3 & 4 leave one to 0 when picking the other)
  4. Select if using erc20 as payment for mint (true for erc20)

2. TokenGen: (Token Contract)
  1. Deploy
  2. TransferOwnership to Minter contract
---
# Endpoints:
1. Minter:  
  1. Mint: Input number of tokens to mint
  2. Mint Prices, wallet and contract addresses are public
  3. setmintprice & setmintpriceerc20 : Input new prices
  4. setwallets: Input wallet 1 and wallet 2

2. TokenGen: (Token Contract)
  1. safeMint: This is the function to mint, it is an onlyOwner function, has to be accessed through the Minter
  2. numminted: returns the number of tokens minted
  3. Standardized ERC721 functions 
---
# Setup the project

1. Clone Repo
2. Npm i
3. Create a solidity development environment
4. Deploy the Minter
5. Deploy Token Contract
6. Transfer Ownership of token contract to Minter
---
# Explanation of Approach

I have chosen to abstract the minting contract away from the Token contract to provide a higher level of security, and maintaining a seperate contract to collect the erc20 tokens and to maintain on-chain ownership of the Token contract.
This approach was also taken to maintain upgradeability, the Token contract is fully ERC721 Upgradeable compliant, and the minting contract can be replaced by transferring ownership of the token contract to a new Minting/Ownership contract, this leaves room for a DAO or future utility.


