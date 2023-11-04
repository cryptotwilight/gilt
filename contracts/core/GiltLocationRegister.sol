// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Location Register
  * @author cryptotwilight
  * @dev This is the Location Register implementation for the Gilt protocol
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import "../interfaces/IGVersion.sol";
import "../interfaces/IGLocationRegister.sol";

import "../interfaces/IGRegister.sol";

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