const { ethers } = require("hardhat");

const main = async () => {
  const DogCoinFactory = await ethers.getContractFactory("DogCoinGame");
  const dogCoinContract = await DogCoinFactory.deploy();
  await dogCoinContract.deployed();

  await hre.tenderly.persistArtifacts({
    name: "DogCoinGame",
    address: dogCoinContract.address,
  });
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
