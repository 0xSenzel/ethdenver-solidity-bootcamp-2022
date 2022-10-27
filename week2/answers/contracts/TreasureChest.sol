// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

/* 
Congratulations you have found the Treasure Chest contract.
You now need to make an interface contract to interact with the 
getTreasure method in this contract. Please look at the gist given 
during lesson for an example of an interface.
*/

interface ITeamRegistration {
	function registeredList(address) external view returns (bool);
}

contract TreasureChest {

    address immutable _owner;
    address TeamRegistrationContract;

	event InterfaceAddressedSet();
    event TreasureClaimed(address indexed, uint256 indexed, string indexed);
    
    modifier onlyAdmin() {
		require(msg.sender == _owner, "Not owner");
		_;
	}
    constructor() {
        _owner = msg.sender;
    }

    function setInterfaceAddress(address _address) external onlyAdmin {
        TeamRegistrationContract = _address;
		emit InterfaceAddressedSet();
    }

    function GetTreasure(address sender) external {
		require(ITeamRegistration(TeamRegistrationContract).registeredList(sender), "EOA is not registered!");
        emit TreasureClaimed(msg.sender, block.timestamp, "Well done!!");
    }
}