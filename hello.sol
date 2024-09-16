// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {

address x = 0x212;
address myAddress = this;
if (x.balance < 10 && myAddress.balance >= 10) x.transfer(10);

}
