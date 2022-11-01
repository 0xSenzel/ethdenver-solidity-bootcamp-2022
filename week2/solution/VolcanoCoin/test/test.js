const main = async () => {
    const [owner] = await ethers.getSigners();
    const VolcanoFactory = await hre.ethers.getContractFactory("VolcanoCoin", owner.address);
    const volcanoCoin = await VolcanoFactory.deploy();

    await volcanoCoin.deployed();

    console.log("Deploy with address:", owner.address);
    console.log("Contract deployed to:", volcanoCoin.address);

    //const totalSupply = await volcanoCoin.getTotalSupply();

    console.log("\n=== Before adding supply ===");
    console.log("Total Supply Amount:", String(await volcanoCoin.getTotalSupply()));

    await volcanoCoin.connect(owner).addSupply();
    //const totalSupply = await volcanoCoin.getTotalSupply();
    
    console.log("\n=== After adding supply ===");
    console.log("Total Supply Amount:", String(await volcanoCoin.getTotalSupply()));
}

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