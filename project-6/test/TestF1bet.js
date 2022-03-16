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

contract('F1Bet', async (accounts) => {
    // Declare few constants and assign a few sample accounts generated by ganache-cli


    const account_0 = accounts[0];
    const account_1 = accounts[1];
    const account_2 = accounts[2];

    // let f1bet = None;

    before("setup contract", async () => {
        f1bet = await F1Bet.new({ from: account_0 });
    });


    it("Owner can add player, but others can't", async () => {
        const f1bet = await F1Bet.new({ from: account_0 })
        await f1bet.addPlayer(account_0, "Lukas", { from: account_0 });

        expectRevert.unspecified(
            f1bet.addPlayer(account_1, "Lisa", { from: account_1 })
        );
    })


    it("Everyone can get a list of active players", async () => {
        f1bet = await F1Bet.new({ from: account_0 })

        await f1bet.addPlayer(account_0, "Lukas", { from: account_0 });
        await f1bet.addPlayer(account_1, "Lisa", { from: account_0 });

        let result = await f1bet.listPlayers();

        assert(result.length, 2, "Should have 2 players registered");
        assert.equal(result[0]['addr'], account_0, "Information read incorrectly.");
        assert.equal(result[0]['name'], "Lukas", "Information read incorrectly.");
        assert.equal(result[1]['addr'], account_1, "Information read incorrectly.");
        assert.equal(result[1]['name'], "Lisa", "Information read incorrectly.");

    })

    it("Player can be removed", async () => {
        await f1bet.removePlayer(account_0, "Lukas", { from: account_0 });
        // await f1bet.addPlayer(account_1, "Lisa", {from: account_0});

        let result = await f1bet.listPlayers();
        assert(result.length, 2, "Should have 1 players registered");
        assert.equal(result[0]['addr'], account_1, "Information read incorrectly.");
        assert.equal(result[0]['name'], "Lisa", "Information read incorrectly.");

    })


    it("Ask for the next race", async () => {
        let result = await f1bet.getNextRace();
        assert.equal(result, "Monaco", "Next race wrong.");

        //Change next race, but from wrong location
        expectRevert.unspecified(
            f1bet.setNextRace("Spa", { from: account_1 })
        );
        result = await f1bet.getNextRace();
        assert.equal(result, "Monaco", "Next race wrong.");

        //Change next race, but from correct location
        await f1bet.setNextRace("Spa", { from: account_0 });
        result = await f1bet.getNextRace();
        assert.equal(result, "Spa", "Next race wrong.");

    })


    it("Place bet", async () => {
        await f1bet.placeBet();
        let result = await f1bet.getPlayerBet(account_0);
        console.log("account_0 bets:", result);
        let result1 = await f1bet.getPlayerBet(account_1);
        console.log("account_1 bets:", result1);
    })

    it("Submit solution", async () => {

    })

    



});

