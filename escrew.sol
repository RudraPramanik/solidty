pragma solidity >=0.8.2 <0.9.0;

contract Escrow {
    address public buyer;
    address payable public seller;
    address public arbiter;
    uint public amount;

    enum State { AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED }
    State public currentState;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this function.");
        _;
    }

    modifier onlyArbiter() {
        require(msg.sender == arbiter, "Only arbiter can call this function.");
        _;
    }

    modifier inState(State expectedState) {
        require(currentState == expectedState, "Invalid state.");
        _;
    }

    constructor(address _buyer, address payable _seller, address _arbiter) {
        buyer = _buyer;
        seller = _seller;
        arbiter = _arbiter;
        currentState = State.AWAITING_PAYMENT;
    }

    function deposit() external payable onlyBuyer inState(State.AWAITING_PAYMENT) {
        require(msg.value > 0, "Must deposit a valid amount.");
        amount = msg.value;
        currentState = State.AWAITING_DELIVERY;
    }

    function confirmDelivery() external onlyBuyer inState(State.AWAITING_DELIVERY) {
        seller.transfer(amount);
        currentState = State.COMPLETE;
    }

    function refundBuyer() external onlyArbiter inState(State.AWAITING_DELIVERY) {
        payable(buyer).transfer(amount);
        currentState = State.REFUNDED;
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
