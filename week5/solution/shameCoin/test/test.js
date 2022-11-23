const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Testing", function () {
  let owner, user1, user2;
  beforeEach(async () => {
    [owner, user1, user2] = await ethers.getSigners();

    ShameCoinFactory = await ethers.getContractFactory(
      "ShameCoin",
      owner.address
    );
    shameCoin = await ShameCoinFactory.deploy();
    await shameCoin.deployed();
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await shameCoin.owner()).to.equal(owner.address);
    });
  });

  describe("Transfer", function () {
    it("Transfer token to user1, should increase user1 balance", async function () {
      await shameCoin.connect(owner).transfer(owner.address, user1.address);
      expect(await shameCoin.connect(user1).balance()).to.equal(1);
    });

    it("user1 triggering transfer(), should increase user1 balance", async function () {
      await shameCoin.connect(user1).transfer(user1.address, owner.address);
      expect(await shameCoin.connect(user1).balance()).to.equal(1);
    });
  });

  describe("Approve and Transfer", function () {
    it("Should give approval to owner", async function () {
      await shameCoin.connect(user1).approve(owner.address, 10);
      expect(await shameCoin.connect(user1).allowances(owner.address)).to.equal(
        10
      );
    });

    it("Transfer approved token of user1 by owner, should decrease token of user1 and allowance of user1 for owner", async function () {
      await shameCoin.connect(owner).transfer(owner.address, user1.address);
      await shameCoin.connect(user1).approve(owner.address, 10);
      await shameCoin.connect(owner).transfer(user1.address, user2.address);
      expect(await shameCoin.connect(user1).allowances(owner.address)).to.equal(
        9
      );
      expect(await shameCoin.connect(user1).balance()).to.equal(0);
      expect(await shameCoin.connect(user2).balance()).to.equal(1);
    });
  });
});
