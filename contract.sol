// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleToken
 * @dev Basic ERC20 Token example, with mintable and burnable token creation, and owner management.
 */
contract SimpleToken {
    // Token metadata
    string public name = "SimpleToken";
    string public symbol = "SIM";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // Owner of the contract
    address public owner;

    // Mapping from account addresses to current balance
    mapping(address => uint256) private balances;

    // Mapping of allowances
    mapping(address => mapping(address => uint256)) private allowances;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Modifier to restrict functions to the contract owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    /**
     * @dev Sets the values for {name}, {symbol}, initializes {decimals} with
     * a default value of 18, and mints the initial supply to the deployer.
     */
    constructor(uint256 initialSupply) {
        owner = msg.sender;
        mint(owner, initialSupply);
        emit OwnershipTransferred(address(0), owner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    /**
     * @dev Returns the balance of a specific address.
     * @param account The address to query the balance of.
     * @return An uint256 representing the amount owned by the passed address.
     */
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    /**
     * @dev Transfer token for a specified address.
     * @param recipient The address to transfer to.
     * @param amount The amount to be transferred.
     * @return A boolean that indicates if the operation was successful.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Perform transfer
        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     * @param spender The address which will spend the funds.
     * @param amount The amount of tokens to be spent.
     * @return A boolean that indicates if the operation was successful.
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Approve to the zero address");

        allowances[msg.sender][spender] = amount;

        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev Returns the amount which spender is still allowed to withdraw from owner.
     * @param owner_ The address which owns the funds.
     * @param spender The address which will spend the funds.
     * @return A uint256 specifying the amount of tokens still available for the spender.
     */
    function allowance(address owner_, address spender) public view returns (uint256) {
        return allowances[owner_][spender];
    }

    /**
     * @dev Transfer tokens from one address to another.
     * @param sender The address which you want to send tokens from.
     * @param recipient The address which you want to transfer to.
     * @param amount The amount of tokens to be transferred.
     * @return A boolean that indicates if the operation was successful.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(balances[sender] >= amount, "Insufficient balance of sender");
        require(allowances[sender][msg.sender] >= amount, "Allowance exceeded");

        // Perform transfer
        balances[sender] -= amount;
        balances[recipient] += amount;

        // Adjust allowance
        allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    /**
     * @dev Mint new tokens and add them to the total supply and the balance of the receiver.
     * Can only be called by the owner.
     * @param account The address that will receive the minted tokens.
     * @param amount The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address account, uint256 amount) public onlyOwner returns (bool) {
        require(account != address(0), "Mint to the zero address");

        totalSupply += amount;
        balances[account] += amount;

        emit Transfer(address(0), account, amount);
        return true;
    }

    /**
     * @dev Burn tokens and subtract them from the total supply and the balance of the account.
     * Can only be called by the owner.
     * @param account The address whose tokens will be burned.
     * @param amount The amount of tokens to burn.
     * @return A boolean that indicates if the operation was successful.
     */
    function burn(address account, uint256 amount) public onlyOwner returns (bool) {
        require(account != address(0), "Burn from the zero address");
        require(balances[account] >= amount, "Insufficient balance to burn");

        balances[account] -= amount;
        totalSupply -= amount;

        emit Transfer(account, address(0), amount);
        return true;
    }
}
