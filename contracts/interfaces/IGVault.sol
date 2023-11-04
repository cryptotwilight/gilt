// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Vault
  * @author cryptotwilight
  * @dev This is the interfacc for the vault used by the teleporter
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import {Gilt} from "./IGiltStructs.sol";

interface IGVault {

    function getGilt(uint256 _vaultId) view external returns (Gilt memory _gilt);

    function vaultGilt(Gilt memory _gilt) external returns (uint256 _vaultId);

    function releaseGilt(uint256 _vaultId) external returns (Gilt memory _gilt);


}