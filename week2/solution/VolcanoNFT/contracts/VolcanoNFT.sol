// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract VolcanoNFT is ERC721 {
    constructor() ERC721 ("Volcano", "VOL")  {

    }

    function mint(address to, uint256 tokenId) internal {
        _mint(to, tokenId);
    }

    function transfer(address from, address to, uint256 tokenId) internal {
        _transfer(from, to, tokenId);
    }
}