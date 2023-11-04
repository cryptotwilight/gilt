// SPDX-License-Identifier: APACHE 2.0
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