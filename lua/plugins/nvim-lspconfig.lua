return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      solidity_ls = {
        settings = {
          solidity = {
            enabledAsYouTypeCompilationErrorCheck = false,
            compileUsingRemoteVersion = "none",
          },
        },
      },
    },
  },
}
