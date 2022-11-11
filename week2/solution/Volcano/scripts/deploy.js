const { ethers } = require("hardhat");

const main = async () => {
  const VolcanoCoinFactory = await ethers.getContractFactory("VolcanoCoin");
  const volcanoCoinContract = await VolcanoCoinFactory.deploy();

  await volcanoCoinContract.deployed(); //0x3065b742133D5A24109BCE74139Ee96CE06C9C5c
  console.log("VolcanoCoin Contract Deployed to Address:", volcanoCoinContract.address);

  const VolcanoNFTFactory = await ethers.getContractFactory("VolcanoNFT");
  const volcanoNFTContract = await VolcanoNFTFactory.deploy(
    volcanoCoinContract.address
  );

  await volcanoNFTContract.deployed(); //0xEc0B1602f6da50D725317A42b0BAc7022032F2F3
  console.log("VolcanoNFT Contract Deployed to Address:", volcanoNFTContract.address);

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