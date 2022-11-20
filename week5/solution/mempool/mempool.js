const { ethers } = require("ethers");
require("dotenv").config();

async function main() {
  const provider = new ethers.providers.WebSocketProvider(
    process.env.MAINNET_URL
  );

  provider.on("pending", async (tx) => {
    const txInfo = await provider.getTransaction(tx);
    console.log(txInfo);
  });
}

main(); /*
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });*/
