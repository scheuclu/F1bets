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

    function placeBet() public payable {
        SingleBet memory b = SingleBet({player: "HAM", position: "1"});

        // SingleBet[20] memory sBets=[
        //     b,b,b,b,b,b,b,b,b,b,
        //     b,b,b,b,b,b,b,b,b,b
        // ];


        
        
        // RaceBet memory  rb = RaceBet({
        //                 from: msg.sender,
        //                 value: msg.value,
        //                 sBets: sBets});
        // ytemp = rb;
        _openRaceBets[msg.sender].from = msg.sender;
        _openRaceBets[msg.sender].value = msg.value;
        _openRaceBets[msg.sender].submitted = true;

        for(uint i=0; i<20; i++){
            _openRaceBets[msg.sender].sBets[i] = b;
        }
        _openRaceBets[msg.sender].sBets[0] = SingleBet({player: "HAM", position: "1"});
        _openRaceBets[msg.sender].sBets[1] = SingleBet({player: "RUS", position: "2"});
        _openRaceBets[msg.sender].sBets[2] = SingleBet({player: "PER", position: "3"});
        _openRaceBets[msg.sender].sBets[3] = SingleBet({player: "VER", position: "4"});
        _openRaceBets[msg.sender].sBets[4] = SingleBet({player: "LEC", position: "5"});
        _openRaceBets[msg.sender].sBets[5] = SingleBet({player: "SAI", position: "6"});
        _openRaceBets[msg.sender].sBets[6] = SingleBet({player: "RIC", position: "7"});
        _openRaceBets[msg.sender].sBets[7] = SingleBet({player: "NOR", position: "8"});
        _openRaceBets[msg.sender].sBets[8] = SingleBet({player: "GAS", position: "9"});
        _openRaceBets[msg.sender].sBets[9] = SingleBet({player: "TSU", position: "10"});
        _openRaceBets[msg.sender].sBets[10] = SingleBet({player: "ALO", position: "11"});
        _openRaceBets[msg.sender].sBets[11] = SingleBet({player: "OCO", position: "12"});
        _openRaceBets[msg.sender].sBets[12] = SingleBet({player: "BOT", position: "13"});
        _openRaceBets[msg.sender].sBets[13] = SingleBet({player: "ZHO", position: "14"});
        _openRaceBets[msg.sender].sBets[14] = SingleBet({player: "LAT", position: "15"});
        _openRaceBets[msg.sender].sBets[15] = SingleBet({player: "ALB", position: "16"});
        _openRaceBets[msg.sender].sBets[16] = SingleBet({player: "MSC", position: "17"});
        _openRaceBets[msg.sender].sBets[17] = SingleBet({player: "MZP", position: "18"});
        _openRaceBets[msg.sender].sBets[18] = SingleBet({player: "VET", position: "19"});
        _openRaceBets[msg.sender].sBets[19] = SingleBet({player: "STR", position: "20"});
        
        
    }


    function getPlayerBet(address addr) public view returns (RaceBet memory) {
            return _openRaceBets[addr];
    }


}