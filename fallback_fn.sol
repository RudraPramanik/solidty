pragma solidity ^0.8.0;

contract Test {
    uint public x;

    fallback() external {
        x = 1;
    }
}

contract Sink {
    fallback() external payable {
        // Can receive Ether
    }
}

contract Caller {
    function callTest(Test test) public returns (bool) {
        (bool success, ) = address(test).call(abi.encodeWithSignature("nonExistingFunction()"));
        require(success, "Call to Test contract failed");
        // test.x is now 1

        address payable testPayable = payable(address(test));

        // Attempt to send Ether to Test contract (will fail)
        return testPayable.send(2 ether);
    }

    function callSink(Sink sink) public returns (bool) {
        address payable sinkPayable = payable(address(sink));
        // Send Ether to Sink contract (will succeed)
        return sinkPayable.send(2 ether);
    }
}
