# Team Game Solution
1. Starts by register our team's wallet in this [site](http://team-registration.javascrypt-.repl.co/)

Was left with no instruction now other than find for the "hint" so we figured to look into transaction history of this [team registration contract](https://goerli.etherscan.io/address/0x2410637d1302a87fca0ca71f6aeea3627a50071b) and found a hint was inside one of the [transaction](https://goerli.etherscan.io/tx/0x95d0258402e0a0e71dc73e64bf122900243cd512a14c19a5bed5b3c10806e47b).

2. Found this link : https://bit.ly/3eZ9oVm by viewing as UTF-8

Unable to open the link but once posted on chat box it had a preview that shows "68747470733A2F2F6269742E6C792F334E3674377953" (probably its metadata?)

3. Convert the hex found and convert to string we get: https://bit.ly/3N6t7yS 

The link directed us to a tweet which gives us: 1110011101010000000100111000101001011101011011010010110000110111100000101111110101010010000101100001101111101100101111110001110111000100011110101111101111110000100110100011100110001010000001100001111111010010010000100100001100110000101010101010110101011001

4. Convert the binary to hex we get: E750138A5D6D2C3782FD52161BECBF1DC47AFBF09A398A061FD2424330AAAD59

Looks very similar to transaction hash...

5. Adding "0x" to our findings, search at goerli testnet we found this [transaction hash](https://goerli.etherscan.io/tx/0xE750138A5D6D2C3782FD52161BECBF1DC47AFBF09A398A061FD2424330AAAD59)

The transaction hash had another input data after viewing as UTF-8 we get: https://bit.ly/3W33bIi. It leads us to a site that ask us to inspect.

6. Inspect website, we get: https://bit.ly/3ze0V7s which is another tweet that gives us [0x18acF9DEB7F9535F4848a286b68C729AAc55697a](https://goerli.etherscan.io/address/0x18acF9DEB7F9535F4848a286b68C729AAc55697a). Finally this is the treasure contract!

7. Deploy [TreasureInterface.sol](./TreasureInterface.sol) and interact with the contract found then we're done!
