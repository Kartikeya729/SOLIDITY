//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester{
    uint8 public bigNumber =255; //unchecked in 0.6.0 overflow or underflow
    
    
    function add() public {
    
    bigNumber = bigNumber + 1;
    
    }
}