// SPDX-License-Identifier: APACHE 2.0
// File: contracts/interfaces/IGRegister.sol


pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Operations Register
  * @author cryptotwilight
  * @dev This is the interface for the Operations Register used to look up contracts in the Gilt system
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
interface IGRegister {

    function getAddress(string memory _name) view external returns (address _address);

    function getChainId() view external returns (uint256 _chainId);

}
// File: contracts/interfaces/IGiltStructs.sol


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
// File: contracts/interfaces/IGLocationRegister.sol


pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Location Register
  * @author cryptotwilight
  * @dev This is the interface for all the locations supported by the dApp
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */


interface IGLocationRegister {

    function getLocations() view external returns (Location [] memory _destinations);

    function getLocation(string memory _name) view external returns (Location memory _location);

    function getLocation(uint256 _chainId) view external returns (Location memory _location);

    function isSupportedCcipChain(uint64 _ccipChainId) view external returns (bool _isSupported);

    function isAllowed(address _sender) view external returns (bool _isAllowed);

}
// File: contracts/interfaces/IGVersion.sol


pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Version 
  * @author cryptotwilight
  * @dev Operations contract for tracking code versions across environments 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
interface IGVersion { 

    function getName() view external returns (string memory _name);

    function getVersion() view external returns (uint256 _version);
}
// File: contracts/core/GiltLocationRegister.sol


pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Location Register
  * @author cryptotwilight
  * @dev This is the Location Register implementation for the Gilt protocol
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */




contract GiltLocationRegister is IGLocationRegister, IGVersion { 

    string constant name = "GILT_LOCATION_REGISTER";
    uint256 constant version = 2; 

    IGRegister register; 

    uint256 [] chainIds;
 
    address [] senders; 

    mapping(address=>bool) isAllowedBySender; 
    mapping(uint64=>bool) isSupportedByCcipChainId; 

    mapping(uint256=>Location) locationByChainId; 
    mapping(string=>Location) locationByName; 
    mapping(uint256=>bool) knownChainId; 

    constructor(address _register) {
        register = IGRegister(_register);
    }
    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }
    function getLocations() view external returns (Location [] memory _locations){
        _locations = new Location[](chainIds.length);
        for(uint256 x = 0; x < chainIds.length; x++) {
            _locations[x] = locationByChainId[chainIds[x]];
        }
        return _locations; 
    }

    function getLocation(string memory _name) view external returns (Location memory _location){
        return locationByName[_name];
    }

    function getLocation(uint256 _chainId) view external returns (Location memory _location){
        return locationByChainId[_chainId];
    }

    function isSupportedCcipChain(uint64 _ccipChainId) view external returns (bool _isSupported){
        return isSupportedByCcipChainId[_ccipChainId];
    }

    function isAllowed(address _sender) view external returns (bool _isAllowed){
        return isAllowedBySender[_sender];
    }

    function getSenders() view external returns (address[] memory _senders) {
        return senders; 
    }

    function addLocation(Location memory _location) external returns (bool _added) {
        if(!knownChainId[_location.chainId]){
            chainIds.push(_location.chainId);
            knownChainId[_location.chainId] = true; 
        }
        locationByChainId[_location.chainId] = _location;
        locationByName[_location.name] = _location;
        isSupportedByCcipChainId[_location.ccipChainId] = true;
        return true; 
    }

    function addAllowedSender(address _sender)  external returns (bool _added) {
        senders.push(_sender);
        isAllowedBySender[_sender] = true; 
        return true; 
    }
}