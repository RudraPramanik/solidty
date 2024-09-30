//  special function available to a contract
//  It is called when a non-existent function is called on the contract.
//  It is required to be marked external.
//  It has no name.
//  It has no arguments
//  It can not return any thing.
//  It can be defined one per contract.

pragma solidity ^0.8.0;

contract Test {
   uint public x ;
   function() external { x = 1; }    
}

contract Sink {
   function() external payable { }
}
contract Caller {
   function callTest(Test test) public returns (bool) {
      (bool success,) = address(test).call(abi.encodeWithSignature("nonExistingFunction()"));
      require(success);
      // test.x is now 1

      address payable testPayable = address(uint160(address(test)));

      // Sending ether to Test contract,
      // the transfer will fail, i.e. this returns false here.
      return (testPayable.send(2 ether));
   }
   function callSink(Sink sink) public returns (bool) {
      address payable sinkPayable = address(sink);
      return (sinkPayable.send(2 ether));
   }
}