// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TestDelegate{
    uint num ;
    
    
    function setValue (address _contract, uint _number) public returns(bool){
        (bool success,) = _contract.delegatecall(abi.encodeWithSignature("store(uint256)",_number));
        return success;
    }
    function getValue () public view returns(uint){
        return num;
    }
    
}
contract TestCall {
    event Reponse(bool success, bytes data);

    function setValue (address _contract, uint _number) public returns(bool){
        (bool success,)= _contract.call(abi.encodeWithSignature("store(uint256)", _number));
        return success;
        
    }
    function getValue (address _contract)public returns(bool,bytes memory){
        (bool success,bytes memory data)= _contract.call(abi.encodeWithSignature("retrieve()"));
        return (success,data);
    }
}
contract TestStaticcall{
    
    function setValue (address _contract, uint _number) public view returns(bool){
        (bool success,)= _contract.staticcall(abi.encodeWithSignature("store(uint256)", _number));
        return success;
        
    }
    function getValue (address _contract) public view returns (bool,bytes memory ){
        (bool success,bytes memory data)= _contract.staticcall(abi.encodeWithSignature("retrieve()"));
        return (success,data);
    }
}

