// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Teleporter
  * @author cryptotwilight
  * @dev This is the interface for the teleporter that transfers gilts cross chain maintaining ownership 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import {TeleportRecord, Gilt} from "./IGiltStructs.sol";

interface IGiltTeleporter { 

    function getTeleportIds() view external returns (uint256 [] memory _teleportIds);

    function getTeleportRecord(uint256 _teleportId) view external returns (TeleportRecord memory _teleport);

    function teleport(string memory _destination, Gilt memory _gilt, address _holder, bool _autonomous) external payable returns (uint256 _teleportId);

    function teleport(string memory _location, uint256 _giltWid, address _giltWContract, address _holder, bool _autonomous) external payable returns (uint256 _teleportId);

}