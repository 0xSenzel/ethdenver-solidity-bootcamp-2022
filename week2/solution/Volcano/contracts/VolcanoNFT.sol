// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

interface IVolcanoCoin {
    function _transferFrom(address from, address to, uint256 amount) external;
    function getBalance(address user) external view returns(uint256);
}

contract VolcanoNFT is ERC721URIStorage, Ownable {
    IVolcanoCoin public token;
    // Tracking tokenId of latest NFT to be minted
    uint256 tokenId;
    // Price in VolcanoCoin to mint 1 NFT
    uint256 constant MINT_PRICE = 10;
    // Price in Ether
    uint256 constant ETH_PRICE = 0.1 ether;

    string[] memes = [
        "ipfs://bafkreifok2ntbcib5r6axgh25viuipz2d2b5nft3qczuwb5zpr6evb4qba"
    ];

    constructor(address tokenAddress) ERC721("Volcano", "VOL") {
        token = IVolcanoCoin(tokenAddress);
    }

    function mintWithEther() public payable {
            (bool success,) = payable(msg.sender).call{value: ETH_PRICE}("");
            require(success, "ETH Transfer failed");

            _safeMint(msg.sender, tokenId);
            string memory defaultURI = memes[0];
            _setTokenURI(tokenId, defaultURI);
            tokenId++;    
    }

    function mintWithVolcanoCoin() public {
        // transfer VolcanoCoin from msg.sender to this vault
            token._transferFrom(msg.sender, address(this), MINT_PRICE);
            _safeMint(msg.sender, tokenId);

            string memory defaultURI = memes[0];
            _setTokenURI(tokenId, defaultURI);
            tokenId++;
    }

    function transferNFT(address to, uint256 _tokenId) public {
        _transfer(msg.sender, to, _tokenId);
    }

    function setNftTokenURI(uint256 _tokenId, string memory _tokenURI) external onlyOwner {
        _setTokenURI(_tokenId, _tokenURI);
    }

    function volcanoCoinBalance() external view returns (uint256) {
        return token.getBalance(address(this));
    }

    receive() external payable  { }

}