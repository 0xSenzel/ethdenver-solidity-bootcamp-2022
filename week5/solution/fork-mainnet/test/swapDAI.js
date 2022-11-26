const { ethers } = require("hardhat");
const { providers } = require("ethers");
// Libraries that supports balanceOf, approve
const IERC20Minimal = require("@uniswap/v3-core/artifacts/contracts/interfaces/IERC20Minimal.sol/IERC20Minimal.json");

const SwapRouterABI = require("@uniswap/v3-periphery/artifacts/contracts/interfaces/ISwapRouter.sol/ISwapRouter.json");

const ercAbi = [
  // Read-Only Functions
  "function balanceOf(address _addr) public view returns (uint256)",
  // Authenticated Functions
  "function unpause() public onlyOwner",
  "function approve(address _spender, uint256 _value) public whenNotPaused returns (bool)",
  "function pause() public onlyOwner",
];

const UniswapV3Router = "0xE592427A0AEce92De3Edee1F18E0157C05861564";
const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
const USDC = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
const BUSD = "0x4Fabb145d64652a948d72533023f6E7A623C7C53";
const BINANCE_ADDRESS = "0xDFd5293D8e347dFe59E90eFd55b2956a1343963d";

const getBalance = async (dai, usdc, busd) => {
  binanceDAIBalance = ethers.utils.formatUnits(
    await dai.balanceOf(BINANCE_ADDRESS)
  );
  console.log("Binance DAI balance:", binanceDAIBalance);

  binanceUSDCBalance = ethers.utils.formatUnits(
    await usdc.balanceOf(BINANCE_ADDRESS),
    6
  );
  console.log("Binance USDC balance:", binanceUSDCBalance);

  binanceBUSDBalance = ethers.utils.formatUnits(
    await busd.balanceOf(BINANCE_ADDRESS),
    18
  );
  console.log("Binance BUSD balance:", binanceBUSDBalance);

  return binanceBUSDBalance, binanceDAIBalance, binanceUSDCBalance;
};

const getApproval = async (dai, usdc, busd, binance, swapDAI) => {
  console.log("approving SwapDai contract...");
  await dai
    .connect(binance)
    .approve(swapDAI.address, ethers.utils.parseUnits(binanceDAIBalance));
  await usdc
    .connect(binance)
    .approve(swapDAI.address, ethers.utils.parseUnits(binanceUSDCBalance));
  await busd
    .connect(binance)
    .approve(swapDAI.address, ethers.utils.parseUnits(binanceBUSDBalance));
};

async function main() {
  // Deploy contract
  console.log("deploying SwapDai...");
  const swapDAIFactory = await ethers.getContractFactory("SwapDAI");
  const swapDAI = await swapDAIFactory.deploy(UniswapV3Router);
  await swapDAI.deployed();

  // Impersonate Binance and return DAi balance owned by Binance
  console.log("impersonating binance...");
  const binance = await ethers.getImpersonatedSigner(BINANCE_ADDRESS);
  const owner = await ethers.getImpersonatedSigner(
    "0x0644Bd0248d5F89e4F6E845a91D15c23591e5D33"
  );
  // Connect to DAI, USDC, BUSD
  const dai = new ethers.Contract(DAI, IERC20Minimal.abi, binance);
  const usdc = new ethers.Contract(USDC, IERC20Minimal.abi, binance);
  const busd = new ethers.Contract(BUSD, IERC20Minimal.abi, binance);

  await getBalance(dai, usdc, busd);
  await getApproval(dai, usdc, busd, binance, swapDAI);

  /* Execute the swap DAI to USDC */
  console.log("\nswapping DAI to USDC...");
  const amountIn = ethers.utils.parseUnits("10");
  const allowance = await dai
    .connect(binance)
    .allowance(BINANCE_ADDRESS, swapDAI.address);
  console.log("allowance:", allowance.toString());

  const swapDAIToUSDC = await swapDAI
    .connect(binance)
    .swapExactInputSingle(amountIn, DAI, USDC, { gasLimit: 300000 });
  swapDAIToUSDC.wait();

  await getBalance(dai, usdc, busd);
  //await getApproval(dai, usdc, busd, binance, swapDAI);

  /* Execute the swap DAI to BUSD */
  /* console.log("\nswapping DAI to BUSD...");
  const amountIn = ethers.utils.parseUnits("10");
  const allowance = await busd
    .connect(binance)
    .allowance(BINANCE_ADDRESS, swapDAI.address);
  console.log("allowance:", allowance.toString()); */

  /*
   * Implement with Javascript calling UniswapV3Router directly
   */
  /* const swapRouter = new ethers.Contract(
    UniswapV3Router,
    SwapRouterABI.abi,
    binance
  );
  const params = {
    tokenIn: DAI,
    tokenOut: BUSD,
    fee: 3000,
    recipient: BINANCE_ADDRESS,
    deadline: Math.floor(Date.now() / 1000) + 600, // 600s, 10min
    amountIn: amountIn,
    amountOutMinimum: 0,
    sqrtPriceLimitX96: 0,
  };

  const amountOut = await swapRouter
    .connect(binance)
    .exactInputSingle(params, { gasLimit: 1000000 });
  amountOut.wait(); */
  /*
   * Implement with smart contracts
   */
  /* const swapBUSDToDAI = await swapDAI
    .connect(binance)
    .swapExactInputSingle(amountIn, DAI, BUSD, { gasLimit: 300000 });
  swapBUSDToDAI.wait();
  await getRevertReason(swapBUSDToDAI);

  await getBalance(dai, usdc, busd); */
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
