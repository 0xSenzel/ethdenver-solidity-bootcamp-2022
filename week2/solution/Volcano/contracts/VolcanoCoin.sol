// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract VolcanoCoin is Ownable {
    uint256 totalSupply = 10000;

    struct Payment {
        uint256 amount;
        address recipient;
    }
    //Payment[] payment;

    mapping(address => uint256) balances;
    mapping(address => Payment[]) paymentDetails;

    event TokenSupplyChange(uint256);
    event TokenTransferred(address, uint256);

    constructor() {
        balances[owner()] = totalSupply;
    }

    function getTotalSupply() public view returns(uint256) {
        return totalSupply;
    }

    function addSupply() public onlyOwner {
        totalSupply += 1000;
        emit TokenSupplyChange(totalSupply);
    }

    function getBalance(address user) external view returns(uint256) {
        return balances[user];
    }

    function _transfer(address payable to, uint256 _amount) external payable {
        require(balances[msg.sender] >= _amount, "Amount send is more than you own!");
        require(_amount > 0, "Amount send must not less than 0!");
        require(to != address(0), "Please enter a valid address!");

        uint256 fromBalance = balances[payable(msg.sender)];
        balances[msg.sender] -= _amount;

        require(fromBalance - balances[msg.sender] <= _amount, "Sender amount hasn't been deducted!");
        balances[to] += _amount;      

        //paymentDetails[msg.sender].push(Payment(_amount, to));
        recordPayment(msg.sender, to, _amount);

        emit TokenTransferred(to, _amount);
    }

    function _transferFrom(address from, address to, uint256 amount) public {
        require(balances[from] >= amount, "Amount send is more than you own!");
        require(amount > 0, "Amount send must not less than 0!");
        require(to != address(0), "Please enter a valid address!");
        
        uint256 fromBalance = balances[from];
        balances[from] -= amount;

        require(fromBalance - balances[from] <= amount, "Sender amount hasn't been deducted!");
        balances[to] += amount;  

        recordPayment(from, to, amount);
        emit TokenTransferred(to, amount);
    }

    function recordPayment(address _sender, address receiver, uint256 amount) internal {
        paymentDetails[_sender].push(Payment(amount, receiver));
    }
}