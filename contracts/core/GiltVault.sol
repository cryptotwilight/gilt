// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.20;
 /**
  * @title Gilt - Vault
  * @author cryptotwilight
  * @dev This is the implementation contract for the Gilt Vault 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import "../interfaces/IGVault.sol";
import "../interfaces/IGVersion.sol";
import "../interfaces/IGRegister.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract GiltVault is IGVault, IGVersion { 

    modifier systemOnly (){ 
        require(msg.sender == register.getAddress(GILT_TELEPORTER_CA)
                || msg.sender == register.getAddress(GILT_RECIEVER_CA)
                || msg.sender == register.getAddress(GILT_ADMIN_CA), "system only");
                _;
    }

    string constant name = "GILT_VAULT";
    uint256 constant version = 2; 

    address self; 

    string constant GILT_TELEPORTER_CA = "GILT_TELEPORTER";
    string constant GILT_RECIEVER_CA = "GILT_RECIEVER";
    string constant GILT_ADMIN_CA = "GILT_ADMIN";

    uint256 index; 

    IGRegister register; 
    uint256 [] vaultIds; 
    
    mapping(uint256=>bool) knownVaultId; 
    mapping(uint256=>Gilt) giltByVaultId; 
    mapping(uint256=>bool) isReleased; 

    constructor(address _register) {
        register = IGRegister(_register);
        self = address(this);
    }
    
    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getVaultIds() view external returns (uint256 [] memory _vaultIds) {
        return vaultIds; 
    }

    function getGilt(uint256 _vaultId) view external returns (Gilt memory _gilt) {
        return giltByVaultId[_vaultId];
    }

    function vaultGilt(Gilt memory _gilt) external systemOnly returns (uint256 _vaultId){
        _vaultId = getIndex();
        knownVaultId[_vaultId] = true; 
        IERC721 erc721_ = IERC721(_gilt.work.wcontract); 
        require(erc721_.ownerOf(_gilt.work.wid) == msg.sender,"ownership mis-match");
        erc721_.transferFrom(msg.sender, self, _gilt.work.wid);
        giltByVaultId[_vaultId] = _gilt;
        vaultIds.push(_vaultId);
        return _vaultId; 
    }

    function releaseGilt(uint256 _vaultId) external systemOnly returns (Gilt memory _gilt){
        require(knownVaultId[_vaultId], "unknown vault id");
        _gilt = giltByVaultId[_vaultId];
        IERC721 erc721_ = IERC721(_gilt.work.wcontract);
        erc721_.transferFrom(self, msg.sender, _gilt.work.wid);
        return _gilt;  
    }

    // ==================================== INTERNAL ============================================

    function getIndex() internal returns (uint256 _index) {
        _index = index++;
        return _index; 
    }

}