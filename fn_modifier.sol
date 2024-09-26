pragma solidity ^0.8.0;

contract Owner {
    address owner;
   modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }
   modifier costs(uint price) {
      if (msg.value >= price) {
         _;
      }
   }
}

contract Register is Owner{
    mapping (address => bool) registeredAddressses;
    uint price;
    constructor( uint initialPrice ) public {price = initialPrice}

    function Register() public payable costs(price){
        registeredAddressses[msg.sender] = true;
    }
    function changePrice(uint _price) public onlyOwner{
        price = _price
    }
}