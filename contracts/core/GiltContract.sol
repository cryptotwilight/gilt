// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.20;
 /**
  * @title Gilt - Gilt Contract
  * @author cryptotwilight
  * @dev This is the Gilt Contract implementation 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import "../interfaces/IGRegister.sol";
import "../interfaces/IGiltContract.sol";
import "../interfaces/IGVersion.sol";
import {Token, GiltWork} from "../interfaces/IGiltStructs.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract GiltContract is ERC721, ERC721URIStorage, ERC721Burnable, IGiltContract, IGVersion {
   
    string constant GILT_TELEPORTER_CA = "GILT_TELEPORTER";
    string constant GILT_RECIEVER_CA = "GILT_RECIEVER";
    string constant GILT_ADMIN_CA = "GILT_ADMIN";

       modifier systemOnly (){ 
        require(msg.sender == register.getAddress(GILT_TELEPORTER_CA)
                || msg.sender == register.getAddress(GILT_RECIEVER_CA)
                || msg.sender == register.getAddress(GILT_ADMIN_CA), "system only");
                _;
    }
    using Strings for uint256; 
    using Strings for address;  
    
    string constant vname = "GILT_CONTRACT";
    uint256 constant vversion = 5; 

    uint256 private _nextTokenId;
    IGRegister register; 
    address self; 

    uint256 [] giltIds; 
    uint256 [] settlementIds; 
    mapping(uint256=>bool) isSettledByGiltId; 
    mapping(uint256=>Gilt) giltById; 
    mapping(uint256=>GiltSettlement) giltSettlementById;
    mapping(bytes32=>bool) knownDescriptionId;

    constructor(address _register, string memory _name, string memory _symbol)
        ERC721(_name, _symbol) {
        register = IGRegister(_register);
        self = address(this);
    }
   function getName() pure external returns (string memory _name) {
        return vname; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return vversion; 
    }
    function getGiltIds() view external returns (uint256 [] memory _giltIds){
        return giltIds; 
    }

    function getGilt(uint256 _giltId) view external returns (Gilt memory _gilt){
        return giltById[_giltId];
    }

    function getGiltSettlementIds() view external returns (uint256 [] memory _giltSettlementIds){
        return settlementIds; 
    }

    function getGiltSettlement(uint256 _settlementId) view external returns (GiltSettlement memory _settlement){
        return giltSettlementById[_settlementId];
    }

    function mintGilt(address to_, uint256 _amount, address _token) payable external returns (uint256 _giltId){
        IERC20Metadata token_ = IERC20Metadata(_token);
        token_.transferFrom(msg.sender, self, _amount);
        _giltId = getIndex();
        giltIds.push(_giltId);
        giltById[_giltId] = Gilt({ 
                                    id : _giltId, 
                                    giltContract : self,
                                    value : _amount,
                                    erc20 : Token({
                                                    name : token_.name(),  
                                                    symbol : token_.symbol(),
                                                    token : _token
                                                }), 
                                    srcChainId : register.getChainId(), 
                                    createDate : block.timestamp, 
                                    vaultId : -1, 
                                    work : GiltWork({
                                                        wcontract : self, 
                                                        chainId : register.getChainId(), 
                                                        wid : _giltId 
                                                    })
                                    });
        string memory uri_ = getUri(giltById[_giltId]);
        _safeMint(to_, _giltId);
        _setTokenURI(_giltId, uri_); 
        return _giltId; 
    }

    function reMintGilt(GiltDescription memory _description) external systemOnly returns (uint256 _giltWid) {
        require(!knownDescriptionId[_description.id], "already reminted");
        knownDescriptionId[_description.id] = true; 
        _giltWid = getIndex(); 
         giltIds.push(_giltWid);
        giltById[_giltWid] = Gilt({  
                                    id : _description.tGilt.id, 
                                    giltContract : self,
                                    value : _description.tGilt.value,
                                    erc20 : _description.tGilt.erc20, 
                                    srcChainId : register.getChainId(), 
                                    createDate : block.timestamp, 
                                    vaultId : int256(_description.giltVaultId), 
                                    work : GiltWork({
                                                        wcontract : self, 
                                                        chainId : register.getChainId(), 
                                                        wid : _giltWid 
                                                    })
                                    });
        string memory uri_ = getUri(giltById[_giltWid]);
        _safeMint(_description.holder, _giltWid);
        _setTokenURI(_giltWid, uri_); 
        return _giltWid; 
    }

    function settleGilt(Gilt memory _gilt) external returns (uint256 _settlementId){
        require(!isSettledByGiltId[_gilt.work.wid]);
        require(_gilt.work.chainId == register.getChainId(), "gilt working chain mis-match");
        require(_gilt.work.wcontract == self, "gilt work contract mis-match");
        require(ownerOf(_gilt.work.wid) == msg.sender, "owner only");
        
        isSettledByGiltId[_gilt.work.wid] = true; 
    
        if(_gilt.srcChainId == _gilt.work.chainId 
            && _gilt.giltContract == self
            && _gilt.id == _gilt.work.wid){
            _settlementId = settle(_gilt);
            IERC20Metadata(_gilt.erc20.token).transfer(msg.sender,_gilt.value);
        }
        else {
            require(msg.sender == register.getAddress(GILT_TELEPORTER_CA),"only teleporter can settle foreign gilts" );
            _settlementId = settle(_gilt);
        }
        return _settlementId;
    }


    // The following functions are overrides required by Solidity.
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //==================================== INTERNAL ===================================

    function settle(Gilt memory _gilt) internal returns (uint256 _settlementId) {
  _burn(_gilt.work.wid);
        _settlementId = getIndex(); 
        settlementIds.push(_settlementId); 
        giltSettlementById[_settlementId] = GiltSettlement ({
                         id : _settlementId, 
                         gilt : _gilt,  
                         settlementDate : block.timestamp, 
                         settledBy : msg.sender 
                        });
        
        return _settlementId;
    }

    function getUri(Gilt memory _gilt) pure internal returns (string memory uri) {
        return string.concat(string.concat(string.concat(string.concat(string.concat(string.concat(_gilt.value.toString(),"-"),_gilt.giltContract.toHexString())," - "), _gilt.id.toString())," - "), _gilt.srcChainId.toString());
    }

    function getIndex() internal returns (uint256 _index) {
        _index = _nextTokenId++;
        return _index; 
    } 
}