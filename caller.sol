// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Caller {
    // Function to call a function in the Target contract using .call
    function callRecordCaller(address targetAddress, string memory message) public payable {
        // Encoding the function call with its argument
        bytes memory data = abi.encodeWithSignature("recordCaller(string)", message);
        
        // Using .call to send Ether and data to the target contract
        (bool success, bytes memory returnData) = targetAddress.call{value: msg.value}(data);
        
        // Revert if the call fails
        require(success, "Call to Target contract failed");
    }
}
