var Greete = artifacts.require("./Greete.sol");

module.exports = function(deployer) {
  deployer.deploy(Greete);
};
