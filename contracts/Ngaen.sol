// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// =======================
// Error
// =======================
error InvalidSpendingAmount();
error InvalidSpenderAddress();
error InvalidReceiverAddress();
error TransferAmountExceedsBalance();
error Overflows();


// =======================
// Interface
// =======================
interface tokenRecipient {
    function receiveApproval(
        address _from,
        uint256 _amount,
        address _token,
        bytes calldata _extraData
    ) external;
}

/**
 * Contract 
 */
contract Ngaen {
    
    // =======================
    // Token public variables
    // =======================
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    
    
    // =======================
    // Arrays with all balances
    // =======================
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping(address => uint256)) public allowance;
    
    
    // =======================
    // Events
    // =======================
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 value
    );
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _amount
    );
    event Burn(address indexed from, uint256 value);
    
    // =======================
    // Constructor 
    // =======================
    constructor(
        uint256 initialSupply,
        string memory tokenName,
        string memory tokenSymbol
    ) {
        // Have the total supply in decimal amount
        totalSupply = initialSupply * 10**uint256(decimals);
        // The creator owns all initial supply 
        balanceOf[msg.sender] = totalSupply;
        // Set the token name and symbol
        name = tokenName;
        symbol = tokenSymbol;
    }
    
    // =======================
    // Main functions
    // =======================

    /**
     * Transfer tokens 
     * 
     * Send `_amount` tokens to `_to` from your account
     * 
     * @param _to The adrress of the recipient
     * @param _amount the amount to send
     */ 
    function transfer(
        address _to, 
        uint256 _amount
    ) public returns (bool success) {
        _transfer(msg.sender, _to, _amount);
        return true;
    }
    
        
    /**
     * Transfer tokens from other address
     * 
     * Send `_amount` tokens to `_to` on behalf of `_from`
     * 
     * @param _from The address of the sender
     * @param _to The adrress of the recipient
     * @param _amount the amount to send
     */ 
    function transferFrom(
        address _from, 
        address _to, 
        uint256 _amount
    ) public returns (bool success) {
        if (_amount > allowance[_from][msg.sender]) {
            revert InvalidSpendingAmount();
        }
        allowance[_from][msg.sender] -= _amount;
        _transfer(_from, _to, _amount);
        return true;
    }
    
    /**
     * Internal transfer
     */
    function _transfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal {
        if (_from == address(0x0)) {
            revert InvalidSpenderAddress();
        }
        if (_to == address(0x0)) {
            revert InvalidReceiverAddress();
        }
        if (balanceOf[_from] < _amount) {
            revert TransferAmountExceedsBalance();
        }
        if (balanceOf[_to] + _amount < balanceOf[_to]) {
            revert Overflows();
        }
        uint256 prevBalances = balanceOf[_from] + balanceOf[_to];
        
        // Update accounts' balances
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
        
        emit Transfer(_from, _to, _amount);
        
        // For static analysis testing purpose
        assert(balanceOf[_from] + balanceOf[_to] == prevBalances);
    }
}