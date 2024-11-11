// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback {
    // Event to log fallback and receive calls
    event Log(string func, uint gas);

    // Fallback function, called when the contract receives Ether without matching function selector
    fallback() external payable {
        emit Log("fallback", gasleft());
    }

    // Receive function, called when the contract receives Ether without data
    receive() external payable {
        emit Log("receive", gasleft());
    }

    // Helper function to check the contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    // Transfer method: sends Ether to an address using transfer (limited to 2300 gas)
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    // Send method: sends Ether to an address using send (limited to 2300 gas)
    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    // Call method: sends Ether to an address using call (forwards all available gas)
    function sendViaCall(address payable _to) public payable {
        // Call returns a success/failure flag and any returned data
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
