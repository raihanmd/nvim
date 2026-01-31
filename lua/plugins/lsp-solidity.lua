return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solidity = {
          cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
          filetypes = { "solidity" },
          root_dir = require("lspconfig.util").root_pattern(
            "foundry.toml",
            "hardhat.config.js",
            "hardhat.config.ts",
            "truffle-config.js",
            "package.json",
            ".git"
          ),
          settings = {
            solidity = {
              compileUsingRemoteVersion = "latest",
            },
          },
        },
      },
    },
  },
}
