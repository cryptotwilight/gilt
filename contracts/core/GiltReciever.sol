// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Reciever
  * @author cryptotwilight
  * @dev This is the implementation contract for the Gilt reciever. It recieves gilts and either releases them from the vault if they are returning or reMints them if they are foreign
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import "../interfaces/IGRegister.sol";
import {GiltDescription, Gilt} from "../interfaces/IGiltStructs.sol";
import "../interfaces/IGLocationRegister.sol";
import "../interfaces/IGVersion.sol";
import "../interfaces/IGiltContract.sol";
import "../interfaces/IGVault.sol";

import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract GiltReciever is CCIPReceiver, IGVersion {

    using Strings for uint64; 
    using Strings for address; 

    string constant name = "GILT_RECIEVER"; 
    uint256 constant version = 4; 

    string constant LOCATION_REGISTER_CA = "GILT_LOCATION_REGISTER"; 
    string constant GILT_CONTRACT_CA = "GILT_CONTRACT";
    string constant GILT_VAULT_CA = "GILT_VAULT";

    address self; 

    IGRegister register; 
    uint256 [] receiptIds; 
    mapping(uint256=>GiltDescription) giltDescriptionByReceiptId; 
    mapping(uint256=>GiltDescription) giltDescriptionByWid;

    uint256 index; 

    constructor(address _register, address _router) CCIPReceiver(_router) {
        register = IGRegister(_register);
        self = address(this);
    }
    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }
    function getReceiptIds() view external returns (uint256 [] memory _ids) {
        return receiptIds; 
    }

    function getGiltDescription(uint256 _receiptId) view external returns (GiltDescription memory _giltDescription) {
        return giltDescriptionByReceiptId[_receiptId];
    }

    function getGiltDescriptionByWid(uint256 _wid) view external returns (GiltDescription memory _giltDescription){
        return giltDescriptionByWid[_wid];
    }

    function _ccipReceive(Client.Any2EVMMessage memory _message) internal override {
       IGLocationRegister locationRegister_ = IGLocationRegister(register.getAddress(LOCATION_REGISTER_CA));
       uint64 source_ = _message.sourceChainSelector;  
       require(locationRegister_.isSupportedCcipChain(source_), string.concat("unsupported source :x: ", source_.toString()));
       address sender_ = abi.decode(_message.sender, (address));
       require(locationRegister_.isAllowed(sender_), string.concat("sender not allowed :x: ", sender_.toHexString()));
       GiltDescription memory description_ = abi.decode(_message.data, (GiltDescription));
       uint256 receiptId_ = getIndex(); 
       receiptIds.push(receiptId_);
       giltDescriptionByReceiptId[receiptId_] = description_; 

       if(description_.tGilt.srcChainId == register.getChainId()){
            IGVault(register.getAddress(GILT_VAULT_CA)).releaseGilt(description_.giltVaultId); 
            IERC721(description_.tGilt.giltContract).transferFrom(self, description_.holder, description_.tGilt.id);
            giltDescriptionByWid[description_.tGilt.id] = description_;  
       }
       else {
            uint256 giltWid_ = IGiltContract(register.getAddress(GILT_CONTRACT_CA)).reMintGilt(description_);
            giltDescriptionByWid[giltWid_] = description_; 
       }
    }

    function getIndex() internal returns (uint256 _index) {
        _index = index++;
        return _index; 
    }
}