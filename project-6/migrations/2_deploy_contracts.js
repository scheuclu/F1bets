// migrating the appropriate contracts
var F1Bet = artifacts.require("./F1Bet.sol");


module.exports = function(deployer) {
  deployer.deploy(F1Bet);
};
