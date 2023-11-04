// SPDX-License-Identifier: APACHE 2.0
// File: @openzeppelin/contracts/utils/introspection/IERC165.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/introspection/IERC165.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, sea {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC721/IERC721.sol)

pragma solidity ^0.8.20;


/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or
     *   {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
     * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
     * understand this adds an external call which potentially creates a reentrancy vulnerability.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the address zero.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

// File: contracts/interfaces/IGRegister.sol


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
// File: contracts/interfaces/IGVersion.sol


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
// File: contracts/interfaces/IGiltStructs.sol


pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Structs
  * @author cryptotwilight
  * @dev These are the structs used in by the system 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */
struct Token {
    string name; 
    string symbol; 
    address token; 
}
struct TGilt { 
    uint256 id; 
    address giltContract;
    uint256 value; 
    Token erc20; 
    uint256 srcChainId; 
    uint256 createDate;
}
struct Gilt {
    uint256 id; 
    address giltContract;
    uint256 value; 
    Token erc20; 
    uint256 srcChainId; 
    uint256 createDate;
    int256 vaultId;  
    GiltWork work; 
}

struct GiltWork { 
    address wcontract;
    uint256 chainId; 
    uint256 wid; 
}

struct GiltSettlement {
    uint256 id; 
    Gilt gilt; 
    uint256 settlementDate; 
    address settledBy; 
}

struct GiltDescription {
        bytes32 id; 
        TGilt tGilt; 
        uint256 giltVaultId;
        address holder;
        uint256 date; 
        uint64 ccipSrcChainId;
        uint256 srcChainId; 
}

struct TeleportRecord {
    uint256 id; 
    string destination; 
    bytes32 messageId; 
    GiltDescription gilt; 
    int256 settlementId;
    uint256 teleportDate;
}

struct Location {
    string name; 
    address reciever; 
    uint64 ccipChainId; 
    uint256 chainId; 
}
// File: contracts/interfaces/IGVault.sol


pragma solidity >=0.8.2 <0.9.0;
 /**
  * @title Gilt - Vault
  * @author cryptotwilight
  * @dev This is the interfacc for the vault used by the teleporter
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */


interface IGVault {

    function getGilt(uint256 _vaultId) view external returns (Gilt memory _gilt);

    function vaultGilt(Gilt memory _gilt) external returns (uint256 _vaultId);

    function releaseGilt(uint256 _vaultId) external returns (Gilt memory _gilt);


}
// File: contracts/core/GiltVault.sol


pragma solidity ^0.8.20;
 /**
  * @title Gilt - Vault
  * @author cryptotwilight
  * @dev This is the implementation contract for the Gilt Vault 
  * @custom:buidl Web3 ATL Hackathon 2023 https://app.buidlbox.io/404-dao/web3-atl-hackathon
  * @custom:contact @BlockStarLogic1 (Twitter)
  */





contract GiltVault is IGVault, IGVersion { 

    modifier systemOnly (){ 
        require(msg.sender == register.getAddress(GILT_TELEPORTER_CA)
                || msg.sender == register.getAddress(GILT_RECIEVER_CA)
                || msg.sender == register.getAddress(GILT_ADMIN_CA), "system only");
                _;
    }

    string constant name = "GILT_VAULT";
    uint256 constant version = 2; 

    address self; 

    string constant GILT_TELEPORTER_CA = "GILT_TELEPORTER";
    string constant GILT_RECIEVER_CA = "GILT_RECIEVER";
    string constant GILT_ADMIN_CA = "GILT_ADMIN";

    uint256 index; 

    IGRegister register; 
    uint256 [] vaultIds; 
    
    mapping(uint256=>bool) knownVaultId; 
    mapping(uint256=>Gilt) giltByVaultId; 
    mapping(uint256=>bool) isReleased; 

    constructor(address _register) {
        register = IGRegister(_register);
        self = address(this);
    }
    
    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getVaultIds() view external returns (uint256 [] memory _vaultIds) {
        return vaultIds; 
    }

    function getGilt(uint256 _vaultId) view external returns (Gilt memory _gilt) {
        return giltByVaultId[_vaultId];
    }

    function vaultGilt(Gilt memory _gilt) external systemOnly returns (uint256 _vaultId){
        _vaultId = getIndex();
        knownVaultId[_vaultId] = true; 
        IERC721 erc721_ = IERC721(_gilt.work.wcontract); 
        require(erc721_.ownerOf(_gilt.work.wid) == msg.sender,"ownership mis-match");
        erc721_.transferFrom(msg.sender, self, _gilt.work.wid);
        giltByVaultId[_vaultId] = _gilt;
        vaultIds.push(_vaultId);
        return _vaultId; 
    }

    function releaseGilt(uint256 _vaultId) external systemOnly returns (Gilt memory _gilt){
        require(knownVaultId[_vaultId], "unknown vault id");
        _gilt = giltByVaultId[_vaultId];
        IERC721 erc721_ = IERC721(_gilt.work.wcontract);
        erc721_.transferFrom(self, msg.sender, _gilt.work.wid);
        return _gilt;  
    }

    // ==================================== INTERNAL ============================================

    function getIndex() internal returns (uint256 _index) {
        _index = index++;
        return _index; 
    }

}