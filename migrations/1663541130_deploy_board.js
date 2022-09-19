const Board = artifacts.require("Board");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(Board);
  const board = await Board.deployed();
  await deployer.ens.setAddress("toucan.eth", board, { from: accounts[0] });
};
