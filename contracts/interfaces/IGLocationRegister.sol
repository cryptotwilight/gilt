// SPDX-License-Identifier: APACHE 2.0
pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Location Register
  * @author cryptotwilight
  * @dev This is the interface for all the locations supported by the dApp
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
import {Location} from "./IGiltStructs.sol";

interface IGLocationRegister {

    function getLocations() view external returns (Location [] memory _destinations);

    function getLocation(string memory _name) view external returns (Location memory _location);

    function getLocation(uint256 _chainId) view external returns (Location memory _location);

    function isSupportedCcipChain(uint64 _ccipChainId) view external returns (bool _isSupported);

    function isAllowed(address _sender) view external returns (bool _isAllowed);

}