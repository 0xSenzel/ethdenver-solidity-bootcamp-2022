// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    uint256 number;

    address owner;

    constructor() {
        owner = msg.sender;
    }

    function getAddress() external view returns(address) {
        address addy = 0x000000000000000000000000000000000000dEaD;
        
        if(msg.sender == owner) {
            return addy;
        } else {
            return owner;
        }
    }

    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }
}