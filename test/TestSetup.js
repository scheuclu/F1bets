// This script is designed to test the solidity smart contract - SuppyChain.sol -- and the various functions within
// Declare a variable and assign the compiled smart contract artifact
var setup = artifacts.require('Setup')


const truffleAssert = require('truffle-assertions');
const {
    BN,
    expectEvent,
    expectRevert,
} = require('@openzeppelin/test-helpers');
const { assertion } = require('@openzeppelin/test-helpers/src/expectRevert');
const { inTransaction } = require('@openzeppelin/test-helpers/src/expectEvent');

contract('Setup', async (accounts) => {

    const account_0 = accounts[0];
    const account_1 = accounts[1];
    const account_2 = accounts[2];


    before("setup contract", async () => {
        ctr = await setup.new({ from: account_0 });
    });


    it("Ask for the next race", async () => {
        let result = await ctr.getNextRace();
        assert.equal(result, "Monaco", "Next race wrong.");

        //Change next race, but from wrong location
        expectRevert.unspecified(
            ctr.setNextRace("Spa", { from: account_1 })
        );
        result = await ctr.getNextRace();
        assert.equal(result, "Monaco", "Next race wrong.");

        //Change next race, but from correct location
        await ctr.setNextRace("Spa", { from: account_0 });
        result = await ctr.getNextRace();
        assert.equal(result, "Spa", "Next race wrong.");

    })


});

