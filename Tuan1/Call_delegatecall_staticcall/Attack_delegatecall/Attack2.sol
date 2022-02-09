// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Setting {
    address public owner;
    function pwn() public {
        owner = msg.sender;
    }
    function getSelector() public pure returns(bytes memory){
        return abi.encodeWithSignature("pwn()") ;
    }
}

contract MyContract {
    address public owner;
    Setting public setting;
    constructor (address _address){
        owner = msg.sender;
        setting = Setting(_address);
    }
    fallback() external payable {
        address(setting).delegatecall(msg.data);
    }
    receive () external payable{}
}
