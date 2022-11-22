// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @author  .Senzel
 * @title   .Shame Coin
 * @dev     .Token that is design to be unwanted by users
 * @notice  .Implementation of ERC20 token 
 */
contract ShameCoin {
    string private _name;
    string private _symbol;
    uint8 private _decimal;
    address public owner;
    uint256 tokenSupply = 10000;

    mapping(address => uint256) private _balance;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() {
        _name = "SHAMECOIN";
        _symbol = "SHAME";
        owner = msg.sender;
        _balance[owner] = tokenSupply * 10 ** _decimal;
    }

    /**
     * @notice  .Get the decimal denomination of token supply
     * @dev     .Returns fixed number
     * @return  uint8  .
     */
    function decimal() public view returns (uint8) {
        return _decimal;
    }

    /**
     * @notice  .Get the name of the token
     * @dev     .Return fixed text
     * @return  string  .
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @notice  .Get the symbol of the token
     * @dev     .Returns fixed text
     * @return  string  .
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @notice  .Get the maximum supply of the token
     * @dev     .Returns fixed number
     * @return  uint256  .
     */
    function totalTokenSupply() public view returns (uint256) {
        return tokenSupply;
    }

    /**
     * @notice  . Get the balance of user calling this function
     * @dev     .Returns number
     * @return  uint256  .
     */
    function balance() public view returns (uint256) {
        return _balance[msg.sender];
    }

    /**
     * @notice  .Get the allowances of spender given by the user calling this function
     * @dev     .Returns number
     * @param   spender  . Address approved through 'approve()' function to spend the token of user calling this function 
     * @return  uint256  .
     */
    function allowances(address spender) public view returns (uint256) {
        return _allowances[msg.sender][spender];
    }

    /**
     * @notice  . Any user other than owner of contract calling this function will receive a Shame Coin
     * @dev     . Owner of the contract able to help user transfer Shame Coin if given allowances through 'approve()'
     * @dev     . Owner of the contract able to send Shame Coin to any address but only by quantity of 1 per transaction
     * @param   _from  . Origin of address to send Shame Coin
     * @param   _to  . Destination of address to receive Shame Coin
     */
    function transfer(address _from, address _to) public {
        require(_from != address(0), "Transfer from zero address");
        require(_to != address(0), "Transfer to zero address");

        if(msg.sender == owner) {
            if(_allowances[_from][owner] > 0) {
                _balance[owner] -= 1;
                _balance[_from] -= 1;
                _allowances[_from][owner] -= 1;

                _balance[_to] += 1;
            }
            _balance[owner] -= 1;

            _balance[_to] += 1;
            
        } else if(msg.sender != owner) {
            _balance[owner] -= 1;

            _balance[msg.sender] += 1; 
        }
    }

    /**
     * @notice  . Give authority for any address to spend token on behalf of msg.sender by input amount
     * @dev     . spender must not be zero address
     * @param   spender  . Address given authority to spend msg.sender Shame Coin
     * @param   amount  . Number of token given authority to spender to transfer
     */
    function approve(address spender, uint256 amount) public {
        require(spender != address(0), "Approve to the zero address");

        _allowances[msg.sender][spender] = amount;
    }
}