pragma solidity ^0.8.0;


// type[] arrayName;

contract solidityArray{
    uint balance[3] = [1, 2, 3];
    // to declare it without amount
    //accessing array elements
    uint salary = balance[2]
    function testArray() public pure{
        uint len = 7;

        //dynamic array
        dynamic[] memory a = new uint[](7);

        bytes memory b = new bytes(len)

        assert(a.length == 7);
        assert(b.length==len);

        //access array variable
        a[6] = 8;

        //test array vaiable
        assert(a[6] == 8 );

        //static array
        uint[3] memory c = [uint(1), 2, 3];
        assert(c.length == 3);
    }
}
