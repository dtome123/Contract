// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract TestTransfer{

    function transfer(address payable _to) public  payable {
        _to.transfer(msg.value);
    }
    function send(address payable _to) public payable{
        bool sent = _to.send(msg.value);
        require(sent,"Failed to send Ether");
    }
    function call (address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
contract ReceiverV1{
    event Response(address sender, uint value, string message);
    mapping (address => uint) public balance;
    fallback () external payable{        
        emit Response(msg.sender,msg.value,"fallback");
    }
    receive () external payable{
        emit Response(msg.sender,msg.value,"receive");
    }
    function getBalance () public view returns (uint){
        return address(this).balance;
    }
        
    function deposit() public payable returns(bool){
        require(msg.value > 0, "balance < 0");
        balance[msg.sender] = balance[msg.sender] + msg.value;
        emit Response(msg.sender,msg.value,"deposit");
        (bool success,) = address(this).call{value:msg.value}("");
        return success;
    }
}

contract ReceiverV2{
    event Response(address sender, uint value, string message);
    mapping (address => uint) public balance;
    fallback () external payable{}
    receive () external payable{}
    function getBalance () public view returns (uint){
        return address(this).balance;
    }
        
    function deposit() public payable returns(bool){
        require(msg.value > 0, "balance < 0");
        balance[msg.sender] = balance[msg.sender] + msg.value;
        emit Response(msg.sender,msg.value,"deposit");
        (bool success,) = address(this).call{value:msg.value}("");
        return success;
    }
}