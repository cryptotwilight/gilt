// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Teleporter
  * @author cryptotwilight
  * @dev This is the implementation contract for the Gilt Teleporter 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import "../interfaces/IGVersion.sol";
import "../interfaces/IGRegister.sol";
import "../interfaces/IGVault.sol";
import "../interfaces/IGiltTeleporter.sol";

import "../interfaces/IGiltStructs.sol";
import "../interfaces/IGLocationRegister.sol";
import "../interfaces/IGiltContract.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";

contract GiltTeleporter is IGiltTeleporter, IGVersion {

    using Strings for uint256; 

    modifier adminOnly() { 
        require(msg.sender == register.getAddress(GILT_ADMIN_CA), "admin only");
        _;
    }

    string constant name = "GILT_TELEPORTER";
    uint256 constant version = 7; 

    string constant LOCATION_REGISTER_CA    = "GILT_LOCATION_REGISTER";
    string constant GILT_VAULT_CA           = "GILT_VAULT";
    string constant CCIP_ROUTER_CA          = "CCIP_ROUTER";
    
    string constant GILT_ADMIN_CA           = "GILT_ADMIN";
    uint256 Cross_Chain_Multiple            = 3;
    int256 constant NO_SETTLEMENT           = -1; 
    uint256 constant NO_VAULT               = 0; 

    address self; 

    IGRegister register; 

    uint256 index; 

    uint256 availableFundsForWithdrawal; 
    uint256 markup = 10; 

   
    uint256 [] teleportIds; 
    mapping(uint256=>TeleportRecord) teleportRecordById; 
    mapping(uint256=>bool) replayedByTeleportId; 

    constructor( address _register) {
        register = IGRegister(_register);
        self = address(this);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getTeleportIds() view external returns (uint256 [] memory _teleportIds){
        return teleportIds;
    }

    function getTeleportRecord(uint256 _teleportId) view external returns (TeleportRecord memory _teleport){
        return teleportRecordById[_teleportId];
    }

    function getTeleportFeeEstimate(string memory _destination, Gilt memory _gilt, address _holder) view external returns (uint256 _fee) {
        GiltDescription memory giltDescription_ = getGiltDescription(_gilt, NO_VAULT, _holder);
        Location memory location_ = IGLocationRegister(register.getAddress(LOCATION_REGISTER_CA)).getLocation(_destination);
        Client.EVM2AnyMessage memory message_ = getMessage(location_, giltDescription_);
        return getFeeInternal(location_, message_, true);
    }

    function replayTeleport(uint256 _teleportId) external adminOnly payable returns (uint256 _rteleportId) {
        require(!replayedByTeleportId[_teleportId]," already replayed "); 
        replayedByTeleportId[_teleportId] = true;
        TeleportRecord memory tRecord_ = teleportRecordById[_teleportId];
        return processTeleport(tRecord_.destination, tRecord_.gilt, NO_SETTLEMENT);
    }

    function teleport(string memory _location, Gilt memory _gilt, address _holder) external payable returns (uint256 _teleportId){
        IERC721 erc721_ = IERC721(_gilt.work.wcontract); 
        require(erc721_.ownerOf(_gilt.work.wid) == msg.sender,"ownership mis-match");
        erc721_.transferFrom(msg.sender, self, _gilt.work.wid);
      
        GiltDescription memory giltDescription_ = getGiltDescription(_gilt, (_gilt.vaultId < 0)?vaultGilt(_gilt): uint256(_gilt.vaultId), _holder);
        if(_gilt.work.chainId != _gilt.srcChainId) {
            return processTeleport(_location, giltDescription_,int256(IGiltContract(_gilt.work.wcontract).settleGilt(_gilt)));
        }
        return processTeleport(_location, giltDescription_, NO_SETTLEMENT);
    }

    function withdraw(address payable _to) external adminOnly returns (uint256 _cashout) {
        _cashout = availableFundsForWithdrawal;
        availableFundsForWithdrawal -= _cashout; 
        _to.transfer(_cashout);
        return _cashout; 
    }


    // ============================= INTENRAL =========================================

    function processTeleport(string memory _location, GiltDescription memory _giltDescription, int256 _settlementId) internal returns (uint256 _teleportId) {
        _teleportId = getIndex(); 
        
        Location memory destination_ = IGLocationRegister(register.getAddress(LOCATION_REGISTER_CA)).getLocation(_location);
        Client.EVM2AnyMessage memory message_ = getMessage(destination_, _giltDescription);
        
        uint256 fee_ = getFeeInternal(destination_, message_, false);
        
        require(msg.value >= fee_, string.concat("insufficient fee :required: ", fee_.toString()));

        availableFundsForWithdrawal += (msg.value - fee_);

       address router_ =  register.getAddress(CCIP_ROUTER_CA);
       bytes32 messageId_ = IRouterClient(router_).ccipSend{value: fee_}(destination_.ccipChainId, message_);

        teleportIds.push(_teleportId);
        teleportRecordById[_teleportId] = TeleportRecord({
                                                            id : _teleportId,  
                                                            destination : _location, 
                                                            messageId : messageId_,
                                                            gilt : _giltDescription, 
                                                            settlementId : _settlementId,
                                                            teleportDate : block.timestamp
                                                        });
        return _teleportId;                                                 
    }

    function vaultGilt(Gilt memory _gilt) internal returns (uint256 _vaultId) {
        address vaultAddress_ = register.getAddress(GILT_VAULT_CA);
        IERC721(_gilt.giltContract).approve(vaultAddress_, _gilt.id);
        _vaultId = IGVault(vaultAddress_).vaultGilt(_gilt);
        return _vaultId;
    }

    function getGiltDescription(Gilt memory _gilt, uint256 _vaultId, address _holder) view internal returns (GiltDescription memory _description) {
        return GiltDescription({
                                id : getBytesId(),
                                tGilt : TGilt({
                                                id : _gilt.id,
                                                giltContract : _gilt.giltContract,
                                                value : _gilt.value, 
                                                erc20 : _gilt.erc20, 
                                                srcChainId : _gilt.srcChainId, 
                                                createDate : _gilt.createDate
                                            }),
                                giltVaultId : _vaultId,                             
                                holder : _holder,
                                date : block.timestamp, 
                                ccipSrcChainId : IGLocationRegister(register.getAddress(LOCATION_REGISTER_CA)).getLocation(register.getChainId()).ccipChainId, 
                                srcChainId : register.getChainId()
                            });
    }

    function getMessage(Location memory _location, GiltDescription memory _giltDescription) pure internal returns (Client.EVM2AnyMessage memory _message){
        _message = Client.EVM2AnyMessage({
            receiver: abi.encode(_location.reciever),
            data: abi.encode(_giltDescription),
            tokenAmounts: new Client.EVMTokenAmount[](0),
            extraArgs: "",
            feeToken: address(0)
        });
        return _message; 
    }

    function getBytesId() view internal returns (bytes32 _id) {
        return keccak256(abi.encodePacked(block.timestamp, msg.sender));
    }

    function getIndex() internal returns (uint256 _index) {
        _index = index++;
        return _index; 
    }

    function getFeeInternal(Location memory _location, Client.EVM2AnyMessage memory _message, bool _markup) view internal returns (uint256 _fee) {
        _fee = IRouterClient(register.getAddress(CCIP_ROUTER_CA)).getFee(_location.ccipChainId, _message);
        _fee *= Cross_Chain_Multiple;
        if(_markup){
            _fee = (markup * _fee)/100;
        }
        return _fee; 
    }
}