progma solidity ^0.8.13

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
//key value mapping
todos.push(Todo({text:_text, completed:false}))
//initialize an empty struct and then update it
todo memory todo;
todo.text = _textl;
todos.push(todo)
 }
}
