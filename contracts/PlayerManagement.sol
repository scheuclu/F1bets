// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;


contract PlayerManagement {
    address owner;

    mapping (address => string) addr2player;
    mapping (string => address) player2addr;

    struct PlayerInfo {
        bool isRegistered;
        string name;
        uint payout;
    }
    mapping (address => PlayerInfo) private _playerInfos;


    // Define a modifer that checks to see if msg.sender == owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Define a modifer that verifies the Caller
    modifier verifyCaller (address _address) {
        require(msg.sender == _address); 
        _;
    }

    modifier playerRegistered(){
        require(isPlayerRegistered(msg.sender) == true, "Players must be registered before placing bets");
        _;
    }

    constructor(){
        owner=msg.sender;
    }

    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

    function registerPlayer(address addr, string memory name) onlyOwner() external {
          addr2player[addr]=name;
          player2addr[name]=addr;

          //PlayerInfo memory p =  PlayerInfo({ isRegistered: false, name: name, payout: 0});
          _playerInfos[addr] = PlayerInfo({ isRegistered: true, name: name, payout: 0});

        //   Player memory p = Player({
        //       addr: addr, name: player, payout: 0
        //   });
        //   _players.push(p);
    }

    // function removePlayer(address addr, string calldata player) onlyOwner public {
    //       addr2player[addr]="";
    //       player2addr[player]=address(0);

    //       for(uint i=0; i<_players.length; i++ ){
    //           if(_players[i].addr==addr && compareStrings(_players[i].name, player) ){
    //               //proper way of removing elements from array
    //               _players[i] = _players[_players.length - 1];
    //               _players.pop();
    //               break;
    //           }
              
    //       }
    // }

    // function listPlayers() public view returns (Player[] memory) {
    //       return _players;
    // }

    function isPlayerRegistered(address addr) public view returns (bool){
       return _playerInfos[addr].isRegistered;
    }

    function getPlayerInfo(address addr) public view returns (PlayerInfo memory){
        return _playerInfos[addr];
    }


}