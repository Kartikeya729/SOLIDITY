// SPDX-License-Identifier: MIT
pragma solidity 0.8.8; // 0.8.12 will also work ^ or >= version for between

//CONTRACT (like a class in java)

contract SimpleStorage {

    //common DATA TYPES - boolean, unit, int, address, bytes

    //bool HasFavouriteNumber; // init to 0

    uint256 public  favouritenumber;

//MAPPING

    mapping(string => uint256) public nametofavouritenumber;

//STRUCT AND ARRAY     
    struct People {
        uint256 favouritenumber;
        string name;
    }
// USEAGE STRUCT AND ARRAY

    People[] public people;

// Public private external internal variable visibility type

    //string favouritenumberintext = "five";
    //int256 favouriteint = -5;
    //address myadress = 0x10000000000000000000000000000;
    //bytes32 favouritebytes = "cat";

 

//FUCNTIONS

function store(uint256 _favouritenumber) public {

   

    favouritenumber = _favouritenumber;
    //favouritenumber = favouritenumber + 1;

    
}

function retrieve() public view returns(uint256){
return favouritenumber;
}

function add() public pure returns ( uint256){
    return(1+1);
    //Pure function is for redoing something that does not require program to read storage
}

function addperson(string memory _name,uint256 _favouritenumber) public {
    people.push(People(_favouritenumber, _name));
    nametofavouritenumber[_name] = _favouritenumber;
} //adds people and numbers in array for struct

// stack, memory, storage, calldata, code, logs - places to store information
//calldata, memory -> temporary existence DEFAULT -> storage function
// calldata -> cant be modified ; memory -> can be modified 
// ONLY FOR ARRAY STRUCT OR MAPPING DATATYPES
 
 //SCOPE OF FUNCTION (function cannot access the variable in the other function)

}
// VIEW or PURE function DOESN'T SPEND ETHER 
 // but will spend ether is we call from a gas function
  
// address deployed 0xd9145CCE52D386f254917e481eB44e9943F39138
// More you do more expensive the transaction

//EVM (Etherium virtual machine)  avalanche, phantom, polygon
