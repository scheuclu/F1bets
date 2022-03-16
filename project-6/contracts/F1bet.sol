pragma solidity ^0.8.12;


contract F1bet {
    address owner;

    mapping (address => string) addr2player;
    mapping (string => address) player2addr;

    string _nextRace;

    struct Player {
        address addr;
        string name;   
    }

    Player[] players;
    


    struct SingleBet {
        string player;
        string position;
    }
    struct RaceBet {
        bool submitted;
        address from;
        uint value;
        SingleBet[20] sBets;
    }
    //RaceBet[] _openRaceBets;
    mapping (address => RaceBet) _openRaceBets;
    //RaceBet[] _openRaceBets;
    //RaceBet temp;


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



    constructor(){
        owner=msg.sender;
        _nextRace="Monaco";
    }

    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

    function addPlayer(address addr, string memory player) onlyOwner() external {
          addr2player[addr]=player;
          player2addr[player]=addr;

          Player memory p = Player({
              addr: addr, name: player
          });
          players.push(p);
    }

    function removePlayer(address addr, string calldata player) onlyOwner public {
          addr2player[addr]="";
          player2addr[player]=address(0);

          for(uint i=0; i<players.length; i++ ){
              if(players[i].addr==addr && compareStrings(players[i].name, player) ){
                  //proper way of removing elements from array
                  players[i] = players[players.length - 1];
                  players.pop();
                  break;
              }
              
          }
    }

    function listPlayers() public view returns (Player[] memory) {
          return players;
    }

    function setNextRace(string memory nextRace) onlyOwner() public {
        _nextRace = nextRace;
    }

    function getNextRace() public view returns (string memory) {
        return _nextRace;
    }

    function placeBet(string[2][20] memory sBets) public payable {

        _openRaceBets[msg.sender].from = msg.sender;
        _openRaceBets[msg.sender].value = msg.value;
        _openRaceBets[msg.sender].submitted = true;

        for(uint i=0; i<sBets.length; i++){
            _openRaceBets[msg.sender].sBets[i].player = sBets[i][0];
            _openRaceBets[msg.sender].sBets[i].position = sBets[i][1];
        }
        
    }


    function getPlayerBet(address addr) public view returns (RaceBet memory) {
            return _openRaceBets[addr];
    }


}