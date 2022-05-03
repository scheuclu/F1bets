// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import './Ownable.sol';


contract PlayerManagement is Ownable {

    // ╔═══════════╗
    // ║ Variables ║
    // ╚═══════════╝
    mapping (address => string) addr2player;
    mapping (string => address) player2addr;

    struct PlayerInfo {
        bool isRegistered;
        string name;
        uint payout;
    }
    mapping (address => PlayerInfo) private _playerInfos;

    event PlayerRegistered(address player, string name);
    event PlayerDeRegistered(address player, string name);


    // ╔═══════════╗
    // ║ Modifiers ║
    // ╚═══════════╝
    modifier verifyCaller (address _address) {
        require(msg.sender == _address); 
        _;
    }

    modifier playerRegistered(){
        require(isPlayerRegistered(msg.sender) == true, "Players must be registered before placing bets");
        _;
    }


    // ╔═══════════╗
    // ║ Functions ║
    // ╚═══════════╝
    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

    function registerPlayer(address addr, string memory name) onlyOwner() external {
          addr2player[addr]=name;
          player2addr[name]=addr;

          _playerInfos[addr] = PlayerInfo({ isRegistered: true, name: name, payout: 0});
    }

    function deRegisterPlayer(address addr) public {
        require(isPlayerRegistered(addr) == true, "Player is not registered");

        player2addr[addr2player[addr]]=address(0);
        addr2player[addr]="";
        _playerInfos[addr] = PlayerInfo({ isRegistered: false, name: "", payout: 0});
    }

    function isPlayerRegistered(address addr) public view returns (bool){
       return _playerInfos[addr].isRegistered;
    }

    function getPlayerInfo(address addr) public view returns (PlayerInfo memory){
        return _playerInfos[addr];
    }


}