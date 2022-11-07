// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract GasContract { //2199473
    uint256 public immutable totalSupply; // cannot be updated
    uint256 public paymentCounter;
    
    address public immutable contractOwner;
    address[5] public administrators;
    
    enum PaymentType {
        Unknown,
        BasicPayment,
        Refund,
        Dividend,
        GroupPayment
    }
    PaymentType constant defaultPayment = PaymentType.Unknown;

    struct Payment {
        PaymentType paymentType;
        string recipientName; // max 8 characters
        uint256 paymentID;
        address recipient;
        uint256 amount;
    }

    modifier onlyAdminOrOwner() {
        if (checkForAdmin(msg.sender)) {
            _;
        } else {
            revert(
                "Must be admin or owner"
            );
        }
    }

    modifier nonZeroAddress(address user) {
        require(user != address(0), "Must be a valid address!");
        _;
    }

    mapping(address => uint256) public balances;
    mapping(address => Payment[]) public payments;
    mapping(address => uint256) public whitelist;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event supplyChanged(address indexed, uint256 indexed);
    event Transfer(address recipient, uint256 amount);
    event PaymentUpdated(
        address admin,
        uint256 ID,
        uint256 amount,
        string recipient
    );
    event WhiteListTransfer(address indexed recipient, uint256 indexed amount);
    event paymentHistory(uint256 indexed lastUpdate, address indexed updatedBy, uint256 indexed blockNumber);

    constructor(address[5] memory _admins, uint256 _totalSupply) payable {
        contractOwner = msg.sender;
        totalSupply = _totalSupply;

        for (uint ii; ii < 5;) {
            if (_admins[ii] != address(0)) {
                administrators[ii] = _admins[ii];
                if (_admins[ii] == contractOwner) {
                    balances[contractOwner] = totalSupply;
                    emit supplyChanged(_admins[ii], totalSupply);
                } else {
                    balances[_admins[ii]] = 0;
                    emit supplyChanged(_admins[ii], 0);
                }
            }
            unchecked { ++ii; }
        }
    }

    function checkForAdmin(address _user) internal view returns (bool admin_) {
        bool admin = false;
        for (uint256 ii = 0; ii < 5;) {
            if (administrators[ii] == _user) {
                admin = true;
            }
            unchecked { ++ii; }
        }
        return admin;
    }

    function balanceOf(address _user) external view returns (uint256 balance_) {
        uint256 balance = balances[_user];
        return balance;
    }

    function getTradingMode() public pure returns (bool) {
        return true;
    }

    function getPayments(address _user)
        nonZeroAddress(_user)
        external
        view
        returns (Payment[] memory payments_)
    {
        return payments[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public returns (bool status_) {
        address senderOfTx = msg.sender;
        require(
            balances[senderOfTx] >= _amount,
            "Sender has insufficient Balance"
        );
        require(
            bytes(_name).length < 9,
            "Length is more than 8 character"
        );
        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;
        emit Transfer(_recipient, _amount);

        Payment memory payment;
        payment.paymentType = PaymentType.BasicPayment;
        payment.recipient = _recipient;
        payment.amount = _amount;
        payment.recipientName = _name;
        payment.paymentID = ++paymentCounter;
        payments[senderOfTx].push(payment);
 
        return (true);
    }

    function updatePayment(
        address _user,
        uint256 _ID,
        uint256 _amount,
        PaymentType _type
    ) nonZeroAddress(_user) external onlyAdminOrOwner {
        require(
            _ID > 0,
            "ID must be greater than 0"
        );
        require(
            _amount > 0,
            "Amount must be greater than 0"
        );

        address senderOfTx = msg.sender;
        
        for (uint ii; ii < payments[_user].length;) {
            if (payments[_user][ii].paymentID == _ID) {
                payments[_user][ii].paymentType = _type;
                payments[_user][ii].amount = _amount;
                emit paymentHistory(block.timestamp, _user, block.number);
                emit PaymentUpdated(
                    senderOfTx,
                    _ID,
                    _amount,
                    payments[_user][ii].recipientName
                );
            }
            unchecked { ++ii; }    
        }
    }

    function addToWhitelist(address _userAddrs, uint256 _tier)
        external
        onlyAdminOrOwner
    {
        require(
            _tier < 255 && _tier > 0,
            "Tier is more than 255"
        );

        if (_tier > 3) {
            whitelist[_userAddrs] = 3;
        } else {
            whitelist[_userAddrs] = _tier;
        } 

        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount,
        uint256[3] calldata
    ) public {
        address senderOfTx = msg.sender;
        require(
            balances[senderOfTx] >= _amount,
            "Sender has insufficient Balance"
        );
        require(
            _amount > 3,
            "Amount  have to be bigger than 3"
        );

        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;
        balances[senderOfTx] += whitelist[senderOfTx];
        balances[_recipient] -= whitelist[senderOfTx];

        emit WhiteListTransfer(_recipient, _amount);
    }
}
