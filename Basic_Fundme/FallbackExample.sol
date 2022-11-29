//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallBackExample{
    uint256 public result;

    receive() external payable {
       result = 1; //receive is triggered by any transaction null or not null
    }
                  //check with calldata in low level interactions
                  //when data is sent then fallback error is received because with data solidity isnt looking for receive() but actually a function or a fallback function
    
    fallback() external payable{
       result = 2; 
    }

}

/* if ETHER IS SENT to contract
is msg.data empty ->
yes -> receive() 
no -> fallback() */