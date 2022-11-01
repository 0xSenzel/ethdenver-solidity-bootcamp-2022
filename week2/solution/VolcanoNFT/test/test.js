const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("VolcanoNFT Test", function () {
let owner, user1, VolcanoNFTFactory, volcanoNFT;

    beforeEach(async () => {
        [owner, user1] = await ethers.getSigners();
        VolcanoNFTFactory = await ethers.getContractFactory("VolcanoNFT", owner.address);
        volcanoNFT = await VolcanoNFTFactory.deploy();
        //await volcanoNFT.deployed();
        console.log("Deployed with:", owner.address);
        console.log("Contract Deployed to:", volcanoNFT.address);
    });

    describe("Deployment:", function () {
        it("Should deploy by owner address", async function () {
            expect(await volcanoNFT.owner()).to.equal(owner.address);
        });
    })
    
});