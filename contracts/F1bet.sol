pragma solidity ^0.8.12;


contract F1bet {
    address owner;

    mapping (address => string) addr2player;
    mapping (string => address) player2addr;

    string _nextRace;

    struct Player {
        address addr;
        string name;
        uint payout;
    }

    Player[] _players;
    

    string[20] _drivers = [
        "VER","PER","HAM","RUS","LEC","SAI","NOR","RIC","VET","STR",
        "ALO","OCO","GAS","TSU","BOT","ZHO","ALB","LAT","MSC","MZP"];
    mapping (string => string) private _driver2bet;
    mapping (string => string) private _bet2driver;


    struct SingleBet {
        string player;
        string position;
    }
    struct RaceBet {
        bool submitted;
        address from;
        uint value;
        mapping (string => string) sBets;
    }

    mapping (address => RaceBet) _openRaceBets;


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

    // Define a modifer that verifies the bet to be valid
    modifier validBet (string[2][20] memory sBets) {
        uint numDNF=0;
        uint numDNS=0;

        for(uint i=0; i<_drivers.length; i++){
            _driver2bet[_drivers[i]] = "";
            _bet2driver[_drivers[i]] = "";
        }
        for(uint i=0; i<sBets.length; i++){
            if( compareStrings(sBets[i][0], "DNF") ){
                numDNF++;
                continue;
            }
            if( compareStrings(sBets[i][0], "DNS") ){
                numDNS++;
                continue;
            }
            //make sure nobody has placed this bet before
            require(compareStrings(_bet2driver[sBets[i][1]],""), "Duplicate position found.");
            _driver2bet[sBets[i][0]] = sBets[i][1];
            _bet2driver[sBets[i][1]] = sBets[i][0];
        }
        
        //TODO DNF/DNS should reduce the maximum bettable position
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
              addr: addr, name: player, payout: 0
          });
          _players.push(p);
    }

    function removePlayer(address addr, string calldata player) onlyOwner public {
          addr2player[addr]="";
          player2addr[player]=address(0);

          for(uint i=0; i<_players.length; i++ ){
              if(_players[i].addr==addr && compareStrings(_players[i].name, player) ){
                  //proper way of removing elements from array
                  _players[i] = _players[_players.length - 1];
                  _players.pop();
                  break;
              }
              
          }
    }

    function listPlayers() public view returns (Player[] memory) {
          return _players;
    }

    function setNextRace(string memory nextRace) onlyOwner() public {
        _nextRace = nextRace;
    }

    function getNextRace() public view returns (string memory) {
        return _nextRace;
    }

    function placeBet(string[2][20] memory bets) external payable {
        require(msg.value>0, "Cannot have zero bet");

        _openRaceBets[msg.sender].from = msg.sender;
        _openRaceBets[msg.sender].value = msg.value;
        _openRaceBets[msg.sender].submitted = true;

        for(uint i=0; i<bets.length; i++){
            string memory bet_driver = bets[i][0];
            string memory bet_position = bets[i][1];
            _openRaceBets[msg.sender].sBets[bet_driver] = bet_position;
        }
        
    }

    // function evaluateInnerBet(string[] memory bets, string memory sol) private returns (uint){
           
    // }


    function submitSolution(string[2][20] memory solution) onlyOwner public returns (uint) {

        for(uint i=0; i<solution.length; i++){
            string memory sol_driver = solution[i][0];
            string memory sol_pos = solution[i][1];
            
            for(uint j=0; j<_players.length; j++){
                address player_addr = _players[j].addr;
                string memory bet_pos = _openRaceBets[player_addr].sBets[sol_driver];
                if(compareStrings(sol_pos, bet_pos)){
                    _players[j].payout++;

                }
            }
         
        }

        return 0;

        
    }


    function getPlayerBets(address addr) public view returns (string[2][20] memory ) {

            string[2][20] memory result;
            for(uint i=0; i<20; i++){
                string memory driver = _drivers[i];
                result[i][0] = driver;
                result[i][1] = _openRaceBets[addr].sBets[driver];
            }

            return result;

    }


    function getBalance() public returns (uint) {
        return address(this).balance;
    }


}