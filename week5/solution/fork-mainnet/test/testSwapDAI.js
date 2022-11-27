const { expect } = require("chai");
const { ethers } = require("hardhat");
const IERC20Minimal = require("@uniswap/v3-core/artifacts/contracts/interfaces/IERC20Minimal.sol/IERC20Minimal.json");

describe("Testing Swap Dai...", function () {
  const UniswapV3Router = "0xE592427A0AEce92De3Edee1F18E0157C05861564";
  const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
  const USDC = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
  const BUSD = "0x4Fabb145d64652a948d72533023f6E7A623C7C53";
  const BINANCE_ADDRESS = "0xDFd5293D8e347dFe59E90eFd55b2956a1343963d";
  const POOL_FEE_500 = 500;
  const POOL_FEE_3000 = 3000;

  let swapDAIFactory,
    swapDAI,
    binance,
    dai,
    usdc,
    busd,
    binanceBUSDBalance,
    binanceDAIBalance,
    binanceUSDCBalance;

  beforeEach(async () => {
    // Deploy contract
    swapDAIFactory = await ethers.getContractFactory("SwapDAI");
    swapDAI = await swapDAIFactory.deploy(UniswapV3Router);
    await swapDAI.deployed();
    // Impersonate binance
    binance = await ethers.getImpersonatedSigner(BINANCE_ADDRESS);
    // Connect to all tokens
    dai = new ethers.Contract(DAI, IERC20Minimal.abi, binance);
    usdc = new ethers.Contract(USDC, IERC20Minimal.abi, binance);
    busd = new ethers.Contract(BUSD, IERC20Minimal.abi, binance);
    // Get Binance's token balance
    binanceDAIBalance = await dai.balanceOf(BINANCE_ADDRESS);
    binanceUSDCBalance = await usdc.balanceOf(BINANCE_ADDRESS);
    binanceBUSDBalance = await busd.balanceOf(BINANCE_ADDRESS);
    // Approve all tokens
    await dai.connect(binance).approve(swapDAI.address, binanceDAIBalance);
    await usdc.connect(binance).approve(swapDAI.address, binanceUSDCBalance);
    await busd.connect(binance).approve(swapDAI.address, binanceBUSDBalance);
  });

  it("Should increase Binance's USDC balance and decrease DAI balance", async function () {
    const amountIn = ethers.utils.parseUnits("10", 18);
    const swapDAIToUSDC = await swapDAI
      .connect(binance)
      .swapExactInputSingle(amountIn, DAI, USDC, POOL_FEE_3000, {
        gasLimit: 300000,
      });
    swapDAIToUSDC.wait();

    expect(await dai.balanceOf(BINANCE_ADDRESS)).to.equal(
      binanceDAIBalance.sub(amountIn)
    );
    expect(await usdc.balanceOf(BINANCE_ADDRESS)).to.gt(binanceUSDCBalance);
  });

  it("Should increase Binance's BUSD balance and decrease DAI balance", async function () {
    const amountIn = ethers.utils.parseUnits("10", 18);
    const swapDAIToBUSD = await swapDAI
      .connect(binance)
      .swapExactInputSingle(amountIn, DAI, BUSD, POOL_FEE_500, {
        gasLimit: 300000,
      });
    swapDAIToBUSD.wait();

    expect(await dai.balanceOf(BINANCE_ADDRESS)).to.equal(
      binanceDAIBalance.sub(amountIn)
    );
    expect(await busd.balanceOf(BINANCE_ADDRESS)).to.gt(binanceBUSDBalance);
  });
});
