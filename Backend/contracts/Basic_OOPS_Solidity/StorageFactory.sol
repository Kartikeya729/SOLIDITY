//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

//deploying contracts from contracts
contract Storagefactory {
  SimpleStorage[] public simplestorageArray;
  
  function createSimpleStorageContract() public {
     SimpleStorage simplestorage = new SimpleStorage();
     simplestorageArray.push(simplestorage);
     
  }  

  function sfStore(uint256 _simpleStorageIndex, uint _simpleStorageNumber) public {

    //address
    //ABI - application binary interface (tells code interaction method)
           simplestorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
     //object creation

     //simplestorage.store(_simpleStorageNumber);
  }

  function sfget(uint256 _simpleStorageIndex) public view returns(uint256){

    return simplestorageArray[_simpleStorageIndex].retrieve();

  }

}