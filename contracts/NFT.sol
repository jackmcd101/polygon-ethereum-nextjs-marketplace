// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress;
	address payable public immutable creator; //Creator of NFT, cannot be changed
	uint8 royaltyFee; //The royalty fee charged by Market.sol to sellers of the creator's NFT

    constructor(address marketplaceAddress) ERC721("Metaverse", "METT") {
        contractAddress = marketplaceAddress;
		creator = payable(msg.sender);
    }

    function createToken(string memory tokenURI) public returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }

	function changeRoyaltyFee(uint8 _royaltyFee) external {
		require(msg.sender == creator, "Must be the NFT Creator");
		require(_royaltyFee < 40, "Must be less than a 40 percent fee");

		royaltyFee = _royaltyFee;
	}
}