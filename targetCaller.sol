// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Target {
    // Event to log the function call
    event Received( address caller, uint amount, string message );

    // Public state variable to store the last caller's address
    address public lastCaller;

    // Function that will be called by another contract

    function recordCaller( string calldata message ) external  payable {
        lastCaller = msg.sender;
        emit Received(msg.sender, msg.value, message);
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
