const { ethers } = require("hardhat");
const { providers } = require("ethers");
// Libraries that supports balanceOf, approve
const IERC20Minimal = require("@uniswap/v3-core/artifacts/contracts/interfaces/IERC20Minimal.sol/IERC20Minimal.json");
// Libraries that supports safeTransferFrom, safeApprove
const TransferHelp = require("@uniswap/v3-periphery/artifacts/contracts/libraries/TransferHelper.sol/TransferHelper.json");
// Libraries that supports ExactInputSingleParams, exactInputSingle
const ISwapRouter = require("@uniswap/v3-periphery/artifacts/contracts/interfaces/ISwapRouter.sol/ISwapRouter.json");

const MAINNET_RPC_URL = process.env.MAINNET_RPC_URL;
const UniswapV3Router = "0xE592427A0AEce92De3Edee1F18E0157C05861564";
const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
const USDC = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
const BUSD = "0x4Fabb145d64652a948d72533023f6E7A623C7C53";
const Binance = "0xDFd5293D8e347dFe59E90eFd55b2956a1343963d";
const provider = new ethers.providers.getDefaultProvider(
  "http://127.0.0.1:8545/"
);

async function main() {
  let binanceDAIBalance, myWallet;

  // Deploy contract
  const swapDAIFactory = await ethers.getContractFactory("SwapDAI");
  const swapDAI = await swapDAIFactory.deploy(UniswapV3Router);
  await swapDAI.deployed();

  // Impersonate Binance and return DAi balance owned by Binance
  const binance = await ethers.getImpersonatedSigner(Binance);
  const dai = new ethers.Contract(DAI, IERC20Minimal.abi, provider);
  binanceDAIBalance = await dai.balanceOf(Binance);
  console.log(
    "Binance DAI balance:",
    ethers.utils.formatUnits(binanceDAIBalance)
  );

  console.log("approving this SwapDai contract...");
  // approve our address to accept eth
  await dai.approve(swapDAI.address, binanceDAIBalance);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

/*
  function swapExactInputSingle(uint256 amountIn) external returns (uint256 amountOut) {
        // msg.sender must approve this contract

        // Transfer the specified amount of DAI to this contract.
        TransferHelper.safeTransferFrom(DAI, msg.sender, address(this), amountIn);

        // Approve the router to spend DAI.
        TransferHelper.safeApprove(DAI, address(swapRouter), amountIn);

        // Naively set amountOutMinimum to 0. In production, use an oracle or other data source to choose a safer value for amountOutMinimum.
        // We also set the sqrtPriceLimitx96 to be 0 to ensure we swap our exact input amount.
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: DAI,
                tokenOut: WETH9,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);
    }
     */
