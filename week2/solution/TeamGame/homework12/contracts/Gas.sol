// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract GasContract is Ownable {
    uint8 constant tradePercent = 12;

    uint256 public constant totalSupply = 10000; // cannot be updated
    uint256 public paymentCounter;
    
    address public contractOwner;
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
        bool adminUpdated;
        string recipientName; // max 8 characters
        uint256 paymentID;
        address recipient;
        address admin; // administrators address
        uint256 amount;
    }

    struct History {
        uint256 lastUpdate;
        address updatedBy;
        uint256 blockNumber;
    }
    History[] public paymentHistory; // when a payment was updated
    
    struct ImportantStruct {
        uint256 valueA; // max 3 digits
        uint256 bigValue;
        uint256 valueB; // max 3 digits
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

    mapping(address => ImportantStruct) public whiteListStruct;
    mapping(address => uint256) public balances;
    mapping(address => bool) public isOddWhitelistUser;
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
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins) payable {
        contractOwner = msg.sender;

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

    function getPaymentHistory()
        external
        view
        returns (History[] memory paymentHistory_)
    {
        return paymentHistory;
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
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

    function addHistory(address _updateAddress, bool _tradeMode)
        public
        returns (bool status_, bool tradeMode_)
    {
        History memory history;
        history.blockNumber = block.number;
        history.lastUpdate = block.timestamp;
        history.updatedBy = _updateAddress;
        paymentHistory.push(history);

        return (true, _tradeMode);
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
        payment.admin = address(0);
        payment.adminUpdated = false;
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
    ) nonZeroAddress(_user) public onlyAdminOrOwner {
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
                payments[_user][ii].adminUpdated = true;
                payments[_user][ii].admin = _user;
                payments[_user][ii].paymentType = _type;
                payments[_user][ii].amount = _amount;
                bool tradingMode = getTradingMode();
                addHistory(_user, tradingMode);
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
        public
        onlyAdminOrOwner
    {
        require(
            _tier < 255 && _tier > 0,
            "Tier is more than 255"
        );

        whitelist[_userAddrs] = _tier;
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
        ImportantStruct memory _struct
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

        whiteListStruct[senderOfTx] = ImportantStruct(0, 0, 0);
        ImportantStruct storage newImportantStruct = whiteListStruct[
            senderOfTx
        ];
        newImportantStruct.valueA = _struct.valueA;
        newImportantStruct.bigValue = _struct.bigValue;
        newImportantStruct.valueB = _struct.valueB;
        emit WhiteListTransfer(_recipient);
    }
}
