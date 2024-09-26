pragma solidity ^0.8.0;

contract Owner {
    address public owner;

    constructor() {
        owner = msg.sender; // Initialize the owner
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier costs(uint price) {
        require(msg.value >= price, "Insufficient funds sent");
        _;
    }
}

contract Register is Owner {
    mapping(address => bool) public registeredAddresses;
    uint public price;

    constructor(uint initialPrice) {
        price = initialPrice;
    }

    function register() public payable costs(price) {
        registeredAddresses[msg.sender] = true;
    }

    function changePrice(uint _price) public onlyOwner {
        price = _price;
    }
}
