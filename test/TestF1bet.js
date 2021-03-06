// This script is designed to test the solidity smart contract - SuppyChain.sol -- and the various functions within
// Declare a variable and assign the compiled smart contract artifact
var F1Bet = artifacts.require('F1Bet')


const truffleAssert = require('truffle-assertions');
const {
    BN,
    expectEvent,
    expectRevert,
} = require('@openzeppelin/test-helpers');
const { assertion } = require('@openzeppelin/test-helpers/src/expectRevert');
const { inTransaction } = require('@openzeppelin/test-helpers/src/expectEvent');

contract('F1Bet', async (accounts) => {
    // Declare few constants and assign a few sample accounts generated by ganache-cli


    const account_0 = accounts[0];
    const account_1 = accounts[1];
    const account_2 = accounts[2];

    const bet1 = [
        ["VER", "1"], ["PER", "2"], ["HAM", "3"], ["RUS", "4"], ["SAI", "5"],
        ["LEC", "6"], ["VET", "7"], ["STR", "8"], ["GAS", "9"], ["TSU", "10"],
        ["ALO", "11"],["OCO", "12"],["RIC", "13"],["NOR", "14"],["BOT", "15"],
        ["ZHO", "16"],["LAT", "17"],["ALB", "18"],["MSC", "19"],["MZP", "20"]
    ];

    const bet2 = [
        ["HAM", "1"], ["VET", "2"], ["VER", "3"], ["RUS", "4"], ["SAI", "5"],
        ["LEC", "6"], ["PER", "7"], ["STR", "8"], ["GAS", "9"], ["TSU", "10"],
        ["ALO", "11"],["OCO", "12"],["RIC", "13"],["NOR", "14"],["BOT", "15"],
        ["ZHO", "16"],["LAT", "17"],["ALB", "18"],["MSC", "19"],["MZP", "20"]
    ];



    // let f1bet = None;

    before("setup contract", async () => {
        f1bet = await F1Bet.new({ from: account_0 });
    });

    it("Dummy", async () => {
    })   


    // it("Contract balance is being tracked", async () => {
    //     const f1bet = await F1Bet.new({ from: account_0 })
    //     let balance_before = await f1bet.getBalance();
    //     //console.log("balance_before", balance_before.toString());
        
    //     //place bet from account_1
    //     await f1bet.placeBet(bet1, {from: account_1, value: web3.utils.toWei("0.1", "ether")} );
    //     //place bet from account_2
    //     await f1bet.placeBet(bet2, {from: account_2, value: web3.utils.toWei("0.2", "ether")} );


    //     // Check that the correct balance is stored in the contract
    //     balance_after = await f1bet.getBalance();
    //     console.log("balance_after", balance_after.toString());
    //     console.log("balance_diff", balance_after-balance_before   );
    //     assert.equal(balance_after-balance_before, web3.utils.toWei("0.3", "ether"));

    //     //Check that the bets hace been placed correctly


    // })

    // it("Check that the previously placed bets have been saved correctly", async () => {
    //     let result1  = await f1bet.getPlayerBet(account_1, "VER");
    //     let result2  = await f1bet.getPlayerBet(account_1, "1");
    //     console.log("result1", result1);
    //     console.log("result2", result2);
    //     // assert.equal(result1, bet1, "Player bet returned incorrectly");

    //     // let result2  = await f1bet.getPlayerBets(account_2);
    //     // assert.equal(result2, bet2, "Player bet returned incorrectly");
    // })







    // it("Place bet", async () => {

    //     let valid_result_arr1 = [
    //         ["VER", "1"], ["PER", "2"], ["HAM", "3"], ["RUS", "4"], ["SAI", "5"],
    //         ["LEC", "6"], ["VET", "7"], ["STR", "8"], ["GAS", "9"], ["TSU", "10"],
    //         ["ALO", "11"],["OCO", "12"],["RIC", "13"],["NOR", "14"],["BOT", "15"],
    //         ["ZHO", "16"],["LAT", "17"],["ALB", "18"],["MSC", "19"],["MZP", "20"]
    //     ]
    //     let valid_result_arr2 = [
    //         ["VER", "1"], ["PER", "2"], ["HAM", "3"], ["RUS", "4"], ["SAI", "5"],
    //         ["LEC", "6"], ["VET", "7"], ["STR", "8"], ["GAS", "9"], ["TSU", "10"],
    //         ["ALO", "11"],["OCO", "12"],["RIC", "13"],["NOR", "14"],["BOT", "15"],
    //         ["ZHO", "16"],["LAT", "DNF"],["ALB", "17"],["MSC", "18"],["MZP", "19"]
    //     ]
    //     let invalid_result_arr1 = [
    //         ["VER", "1"], ["PER", "2"], ["HAM", "3"], ["RUS", "4"], ["SAI", "5"],
    //         ["LEC", "6"], ["VET", "7"], ["STR", "8"], ["GAS", "9"], ["TSU", "10"],
    //         ["ALO", "11"],["OCO", "12"],["RIC", "13"],["NOR", "14"],["BOT", "15"],
    //         ["ZHO", "16"],["LAT", "1"],["ALB", "18"],["MSC", "19"],["MZP", "20"]
    //     ]


    //     await f1bet.placeBet(valid_result_arr1, {from: account_0, value: 5});
    //     let result = await f1bet.getPlayerBets(account_0);
    //     expect(
    //         result.map( (a)=>a[0]+a[1] )).to.have.members(
    //         valid_result_arr1.map( (a)=>a[0]+a[1] )
    //     );

    //     await f1bet.placeBet(valid_result_arr2, {from: account_1, value: 7});
    //     let result1 = await f1bet.getPlayerBets(account_1);
    //     expect(
    //         result1.map( (a)=>a[0]+a[1] )).to.have.members(
    //         valid_result_arr2.map( (a)=>a[0]+a[1] )
    //     );

    // })



    // it("Submit solution", async () => {
        
    //     f1bet = await F1Bet.new({ from: account_0 })
    //     await f1bet.addPlayer(account_0, "Lukas", { from: account_0 });
    //     await f1bet.addPlayer(account_1, "Lisa", { from: account_0 });
    //     await f1bet.addPlayer(account_2, "Patrick", { from: account_0 });

    //     let bet_0 = [
    //         ["VER", "2"],   ["PER", "4"],   ["HAM", "1"],   ["RUS", "3"],   ["SAI", "8"],
    //         ["LEC", "6"],   ["VET", "DNF"], ["STR", "11"],  ["GAS", "DNF"], ["TSU", "10"],
    //         ["ALO", "7"],   ["OCO", "DNF"], ["RIC", "5"],   ["NOR", "9"],   ["BOT", "DNF"],
    //         ["ZHO", "DNF"], ["LAT", "13"],  ["ALB", "14"],  ["MSC", "DNF"], ["MZP", "12"]
    //     ]
    //     let bet_1 = [
    //         ["VER", "2"],   ["MSC", "DNF"], ["PER", "4"],   ["HAM", "1"],   ["RUS", "3"],   
    //         ["LEC", "8"],   ["VET", "DNF"], ["STR", "11"],  ["GAS", "DNF"], ["TSU", "10"],
    //         ["ALO", "7"],   ["OCO", "DNF"], ["RIC", "5"],   ["NOR", "9"],   ["BOT", "DNF"],
    //         ["ZHO", "DNF"], ["LAT", "13"],  ["ALB", "14"],  ["MZP", "12"],  ["SAI", "6"],
    //     ]
    //     let bet_2 = [
    //         ["VER", "2"],   ["PER", "DNF"], ["HAM", "1"],   ["RUS", "3"],   ["SAI", "5"],
    //         ["LEC", "4"],   ["VET", "11"],  ["STR", "DNF"], ["GAS", "9"],   ["TSU", "7"],
    //         ["ALO", "10"],  ["OCO", "12"],  ["RIC", "6"],   ["NOR", "8"],   ["BOT", "14"],
    //         ["ZHO", "15"],  ["LAT", "DNF"], ["ALB", "16"],  ["MSC", "13"],  ["MZP", "DNF"]
    //     ]

    //     let solution = [
    //         ["VER", "2"],   ["PER", "DNF"], ["HAM", "1"],   ["RUS", "11"],  ["SAI", "6"],
    //         ["LEC", "3"],   ["VET", "15"],  ["STR", "8"],   ["GAS", "9"],   ["TSU", "10"],
    //         ["ALO", "4"],   ["OCO", "5"],   ["RIC", "7"],   ["NOR", "12"],  ["BOT", "13"],
    //         ["ZHO", "14"],  ["LAT", "16"],  ["ALB", "17"],  ["MSC", "DNF"], ["MZP", "DNF"]
    //     ]

    //     await f1bet.placeBet(bet_0, {from: account_0, value: 1});
    //     await f1bet.placeBet(bet_1, {from: account_1, value: 4});
    //     await f1bet.placeBet(bet_2, {from: account_2, value: 3});

    //     let players = await f1bet.listPlayers();
    //     let payouts = await f1bet.submitSolution(bet_0, {from: account_0});
    //     players = await f1bet.listPlayers();

    // })

    



});

