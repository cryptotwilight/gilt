// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Gilt Contract
  * @author cryptotwilight
  * @dev This is the interface for the Gilt Contract used to mint, re mint and settle gilts 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import {Gilt, GiltDescription, GiltSettlement} from "./IGiltStructs.sol";

interface IGiltContract { 

    function getGiltIds() view external returns (uint256 [] memory _giltIds);

    function getGilt(uint256 _giltId) view external returns (Gilt memory _gilt);

    function getGiltSettlementIds() view external returns (uint256 [] memory _giltSettlementIds);

    function getGiltSettlement(uint256 _settlementId) view external returns (GiltSettlement memory _settlement);

    function mintGilt(address to_, uint256 _amount, address _token) payable external returns (uint256 _giltId);

    function reMintGilt(GiltDescription memory _description) external returns (uint256 _giltWid);

    function settleGilt(Gilt memory _gilt) external returns (uint256 _settlementId);

}