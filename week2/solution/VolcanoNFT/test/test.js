const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("VolcanoNFT Test", function () {
let owner1, user1, VolcanoNFTFactory, volcanoNFT;

    beforeEach(async () => {
        [owner1, user1] = await ethers.getSigners();
        VolcanoNFTFactory = await ethers.getContractFactory("VolcanoNFT", owner1.address);
        volcanoNFT = await VolcanoNFTFactory.deploy();
        await volcanoNFT.deployed();
        //console.log("Deployed with:", owner.address);
        //console.log("Contract Deployed to:", volcanoNFT.address);
    });

    describe("Deployment:", function () {
        it("Should be symbol - VOL", async function () {
            expect(await volcanoNFT.symbol()).to.equal("VOL");
        });

        it("Should be name - VolcanoNFT", async function () {
            expect(await volcanoNFT.name()).to.equal("Volcano");
        });

        it("Should deploy by owner address", async function () {
            expect(await volcanoNFT.owner()).to.equal(owner1.address);
        });
    });

    describe("Minting:", function () {
        it("Should add balance of NFT for user", async function () {
            await volcanoNFT.connect(user1).mint();
            expect(await volcanoNFT.balanceOf(user1.address)).to.equal(1);
        });
    });

    describe("Transfer NFT:", function () {
        it("Should transfer NFT from user1 to owner", async function () {
            await volcanoNFT.connect(user1).mint();
            await volcanoNFT.connect(user1).transfer(owner1.address,0);
            expect(await volcanoNFT.balanceOf(owner1.address)).to.equal(1);
        });
    });
    
});