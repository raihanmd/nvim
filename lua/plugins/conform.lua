return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        solidity = { "forge_fmt" },
      },
      formatters = {
        forge_fmt = {
          command = "forge",
          args = { "fmt", "--raw", "-" },
          stdin = true,
          cwd = function(ctx)
            return ctx.root
          end,
        },
      },
    },
  },
}
