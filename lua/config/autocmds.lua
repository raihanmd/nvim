-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name:match("solidity") then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
})


vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.sol",
  callback = function()
    local root = vim.fs.find("foundry.toml", {
      upward = true,
      path = vim.api.nvim_buf_get_name(0),
    })[1]
    if root then
      vim.fn.chdir(vim.fs.dirname(root))
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "SolidityNatSpecTag", {
      fg = "#f9e2af",
      bold = true,
    })
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "solidity",
  callback = function()
    vim.cmd([[
      syntax match SolidityNatSpecTag "@param\|@dev\|@notice\|@return\|@title\|@author"
    ]])
  end,
})

vim.api.nvim_set_hl(0, "SolidityNatSpecTag", {
  fg = "#f9e2af",
  bold = true,
})
