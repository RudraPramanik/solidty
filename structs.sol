pragma solidity ^0.8.0;

contract Todos{
  struct  Todo{
    string text;
    bool completed;
  }
//an array of todo structs
 todo[] public todos
 //create a fn that allow to create todo list
function create( string colldata _text ) public{
 //3 ways to initialize a struct
//- calling it like a function
todos.push(Todo(_text, false));
}
//key value mapping
function get(uint _index) public view returns (string memory text, bool completed ){
    Todo storage todo = todos[_index];
    return (todo.text, todo.completed)

 }
 function toggleCompleted(uint _index) public {
    Todo storage todo =  todos[_index]
    Todo.completed = !Todo.completed
 }

}
