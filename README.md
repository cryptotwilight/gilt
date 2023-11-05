# Gilt Protocol 
** Autonomous Decentralized Cross Chain Bonds **
The Gilt Protocol is has been built to enable the creation and transfer of Gilts.

Gilts are bonds are a type of bond that separate promissory note and collateral functions of cryptocurrency. Fundamentally the holder / bearer of the gilt is entitled to the settlement funds associated with the Gilt on liquidation.

The Gilt protocol uses the ERC721 mechanism to manage ownership of the asset. The Gilt protocol is Cross Chain enabled hence users can transfer their Gilts to other chains to work with remote DeFi protocols.

The Gilt protocol homed on Arbitrum (Goerli), and leverages Chainlink CCIP for cross chain transfers.

**Why Gilt Protocol**

Today cross chain DeFi is extremely risky particularly with respect to security exemplified by Multichain hack (July 2023). For small holders and more compensation in such an event is a dream. Added to that post hack actions like carpet black listing addresses that have touched stolen funds has unintended community consequences.

Further more cross chain liquidity is an issue because not all tokens/protocols are supported/implemented on all chains. Hence whilst you maybe able to bridge your token there is no guarantee that the remote chain's protocols will widely accept your bridged asset. The above issues greatly limit the profit opportunities for DeFi participants.

**The Gilt Protocol Solution**

The Gilt Protocol provides a way of minimising the risks of Cross Chain DeFi. Users are able to interact with DeFi protocols through the use of Gilts. As a promissory note there is no raw token capital exposed to a DeFi protocol. Thus in the event of an exploit new security mechanisms targeting the affected gilt such community sanctioned transfer blocks can be deployed.

From a profit perspective Gilts enable the user to create autonomous treasury vehicles e.g. by leveraging Aave interest yielding aTokens. With a gilt the user can minimise their transfer and exchange costs as they can liquidate their Aave holding without cashing out of the Aave protocol as would be the required today.

Further when engaging in cross chain DeFi, the Gilt holder does not have to worry about liquidity of their home chain holdings as their Gilt can be collateralised directly for highly liquid local chain tokens

How to Use

To use the protocol follow the steps below:

**Mint your Gilt**

1 - Mint some test Aave / or other ERC20 tokens to your wallet

