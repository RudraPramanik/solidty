
pragma solidity ^0.8.0;


contract fallback{
  event log(string func, uint gas)

//fallback fn must be  declared as external
  fallback() external payable{
//send/transfer 2300 ether atleast
   emit Log("recieve", gasleft())
  }

// recieve a varient of fall back wich trigger msg.call
recieve() external payable{
emit log("recieve", gasleft())
}

//helper fun to check the balance of the contract
function getBalance() public view returns(uint){
 return address(this).balance;
}
contract SendToFallback{
function transferToFallback(address payable _to) public payable{
_to.transfer(msg.value)
}
}
}
