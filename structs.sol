progma solidity ^0.8.13

contract Todos{
  struct  Todo{
    string text;
    bool completed;
  }
//an array of todo structs
 todo[] public todos
}
