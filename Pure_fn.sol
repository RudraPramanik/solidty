pragma solidity ^0.8.0;
// function that not modify the state

contract pureFn{
    function PureTest() public view returns( uint sum, uint result ) {
        uint a = 8;
        uint b = 10;
        sum = a+b;
        result = a*b;
    }
}