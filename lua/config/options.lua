-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.cmdheight = 1
-- vim.opt.wildmenu = true
-- vim.opt.wildmode = "longest:full,full"
-- vim.opt.wildoptions = "pum"
vim.g.root_spec = {
  { ".git", "foundry.toml", "package.json" },
}
