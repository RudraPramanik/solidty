pragma solidity ^0.8.0;

contract Test{
    function getResult() public view returns(uint product , uint sum) {
        uint a = 2;
        uint b = 5;
        product = a* b;
        sum = a+b
    }
}