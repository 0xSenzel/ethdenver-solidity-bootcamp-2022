# Solidity API

## ShameCoin

.Implementation of ERC20 token

_.Token that is design to be unwanted by users_

### _name

```solidity
string _name
```

### _symbol

```solidity
string _symbol
```

### _decimal

```solidity
uint8 _decimal
```

### owner

```solidity
address owner
```

### tokenSupply

```solidity
uint256 tokenSupply
```

### _balance

```solidity
mapping(address => uint256) _balance
```

### _allowances

```solidity
mapping(address => mapping(address => uint256)) _allowances
```

### constructor

```solidity
constructor() public
```

### decimal

```solidity
function decimal() public view returns (uint8)
```

.Get the decimal denomination of token supply

_.Returns fixed number_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint8 | uint8  . |

### name

```solidity
function name() public view returns (string)
```

.Get the name of the token

_.Return fixed text_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | string  . |

### symbol

```solidity
function symbol() public view returns (string)
```

.Get the symbol of the token

_.Returns fixed text_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | string  . |

### totalTokenSupply

```solidity
function totalTokenSupply() public view returns (uint256)
```

.Get the maximum supply of the token

_.Returns fixed number_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | uint256  . |

### balance

```solidity
function balance() public view returns (uint256)
```

. Get the balance of user calling this function

_.Returns number_

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | uint256  . |

### allowances

```solidity
function allowances(address spender) public view returns (uint256)
```

.Get the allowances of spender given by the user calling this function

_.Returns number_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | . Address approved through 'approve()' function to spend the token of user calling this function |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | uint256  . |

### transfer

```solidity
function transfer(address _from, address _to) public
```

. Any user other than owner of contract calling this function will receive a Shame Coin

_. Owner of the contract able to help user transfer Shame Coin if given allowances through 'approve()'
    . Owner of the contract able to send Shame Coin to any address but only by quantity of 1 per transaction_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _from | address | . Origin of address to send Shame Coin |
| _to | address | . Destination of address to receive Shame Coin |

### approve

```solidity
function approve(address spender, uint256 amount) public
```

. Give authority for any address to spend token on behalf of msg.sender by input amount

_. spender must not be zero address_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| spender | address | . Address given authority to spend msg.sender Shame Coin |
| amount | uint256 | . Number of token given authority to spender to transfer |

