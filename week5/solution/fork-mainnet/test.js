const { ethers } = require("ethers");
const axios = require("axios");

async function main() {
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY)
    const connectedWallet = wallet.connect(provider)
    
}