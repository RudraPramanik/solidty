pragma solidity ^0.8.0;

contract Test {
    // First overloaded function: Takes two uint parameters
    function getSum(uint a, uint b) public pure returns (uint) {      
        return a + b;
    }

    // Second overloaded function: Takes three uint parameters
    function getSum(uint a, uint b, uint c) public pure returns (uint) {      
        return a + b + c;
    }

    // Calls the first getSum function with two arguments
    function callSumWithTwoArguments() public pure returns (uint) {
        return getSum(1, 2);
    }

    // Calls the second getSum function with three arguments
    function callSumWithThreeArguments() public pure returns (uint) {
        return getSum(1, 2, 3);
    }
}
