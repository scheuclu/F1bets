// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import './PlayerManagement.sol';
import './Setup.sol';

contract F1bet is PlayerManagement, Setup {
    
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


    function setNextRace(string memory nextRace) onlyOwner() public {
        _nextRace = nextRace;
    }

    function getNextRace() public view returns (string memory) {
        return _nextRace;
    }

    function placeBet(string[2][20] memory bets) playerRegistered external payable {
        require(msg.value>0, "Cannot have zero bet");
        require(bets.length==20, "Must submit a bet for all 20 players");

        _openRaceBets[msg.sender].from = msg.sender;
        _openRaceBets[msg.sender].value = msg.value;
        _openRaceBets[msg.sender].submitted = true;

        // for(uint i=0; i<bets.length; i++){
        //     string memory bet_driver = bets[i][0];
        //     string memory bet_position = bets[i][1];
        //     _openRaceBets[msg.sender].sBets[bet_driver] = bet_position;
        // }

        for(uint i=0; i<20; i++){
            _openRaceBets[msg.sender].sBets["VER"] = "1";
        }
        _openRaceBets[msg.sender].sBets["VER"] = "1";

        //payable(address(owner)).transfer(msg.value);
        
    }

    // function evaluateInnerBet(string[] memory bets, string memory sol) private returns (uint){
           
    // }


    function getPlayerBet(address addr, string calldata driver) public view returns (string memory ) {

        return _openRaceBets[addr].sBets[driver];

    }


    function getBalance() public view returns (uint) {
        return  address(this).balance;
    }


}