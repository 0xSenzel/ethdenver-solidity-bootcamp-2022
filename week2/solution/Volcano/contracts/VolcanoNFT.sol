// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IVolcanoCoin {
    function _transferFrom(address from, address to, uint256 amount) external;
}

contract VolcanoNFT is ERC721("Volcano", "VOL"), Ownable {
    // Tracking tokenId of latest NFT to be minted
    uint256 tokenId;

    IVolcanoCoin volcanoCoin;
    // Price in VolcanoCoin to mint
    uint256 constant MINT_PRICE = 1;

    constructor(address tokenAddress) {
        volcanoCoin = IVolcanoCoin(tokenAddress);
    }

    function mint() public payable {
        // transfer VolcanoCoin from msg.sender to this vault
        volcanoCoin._transferFrom(msg.sender, address(this), MINT_PRICE);
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

    receive() external payable  { }
    fallback() external payable { }

}