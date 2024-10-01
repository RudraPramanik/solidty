pragma solidity ^0.8.0;

contract Test {
    address payable public richest;
    uint public mostSent;

    event NewRichest(address indexed user, uint amount);

    constructor() payable {
        require(msg.value > 0, "Initial Ether required");
        richest = payable(msg.sender);
        mostSent = msg.value;
    }

    function becomeRichest() public payable returns (bool) {
        require(msg.value > mostSent, "Need to send more Ether to become the richest");

        address payable previousRichest = richest;
        uint previousMostSent = mostSent;

        richest = payable(msg.sender);
        mostSent = msg.value;

        // Transfer Ether to previous richest user
        (bool success, ) = previousRichest.call{value: previousMostSent}("");
        require(success, "Transfer to previous richest failed");

        emit NewRichest(msg.sender, msg.value);

        return true;
    }
}
