// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract VolcanoNFT is ERC721("Volcano", "VOL"), Ownable {
    // Tracking tokenId of latest NFT to be minted
    uint256 tokenId;
    // Price in ETH for minting
    uint256 MINT_PRICE = 0.01 ether;

    constructor() {
    }

    function mint() public payable {
        require(msg.value >= MINT_PRICE, "Not enough ether to mint");
        _safeMint(msg.sender, tokenId);
        tokenURI(tokenId);
        tokenId++;
    }

    function transfer(address to, uint256 _tokenId) public {
        _transfer(msg.sender, to, _tokenId);
    }

    function setTokenURI(uint256 _tokenId, string memory _tokenURI) internal view {
        _requireMinted(tokenId);
        tokenURI(_tokenId);
    }

}