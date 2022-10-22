// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint256 totalSupply = 10000;

    address payable owner;

    struct Payment {
        uint256 amount;
        address recipient;
    }

    mapping(address => uint256) balances;
    mapping(address => Payment[]) paymentDetails;

    event TokenSupplyChange(uint256);
    event TokenTransferred(address, uint256);

    modifier onlyOwner() {
        if(msg.sender == owner) {
            _;
        }
    }

    constructor() {
        owner = payable(msg.sender);
        balances[owner] = totalSupply;
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

        paymentDetails[msg.sender].push(Payment(_amount, to));

        emit TokenTransferred(to, _amount);
    }

    function getPaymentDetails(address _sender) public view returns(Payment[] memory) {
        return paymentDetails[_sender];
    }
}