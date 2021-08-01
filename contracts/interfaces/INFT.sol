//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

//Interface of NFT.sol

interface INFT {
	function creator() external view returns (address payable);
	function royaltyFee() external view returns (uint8);
}

