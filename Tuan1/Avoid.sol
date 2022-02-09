// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Avoid{
    enum Choice {NONE, ROCK, PAPER, SCISSOR}
    event Log(string message);
    struct PlayerChoice {
        address player;
        Choice choice;
    }

    PlayerChoice[2] players;

    function registerPlayer() public {
        if(players[0].player != address(0) && players[1].player != address(0)){
            revert("All players registered");
        }
        
        if(players[0].player == address(0))
            players[0].player = msg.sender;

        if(players[1].player == address(0) && players[0].player != msg.sender)
            players[1].player = msg.sender;

        
    }

    function play(Choice _choice) public {
        uint index = validateAndfindPlayerIndex();
        players[index].choice = _choice;
    }
    function abs(int x) public pure returns(int){
        return x > 0 ? x : -x;
    }
    function checkWinner() public {
        //Code to check winner and reward
        if(players[0].choice == Choice.NONE && players[1].choice == Choice.NONE){
            revert("one or both player don't have choice");
        }
        int res1 = int(uint(players[0].choice));
        int res2 = int(uint(players[1].choice));

        if(res1 == res2 ){
            emit Log("draw");
        }
        else if(abs(res1-res2)==1){
            if(res1 > res2){
                emit Log("Player 1 win");
            }else{
                emit Log("Player 2 win");
            }
        }
        else if(abs(res1-res2)==2){
            if(res1 > res2){
                emit Log("Player 2 win");
            }else{
                emit Log("Player 1 win");
            }
        }

    }

    function validateAndfindPlayerIndex() internal view returns (uint) {
        if(
            players[0].player == msg.sender &&
            players[0].choice == Choice.NONE
        ) return 0;

        if(
            players[1].player == msg.sender &&
            players[1].choice == Choice.NONE
        ) return 1;

        revert("Invalid call");
    }

}
contract Avoid2{
    enum Choice {NONE, ROCK, PAPER, SCISSOR}
    event Log(string message);
    struct PlayerChoice {
        address player;
        Choice choice;
        bytes32 commitHash;
    }

    PlayerChoice[2] players;

    function registerPlayer() public {
        if(players[0].player != address(0) && players[1].player != address(0)){
            revert("All players registered");
        }
        if(players[0].player == address(0))
            players[0].player = msg.sender;

        if(players[1].player == address(0) && players[0].player != msg.sender)
            players[1].player = msg.sender;

        
    }

    function play(bytes32 _commitHash) public {
        uint index = findPlayerIndex();
        players[index].commitHash = _commitHash;
    }

    function abs(int x) public pure returns(int){
        return x > 0 ? x : -x;
    }
    function checkWinner() public {
        //Code to check winner and reward
        if(players[0].choice == Choice.NONE && players[1].choice == Choice.NONE){
            revert("one or both player don't have choice");
        }
        int res1 = int(uint(players[0].choice));
        int res2 = int(uint(players[1].choice));

        if(res1 == res2 ){
            emit Log("draw");
        }
        else if(abs(res1-res2)==1){
            if(res1 > res2){
                emit Log("Player 1 win");
            }else{
                emit Log("Player 2 win");
            }
        }
        else if(abs(res1-res2)==2){
            if(res1 > res2){
                emit Log("Player 2 win");
            }else{
                emit Log("Player 1 win");
            }
        }

    }
    function reveal(Choice _choice, bytes32 _salt) public {
        require(
            players[0].commitHash != 0x0 &&
            players[1].commitHash != 0x0
        );
        uint index = findPlayerIndex();
        require(players[index].commitHash == 
            getSaltedHash(_choice, _salt));
        players[index].choice = _choice;
    }

    function getSaltedHash(Choice _answer, bytes32 _salt)
        internal view returns (bytes32) {
        return keccak256(abi.encodePacked(address(this), _answer, _salt));
    }


    function findPlayerIndex() internal view returns (uint) {
        if(
            players[0].player == msg.sender &&
            players[0].choice == Choice.NONE
        ) return 0;

        if(
            players[1].player == msg.sender &&
            players[1].choice == Choice.NONE
        ) return 1;

        revert("Invalid call");
    }

}
