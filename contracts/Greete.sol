pragma solidity ^0.4.16;


contract Greete {
    
    function sayHello() public constant returns (string name) {
        return ("迪丽热巴");
    }

    function greeting(uint a) public returns(uint b) {
        return a*8;
    }
}