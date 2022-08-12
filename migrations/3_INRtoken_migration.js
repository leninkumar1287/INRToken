const INR = artifacts.require("inrToken");

module.exports = function (deployer) {
  deployer.deploy(INR);
};
