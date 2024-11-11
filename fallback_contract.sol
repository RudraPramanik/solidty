// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback {
    // Event to log fallback and receive calls
    event Log(string func, uint gas);

    // Fallback function: called when Ether is sent without data
    fallback() external payable {
        emit Log("fallback", gasleft());
    }

    // Receive function: called when Ether is sent with no data and no matching function
    receive() external payable {
        emit Log("receive", gasleft());
    }

    // Helper function to check the balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    // Transfer method: sends Ether using .transfer, which has a fixed gas limit of 2300
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    // Send method: sends Ether using .send, which has a fixed gas limit of 2300 and returns a success/failure flag
    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    // Call method: sends Ether using .call, which forwards all available gas and is the most flexible option
    function sendViaCall(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
