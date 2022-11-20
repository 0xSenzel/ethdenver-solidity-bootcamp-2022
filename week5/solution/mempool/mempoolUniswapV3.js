const { ethers } = require("ethers");
const { TransactionDescription } = require("ethers/lib/utils");
require("dotenv").config();

const uniswapRouterV3Address = "0xE592427A0AEce92De3Edee1F18E0157C05861564";
const provider = new ethers.providers.WebSocketProvider(
  process.env.MAINNET_URL
);

async function main() {
  provider.on("pending", async (txHash) => {
    const tx = await provider.getTransaction(txHash);

    try {
      if (tx != null && tx.to == uniswapRouterV3Address) {
        console.log("Its Uniswap!");
        console.log(tx);
      }
    } catch {
      console.log("Failed!");
    }
  });
}

main().catch((error) => {
  console.error(error);
});
