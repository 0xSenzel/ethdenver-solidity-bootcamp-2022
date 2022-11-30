'npx hardhat compile --force' running
Compiled 5 Solidity files successfully

Warning: Failure condition of 'send' ignored. Consider using 'transfer' instead.
--> contracts/DogCoinGame.sol:38:13:
|
38 | winners[i].send(\_amount);
| ^^^^^^^^^^^^^^^^^^^^^^^^

<p><span style="color:red" >
DogCoinGame.payWinners(uint256) (contracts/DogCoinGame.sol#36-40) sends eth to arbitrary user <br>
Dangerous calls: <br>
- winners[i].send(\_amount) (contracts/DogCoinGame.sol#38) <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#functions-that-send-ether-to-arbitrary-destinations
</span></p>

<p><span style="color:yellow" >
DogCoinGame.payout() (contracts/DogCoinGame.sol#29-34) uses a dangerous strict equality: <br>
- address(this).balance == 100 (contracts/DogCoinGame.sol#30) <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dangerous-strict-equalities
</span></p>

<p><span style="color:yellow">
DogCoinGame.payWinners(uint256) (contracts/DogCoinGame.sol#36-40) ignores return value by winners[i].send(\_amount) (contracts/DogCoinGame.sol#38) <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unchecked-send
</span></p>

<p><span style="color:green">
DogCoinGame.payWinners(uint256) (contracts/DogCoinGame.sol#36-40) has external calls inside a loop: winners[i].send(\_amount) (contracts/DogCoinGame.sol#38) <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation/#calls-inside-a-loop
</span></p>

<p><span style="color:green">
Different versions of Solidity are used: <br>
- Version used: ['^0.8.0', '^0.8.4'] - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#4) <br>
 - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol#4) <br>
 - ^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) - ^0.8.0 (node_modules/@openzeppelin/contracts/utils/Context.sol#4) <br>
 - ^0.8.4 (contracts/DogCoinGame.sol#2) <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
</span></p>

<p><span style="color:green">
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol#4) allows old versions <br>
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol#4) allows old versions <br>
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) allows old versions <br>
Pragma version^0.8.0 (node_modules/@openzeppelin/contracts/utils/Context.sol#4) allows old versions <br>
Pragma version^0.8.4 (contracts/DogCoinGame.sol#2) allows old versions <br>
solc-0.8.17 is not recommended for deployment <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
</span></p>

<p><span style="color:green">
Event DogCoinGamestartPayout() (contracts/DogCoinGame.sol#11) is not in CapWords <br>
Parameter DogCoinGame.addPlayer(address).\_player (contracts/DogCoinGame.sol#15) is
not in mixedCase <br>
Parameter DogCoinGame.addWinner(address).\_winner (contracts/DogCoinGame.sol#25) is not in mixedCase
not in mixedCase not in mixedCase <br>
Parameter DogCoinGame.payWinners(uint256).\_amount (contracts/DogCoinGame.sol#36) ise-to-solidity-naming-conventions not in mixedCase <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions ables-that-could-be-declared-constant
</span></p>

<p><span style="color:green">
DogCoinGame.currentPrize (contracts/DogCoinGame.sol#6) should be constant <br>
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variudit>ables-that-could-be-declared-constant
</span></p>
. analyzed (5 contracts with 81 detectors), 16 result(s) found
