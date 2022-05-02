// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;


contract Setup {

    string _nextRace;


    string[20] _drivers = [
        "VER","PER","HAM","RUS","LEC","SAI","NOR","RIC","VET","STR",
        "ALO","OCO","GAS","TSU","BOT","ZHO","ALB","LAT","MSC","MZP"];


    // function submitSolution(string[2][20] memory solution) onlyOwner public returns (uint) {

    //     for(uint i=0; i<solution.length; i++){
    //         string memory sol_driver = solution[i][0];
    //         string memory sol_pos = solution[i][1];
            
    //         for(uint j=0; j<_players.length; j++){
    //             address player_addr = _players[j].addr;
    //             string memory bet_pos = _openRaceBets[player_addr].sBets[sol_driver];
    //             if(compareStrings(sol_pos, bet_pos)){
    //                 _players[j].payout++;

    //             }
    //         }
         
    //     }
    //     return 0;
    // }

}