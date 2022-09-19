require("dotenv");
const HDWalletProvider = require("@truffle/hdwallet-provider");

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      ens: {
        registry: {
          address: "0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e"
        },
      },
    },

    goerli: {
      provider: () => {
        return new HDWalletProvider(
          process.env.MNEMONIC,
          "https://goerli.infura.io/v3/" + process.env.INFURA_API_KEY,
        );
      },
      network_id: "5",
      gas: 4465030,
      gasPrice: 10000000000,
    },
  },

  ens: { enabled: true },

  compilers: {
    solc: {
      version: "0.8.17",
    },
  },
};
