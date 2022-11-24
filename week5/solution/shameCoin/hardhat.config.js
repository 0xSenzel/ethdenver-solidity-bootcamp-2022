require("@nomicfoundation/hardhat-toolbox");
require("solidity-docgen"); // `npx hardhat docgen` to generate documentation
require("@nomicfoundation/hardhat-chai-matchers");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.7.6",
      },
      {
        version: "0.6.0",
      },
      {
        version: "0.7.0",
      },
    ],
  },
};
