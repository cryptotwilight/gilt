// SPDX-License-Identifier: APACHE 2.0
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
// File: contracts/core/GiltOpsRegister.sol


pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Operations Register
  * @author cryptotwilight
  * @dev This is the Operations Register implementation for the Gilt Protocol
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */



contract GiltOpsRegister is IGRegister, IGVersion {

    modifier adminOnly () {
        require(msg.sender == admin, "admin only");
        _;
    }

    string constant name = "GILT_REGISTER";
    uint256 constant version = 2; 

    address admin; 
    uint256 chainId; 

    string [] names; 
    mapping(string=>address) addressByName; 
    mapping(string=>bool) knownName;
    mapping(address=>string) nameByAddress; 

    constructor(address _admin, uint256 _chainId) {
        admin = _admin; 
        chainId = _chainId; 
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getName(address _address) view external returns (string memory _name) {
        return nameByAddress[_address];
    }

    function getAddresses() view external returns (string [] memory _names, address [] memory _addresses) {
        _addresses = new address[](names.length);
        for(uint256 x = 0; x < names.length; x++){
            _addresses[x] = addressByName[names[x]];
        }
        return (names, _addresses);
    }

    function getAddress(string memory _name) view external returns (address _address){
        return addressByName[_name];
    }

    function getChainId() view external returns (uint256 _chainId){
        return chainId; 
    }

    function addGVersionAddress(address _address) external adminOnly returns (bool _added) {
        IGVersion v = IGVersion(_address);
        return addAddressInternal(v.getName(), _address); 
    }   

    function addAddress(string memory _name, address _address) external adminOnly returns (bool _added) {
        return addAddressInternal(_name, _address); 
    } 

    //================================= INTERNAL ==================================================================


    function addAddressInternal(string memory _name, address _address) internal returns (bool _added) {
        if(!knownName[_name]){
            names.push(_name);
            knownName[_name] = true; 
        }
        addressByName[_name] = _address; 
        nameByAddress[_address] = _name;
        return true; 
    }
    
}