// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Test1{
    int public number;
    function increaseRequire() public{
        number = number + 1;
        require(number < 5,"number should be less than 20");
    }
    function decreaseRevert() public{
        number = number - 1 ;
        if(number < 0){
            revert("number should be greater than 0");
        }
    }
    function assertIsEven() public{
        
        number = number + 1;
        assert(number % 2 == 0);
    }


}
contract VendingMachine {
    function buy(uint amount) public payable {
        if (amount > msg.value / 2 ether)
            revert("Not enough Ether provided. revert");
        // Alternative way to do it:
        require(
            amount <= msg.value / 2 ether,
            "Not enough Ether provided. require"
        );
        // Perform the purchase.
    }
}

contract MyContract {
    function send(address payable _to) payable public{
        
        bool sent = _to.send(msg.value);
        require(sent,"failed to sent");
    }
}