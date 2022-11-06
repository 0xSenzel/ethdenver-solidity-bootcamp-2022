const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Testing", function () {
let owner, user1, VolcanoCoinFactory, volcanoCoin, VolcanoNFTFactory, volcanoNFT;

    beforeEach(async () => {
    [owner, user1] = await ethers.getSigners();
    // Deploy VolcanoCoin
    VolcanoCoinFactory = await ethers.getContractFactory("VolcanoCoin", owner.address);
    volcanoCoin = await VolcanoCoinFactory.deploy();
    await volcanoCoin.deployed();
    // Deploy VolcanoNFT
    VolcanoNFTFactory = await ethers.getContractFactory("VolcanoNFT", owner.address);
    volcanoNFT = await VolcanoNFTFactory.deploy(volcanoCoin.address);
    await volcanoNFT.deployed();
    });

    describe("Deployment", function () {
      it("Should mint 10000 coin", async function () {
        expect(await volcanoCoin.getTotalSupply()).to.equal(10000);
      });

      it("Owner should own 10000 coin", async function () {
        expect(await volcanoCoin.getBalance(owner.address)).to.equal(10000);
      });

      it("Total Supply should be 11000 coin", async function () {
        await volcanoCoin.connect(owner).addSupply();
        expect(await volcanoCoin.getTotalSupply()).to.equal(11000);
      });

      it("VolcanoNFT should have symbol - VOL", async function () {
        expect(await volcanoNFT.symbol()).to.equal("VOL");
      });

      it("VolcanoNFT should be named - Volcano", async function () {
        expect(await volcanoNFT.name()).to.equal("Volcano");
      });

      it("VolcanoNFT should deploy by owner address", async function () {
        expect(await volcanoNFT.owner()).to.equal(owner.address);
      });
    });

    describe("Minting using custom ERC20", function () {
      it("Should mint 1 NFT using VolcanoCoin", async function () {
        await volcanoNFT.connect(owner).mint();
        expect(await volcanoNFT.balanceOf(owner.address)).to.equal(1);
        expect(await volcanoCoin.getBalance(owner.address)).to.equal(9999);
      });
    });
});