➡️ Go to (Aave Faucet) [https://goerli.arbiscan.io/address/0xc1b3cc37cf2f922abDFE7F01A17bc932F4078665#writeContract#F1](https://goerli.arbiscan.io/address/0xc1b3cc37cf2f922abDFE7F01A17bc932F4078665#writeContract#F1)  
➡️Connect your wallet  
➡️Set the following properties:

👨‍💻token: 0xD8A70FC58BC069CFE6529EBF0c1Db067f2b5347E  
👨‍💻to: <your wallet address>  
👨‍💻amount: 1000000000000000000000

➡️click write - this will complete the minting of some test net Aave, for other mintable tokens see here: [https://docs.aave.com/developers/deployed-contracts/v3-testnet-addresses](https://docs.aave.com/developers/deployed-contracts/v3-testnet-addresses)

NOTE: Be sure to add the above token to your wallet

3 - Mint your Gilt (this will be deposited into your wallet)

➡️Go to (Backing Token(AAVE)):  
[https://goerli.arbiscan.io/address/0xD8A70FC58BC069CFE6529EBF0c1Db067f2b5347E#writeContract#F1](https://goerli.arbiscan.io/address/0xD8A70FC58BC069CFE6529EBF0c1Db067f2b5347E#writeContract#F1)  
➡️Connect your wallet  
➡️Set the following properties:

👨‍💻spender: 0xA1b58EfF89248D0371F4d820145e2a9836DB5B2d  
👨‍💻amount: 50000000000000000000

➡️click write - this will approve the Gilt contract to spend 50 AAVE from your wallet

➡️Go to (Gilt Contract):  
[https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#writeContract#F3](https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#writeContract#F3)  
➡️Connect your wallet  
➡️Set the following properties:

👨‍💻payableAmount: 0  
👨‍💻to:<your wallet address>  
👨‍💻amount: 50000000000000000000  
👨‍💻token: 0xD8A70FC58BC069CFE6529EBF0c1Db067f2b5347E

➡️click write - this will mint your Gilt to your wallet

To find your Gilt Id go to:  
[https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#readContract#F4](https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#readContract#F4)  
Iterate through the ids presented using:  
[https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#readContract#F11](https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#readContract#F11)  
➡️Set token Id using the list of ids above - the Gilts owned by you will have your Wallet Address

**Teleport your Gilt**

4 - Approve the Teleporter for your Gilt

➡️Go to (Gilt Contract)  
[https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#writeContract#F1](https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#writeContract#F1)  
➡️Set the following properties:

👨‍💻to: 0xd2365C8E4C3548ddd02184bac8b236408b47391a  
👨‍💻tokenId: <Gilt id you wish to send>

➡️click write - this will approve the Teleporter for you cross chain transfer  
(you can check the approvals here by entering your Gilt id:  
[https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#readContract#F2](https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4#readContract#F2)

5 - Get a gas estimate for your Gilt

➡️Go to (Teleport Contract)  
[https://goerli.arbiscan.io/address/0x472A07a47eFCE51898203C07730d92b73c49350a#readContract#F2](https://goerli.arbiscan.io/address/0x472A07a47eFCE51898203C07730d92b73c49350a#readContract#F2)

➡️Set the following properties:

👨‍💻 __destination: ETHEREUM_SEPOLIA_  
👨‍💻 _giltWid: <your gilt id>  
👨‍💻 _giltWContract: 0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4  
👨‍💻 _holder: < your wallet >  
👨‍💻 _autonomous: true:

➡️click query - this will present you with an estimate of the cross chain transfer fee  
  

6 - Teleport your Gilt

To teleport your gilt go to: [https://goerli.arbiscan.io/address/0x472A07a47eFCE51898203C07730d92b73c49350a#writeContract#F3](https://goerli.arbiscan.io/address/0x472A07a47eFCE51898203C07730d92b73c49350a#writeContract#F3)

➡️Set the following properties:

teleport

👨‍💻_payableAmount: <the amount indicated in the estimate>  
👨‍💻_location: ETHEREUM_SEPOLIA  
👨‍💻_giltWid: <your Gilt Id>  
👨‍💻_giltWContract: 0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4  
👨‍💻_holder: < your wallet>  
👨‍💻 _autonomous: true

➡️click write - this will teleport your Gilt to the Sepolia blockchain

For manual claim on the receiving chain set autonomous to false. Your gilt will be reminted to the holder specified in the Gilt Description

7 - Check your Gilt In flight

➡️Go to:  
[https://ccip.chain.link](https://ccip.chain.link)

➡️ Set your wallet address in the "search" field, monitor you transaction

8 - On success check your wallet on Sepolia Etherscan here:  
[https://sepolia.etherscan.io](https://sepolia.etherscan.io)

➡️ Set your wallet address in the "search" field

How it's Built

The Gilt protocol utilises ERC721 as a contract base on top of which the Gilt standard is implemented. The cross chain transfer mechanism utilises Chainlink's CCIP to transfer the Gilt from Arbitrum to the destination chain e.g. Ethereum Sepolia

Gilt Contract Addresses
| Blockchain | Contract | Address |Description |
|--------------|------------|-------| --------|
|Arbitrum Goerli | GILT_OPS_REGISTER |[0x27424bcec476f045c8a720db00832048d572a5ed](https://goerli.arbiscan.io/address/0x27424bcec476f045c8a720db00832048d572a5ed)|Arbitrum Goerli dApp Register|
|Arbitrum Goerli | GILT_LOCATION_REGISTER |[0xDb861BFC01bDBe1C7E57f78af8987a58475cb853](https://goerli.arbiscan.io/address/0xDb861BFC01bDBe1C7E57f78af8987a58475cb853)|Used for registering Cross Chain locations on Arbitrum Goerli|
|Arbitrum Goerli | GILT_CONTRACT |[0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4](https://goerli.arbiscan.io/address/0x26e57Db8EbEc157817Dacc051B7749050B3D2bb4)|Used for Minting transacting and settling Gilts on Arbitrum Goerli|
|Arbitrum Goerli | GILT_VAULT|[0x58CffF5FC7Ec84aDAa91753516A71E997df616Ed](https://goerli.arbiscan.io/address/0x58CffF5FC7Ec84aDAa91753516A71E997df616Ed)|** Back Office ** Used for protecting in-flight Gilts on Arbitrum Goerli|
|Arbitrum Goerli | GILT_RECIEVER|[0x5c895D381a18F4Dd8ea01069b139c14b85EB9bd0](https://goerli.arbiscan.io/address/0x5c895D381a18F4Dd8ea01069b139c14b85EB9bd0)|Used for receiving teleported Gilts via Chainlink CCIP on Arbitrum Goerli|
|Arbitrum Goerli | GILT_TELEPORTER|[0x472A07a47eFCE51898203C07730d92b73c49350a](https://goerli.arbiscan.io/address/0x472A07a47eFCE51898203C07730d92b73c49350a)|Used for teleporting Gilts via Chainlink CCIP on Arbitrum Goerli|
|Arbitrum Goerli | CCIP_ROUTER|[0x88E492127709447A5ABEFdaB8788a15B4567589E](https://goerli.arbiscan.io/address/0x88E492127709447A5ABEFdaB8788a15B4567589E)|Chainlink CCIP Router for cross chain messaging on Arbitrum Goerli|
|Arbitrum Goeli |GILT_ADMIN|0x159CEB2e053B2eDf911Af42D94Cf92bCC47DA6cC|** Back Office **|
|Ethereum Sepolia | GILT_LOCATION_REGISTER |0x95ae3bC6240A7511eD939D268fc76a007cB8574d |Used for registering Cross Chain locations on Ethereum Sepolia| 
|Ethereum Sepolia | GILT_CONTRACT | 0x27dC75A0A6f6c59C472c4b81996a7043D2d4BF43|Used for Minting transacting and settling Gilts on Ethereum Sepolia| 
|Ethereum Sepolia | GILT_VAULT| 0x02148902F7aA219d0684B88564daF78f8aD0cB94|** Back Office ** Used for protecting in-flight Gilts on Ethereum Sepolia| 
|Ethereum Sepolia | GILT_RECIEVER|[0x7Aa27b1c6fbCa237160bfCfE9545838B933385e6]|Used for receiving teleported Gilts via Chainlink CCIP on Ethereum Sepolia| 
|Ethereum Sepolia | GILT_TELEPORTER|[0x77705ad684960d37C430F60B733B59BBe13EB458]|Used for teleporting Gilts via Chainlink CCIP on  Ethereum Sepolia| 
|Ethereum Sepolia | CCIP_ROUTER|0xD0daae2231E9CB96b94C8512223533293C3693Bf |Chainlink CCIP Router for cross chain messaging on  Ethereum Sepolia|
|Ethereum Sepolia | GILT_ADMIN|0x688d800372c88C6C9768fBD4FD1C6Ba4fA48C4eC|** Back Office ** | 

