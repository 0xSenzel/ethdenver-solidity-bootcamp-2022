const { ethers, network } = require("hardhat");
const axios = require("axios");

const MAINNET_RPC_URL = process.env.MAINNET_RPC_URL;
//const provider = new ethers.providers.getDefaultProvider('http://127.0.0.1:8545/')

async function main() { // npx hardhat run test.js --network localhost
    const latestBlock = (await hre.ethers.provider.getBlock("latest")).number
    console.log("Current block number:", latestBlock); 

    const address = "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045"; // vitalik.eth
    const vitalikAccount = await ethers.getImpersonatedSigner(address);
    const vitalikBalance = await vitalikAccount.getBalance();
    console.log("Vitalik's account balance:", vitalikBalance);

    const team1Account = await ethers.getImpersonatedSigner("0xE6AC36dcb627663D61538cBfd74438382aD18DF1");
    const team1AccountBalance = await team1Account.getBalance();
    console.log("Team1's account balance: ", team1AccountBalance);

    console.log("\n===Vitalik is transferring us some ETH===");
    const transfer = await vitalikAccount.sendTransaction(
        {
            to: team1Account.address,
            value: ethers.utils.parseEther("10"),
        });

    console.log('\nAfter:');

    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms || 1000));
      }
    await sleep(10000);

    console.log("Vitalik's account balance:", vitalikBalance);
    console.log("Team1's account balance: ", team1AccountBalance);
}

main()
.then(() => process.exit(0))
.catch((error) => {
    console.error(error);
    process.exit(1);
})