//Get Funds from users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";


error NotOwner(); //custom errors to save gas //refer below

contract FundMe{

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    
      //Only owner can withdraw but anyone can fund
      address public immutable i_owner;

      constructor(){
         // called immediately after function executes
        i_owner = msg.sender;
      }



    function fund() public payable {
      //want a min amaount fund in USD
      // send eth to this contract
      // payable keyword - contract address 

      require(msg.value.getConversrionRate() >= MINIMUM_USD, "Didn't send enough"); // wei in 1 eth = 10^18
      //revert - > sends gas back to address if condition doesn't pass and prior work is undone
      // 18 decimal places
      funders.push(msg.sender);
      addressToAmountFunded[msg.sender] = msg.value;
    }

   

   function withdraw() public onlyOwner {
     //require(msg.sender == owner, "Sender is not owner"); //wouldnt be required repeatedly if create a MODIFIER

     //FOR LOOP 
     for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
       address funder = funders[funderIndex];
       addressToAmountFunded[funder] = 0;
     }
     //reset array to blank array
     funders = new address[](0);
     //withdrawing the obtained funds
     //3 ways - transfer, send, call

     //Transfer
     //msg.address -> address but payable(msg.address) is typecasted to payable address
     //payable(msg.sender).transfer(address(this).balance);
     //SEND
     //bool sendSuccess = payable(msg.sender).send(address(this).balance);
     //require(sendSuccess, "send failed");
     //CALL
     (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
      require(callSuccess, "call failed");
   }
   //MODIFIER
   modifier onlyOwner {
       //require(msg.sender == i_owner, "Sender is not owner"); //gas can be saved by not storing "string" and instead using custom error codes
       if(msg.sender != i_owner){ revert NotOwner();}
       _;

   }

   //what happens if we send ETH without calling the fund function?

   receive() external payable {
       fund();
   }

   fallback() external payable {
       fund();
   }

}

//gas efficiency can be optimized with -
//constant, immutable for storing variable - instead of storing in stack or slot, stored in direct bytecode