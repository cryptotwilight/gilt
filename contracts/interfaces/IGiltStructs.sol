// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Structs
  * @author cryptotwilight
  * @dev These are the structs used in by the system 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
struct Token {
    string name; 
    string symbol; 
    address token; 
}
struct TGilt { 
    uint256 id; 
    address giltContract;
    uint256 value; 
    Token erc20; 
    uint256 srcChainId; 
    uint256 createDate;
}
struct Gilt {
    uint256 id; 
    address giltContract;
    uint256 value; 
    Token erc20; 
    uint256 srcChainId; 
    uint256 createDate;
    int256 vaultId;  
    GiltWork work; 
}

struct GiltWork { 
    address wcontract;
    uint256 chainId; 
    uint256 wid; 
}

struct GiltSettlement {
    uint256 id; 
    Gilt gilt; 
    uint256 settlementDate; 
    address settledBy; 
}

struct GiltDescription {
        bytes32 id; 
        TGilt tGilt; 
        uint256 giltVaultId;
        address holder;
        uint256 date; 
        uint64 ccipSrcChainId;
        uint256 srcChainId; 
        bool autonomous; 
}

struct TeleportRecord {
    uint256 id; 
    string destination; 
    bytes32 messageId; 
    GiltDescription gilt; 
    int256 settlementId;
    uint256 teleportDate;
}

struct Location {
    string name; 
    address reciever; 
    uint64 ccipChainId; 
    uint256 chainId; 
}