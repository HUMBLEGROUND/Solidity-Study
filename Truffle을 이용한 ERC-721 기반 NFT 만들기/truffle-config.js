const HDWalletProvider = require("@truffle/hdwallet-provider");

const mnemonic = "orange apple banana ...";

// module.exports = {
//   networks: {
//     ganache: {
//       host: "127.0.0.1", // local
//       port: 7545,
//       network_id: "*",
//     },
//   },
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1", // Localhost (default: none)
      port: 9545, // Standard Ethereum port (default: none)
      network_id: "*", // Any network (default: none)
    },

    rinkeby: {
      provider: function () {
        return new HDWalletProvider(
          mnemonic,
          "https://rinkeby.infura.io/v3/asd0asdsasdadedf312adsagfaaa80asdb1"
        );
      },
      network_id: 4,
      gas: 4500000,
      gasPrice: 10000000000,
    },
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.7", // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {
        // See the solidity docs for advice about optimization and evmVersion
        //  optimizer: {
        //    enabled: false,
        //    runs: 200
        //  },
        evmVersion: "london",
      },
    },
  },
};
