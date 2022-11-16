// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";

/**
 * @author  . 0xsenzel
 * @title   . ShameCoin
 * @dev     . All functions calls are currently implemented without side effects
 * @notice  . You can use this contract to deploy a shamecoin
 */

contract ShameCoin {
    address public owner;

    mapping(address => uint256) public balances;
    mapping(address => bool) approved;
    constructor(address _owner) {
        owner = _owner;
    }

    /**
     * @notice  . Transfer shamecoin by owner to address 'to', and amount 1 by 'user' if they approve
     * @dev     .
     * @param   user  . address that approve owner to transfer 1 of their shamecoin
     * @param   to  . address which to increase balance of shamecoin
     */
    function transfer(address user, address to) public {
        if(msg.sender == owner && user == address(0) && to != address(0)) {
            balances[to] += 1;    
               
        } else if(msg.sender == owner && user != address(0) && to == address(0)) {
            require(approved[msg.sender] == true);
            balances[user] -= 1;
            balances[to] += 1;
            approved[user] = false;

        } else if(msg.sender != owner) {
            balances[msg.sender] += 1;
        }
    }

    /**
     * @notice  . Approve by user to let owner spend 1 of their shamecoin
     * @dev     .
     */
    function approve() public {
        require(msg.sender != owner);
        approved[msg.sender] = true;
    }
}
