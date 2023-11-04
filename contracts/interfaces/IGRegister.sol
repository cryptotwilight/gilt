// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Operations Register
  * @author cryptotwilight
  * @dev This is the interface for the Operations Register used to look up contracts in the Gilt system
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
interface IGRegister {

    function getAddress(string memory _name) view external returns (address _address);

    function getChainId() view external returns (uint256 _chainId);

}