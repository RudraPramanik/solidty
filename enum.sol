pragma solidity ^0.8.0;

contract enums{
    enum FresJuiceSize{SMALL, MEDIUM, LARGE}
    FresJuiceSize choice;
    FresJuiceSize constant defaultChoice = FresJuiceSize.MEDIUM;

    function setLarge() public{
        choice = FresJuiceSize.LARGE;
    }
    function getChoice() public view returns(FresJuiceSize){
        return choice
    }
    function getDefaultChoice() public pure returns (uint){
        return uint(defaultChoice)
    }
}