const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

describe("Testing", function () {
let owner, user1;
  beforeEach(async () => {
    [owner, user1] = await ethers.getSigners();

    ShameCoinFactory = await ethers.getContractFactory("ShameCoin", owner.address);
    shameCoin = await ShameCoinFactory.deploy(owner.address);
    await shameCoin.deployed();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await shameCoin.owner()).to.equal(owner.address);
    });
  });

  describe("Transfer", function() {
    it("Should increase balance of user1", async function () {
      await shameCoin.connect(user1).transfer(owner.address, owner.address);
      expect(await shameCoin.balances(user1.address)).to.equal(1);
    });
  });

});
