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

    modifier adminOnly() { 
        require(msg.sender == register.getAddress(GILT_ADMIN_CA), "admin only");
        _;
    }
    
    using Strings for uint64; 
    using Strings for address; 

    string constant name = "GILT_RECIEVER"; 
    uint256 constant version = 11; 

    string constant LOCATION_REGISTER_CA = "GILT_LOCATION_REGISTER"; 
    string constant GILT_CONTRACT_CA = "GILT_CONTRACT";
    string constant GILT_VAULT_CA = "GILT_VAULT";
    string constant GILT_ADMIN_CA = "GILT_ADMIN";

    address self; 

    IGRegister register; 
    uint256 [] receiptIds; 
    mapping(uint256=>GiltDescription) giltDescriptionByReceiptId; 
    mapping(uint256=>uint256) receiptIdByWid;

    mapping(uint256=>string) statusByRecieptId; 
    uint256 index; 
    mapping(uint256=>string) errorByRecieptId;
    mapping(uint256=>bytes) rawDataByReceiptId;
    mapping(bytes32=>bool) claimedByDescriptionId; 

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

    function getRecieptStatus(uint256 _recieptId) view external returns (string memory _status) {
        return statusByRecieptId[_recieptId];
    }

    function getErrorMessage(uint256 _recieptId) view external returns (string memory _errorMessage) {
        return errorByRecieptId[_recieptId];
    }

    function getGiltDescription(uint256 _receiptId) view external returns (GiltDescription memory _giltDescription) {
        return giltDescriptionByReceiptId[_receiptId];
    }

    function getGiltDescriptionByWid(uint256 _wid) view external returns (GiltDescription memory _giltDescription){
        return giltDescriptionByReceiptId[receiptIdByWid[_wid]];
    }

    function getRawData(uint256 _receiptId) view external returns (bytes memory _data) { 
        return rawDataByReceiptId[_receiptId];
    }

    function getGiltDescription(bytes memory _data) pure external returns (GiltDescription memory _giltDescription) {
        return abi.decode(_data, (GiltDescription));
    }

    function getGiltDescriptionFromRaw(uint256 _receiptId) view external returns (GiltDescription memory _giltDescription){
        return abi.decode(rawDataByReceiptId[_receiptId], (GiltDescription));
    }

    function claim(uint256 _receiptId) external returns (uint256 _giltWId, address _giltWContract) {
        return claimInternal(abi.decode(rawDataByReceiptId[_receiptId], (GiltDescription)), _receiptId);
    }

    function processManualRemint(uint256 _receiptId) external adminOnly returns (uint256 _giltWid) {
        _giltWid = IGiltContract(register.getAddress(GILT_CONTRACT_CA)).reMintGilt(giltDescriptionByReceiptId[_receiptId]);
        receiptIdByWid[_giltWid] = _receiptId;
        return _giltWid;
    }

    function _ccipReceive(Client.Any2EVMMessage memory _message) internal override {
        uint256 receiptId_ = getIndex(); 
        receiptIds.push(receiptId_);
      
        IGLocationRegister locationRegister_ = IGLocationRegister(register.getAddress(LOCATION_REGISTER_CA));
        uint64 source_ = _message.sourceChainSelector;  
        if(!locationRegister_.isSupportedCcipChain(source_)){ 
           errorByRecieptId[receiptId_] = string.concat("unsupported source :x: ", source_.toString());
            statusByRecieptId[receiptId_] = "ERROR";
           return; 
        }
        address sender_ = abi.decode(_message.sender, (address));
        if(!locationRegister_.isAllowed(sender_)){
            errorByRecieptId[receiptId_] = string.concat("sender not allowed :x: ", sender_.toHexString());
            statusByRecieptId[receiptId_] = "ERROR";
            return;
        }
        rawDataByReceiptId[receiptId_] = _message.data; 

        GiltDescription memory description_ = abi.decode(_message.data, (GiltDescription));

        giltDescriptionByReceiptId[receiptId_] = description_; 

        if(description_.autonomous) {
            claimInternal(description_, receiptId_);
        }
  

        statusByRecieptId[receiptId_] = "SUCCESS";
        return; 
    }

    //=================================================== INTERNAL =======================================================


    function claimInternal(GiltDescription memory _description, uint256 _receiptId) internal returns (uint256 _giltWid, address _giltWContract) {
            require(!claimedByDescriptionId[_description.id], "already claimed");
            claimedByDescriptionId[_description.id] = true; 
            
            if(_description.tGilt.srcChainId == register.getChainId()){
                IGVault(register.getAddress(GILT_VAULT_CA)).releaseGilt(_description.giltVaultId); 
                _giltWContract = _description.tGilt.giltContract;
                _giltWid = _description.tGilt.id;
                IERC721(_giltWContract).transferFrom(self, _description.holder, _giltWid); 
                receiptIdByWid[_giltWid] = _receiptId;
            }
            else {
                _giltWContract = register.getAddress(GILT_CONTRACT_CA);
                _giltWid = IGiltContract(_giltWContract).reMintGilt(_description);
                receiptIdByWid[_giltWid] = _receiptId; 
            }
            return (_giltWid, _giltWContract);
    }

    function getIndex() internal returns (uint256 _index) {
        _index = index++;
        return _index; 
    }
}