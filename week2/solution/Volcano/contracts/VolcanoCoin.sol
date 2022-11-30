// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/Arachnid/solidity-stringutils/blob/master/src/strings.sol";

contract VolcanoCoin is Ownable {
    using strings for *;

    uint8 decimal;
    uint256 totalSupply;
    uint256 mintableSupply;
    uint256 immutable PRICE= 0.001 ether;

    string private _name;
    string private _symbol;

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
        _name = "VolcanoCoin";
        _symbol = "VOL";
        totalSupply = 10000;
        mintableSupply = 10000;
    }

    function getTotalSupply() external view returns(uint256) {
        return totalSupply;
    }

    function name() external view returns(string memory) {
        return _name;
    }

    function symbol() external view returns(string memory) {
        return _symbol;
    }

    function addSupply() external onlyOwner {
        totalSupply += 1000;
        mintableSupply +=1000;

        emit TokenSupplyChange(totalSupply);
    }

    function getBalance(address user) external view returns(uint256) {
        return balances[user];
    }

    function mint(uint256 amount) external payable {
        require(totalSupply - amount > 0, "Reached Max Supply");
        require(mintableSupply >= amount, "Lower mint amount");
        uint256 cost = PRICE * amount;
        (bool sent,) = payable(msg.sender).call{value: cost}("");
        require(sent, "Failed to send Ether");

        mintableSupply -= amount;
        balances[msg.sender] += amount;

        emit TokenTransferred(msg.sender, amount);
    }

    function transfer(address to, uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "Amount send is more than you own!");
        require(_amount > 0, "Amount send must not less than 0!");
        require(to != address(0), "Please enter a valid address!");

        uint256 fromBalance = balances[msg.sender];
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

    function interactWithStringUtils(string memory words) external pure returns (string memory) {
        string memory output = words.toSlice().concat(" - From ETH Denver".toSlice());
        return output;
    }
}