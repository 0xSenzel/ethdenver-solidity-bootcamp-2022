// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoNFT is ERC721("Volcano", "VOL"), Ownable {
    uint256 tokenId;
    constructor() {
    }

    function mint() public {
        _safeMint(msg.sender, tokenId);
        tokenId++;
    }

    function transfer(address to, uint256 _tokenId) public {
        _transfer(msg.sender, to, _tokenId);
    }
}