vim.filetype.add({
  extension = {
    spec = "cvl",
  },
})

vim.treesitter.language.register("solidity", "cvl") -- pinjam parser solidity buat highlight kasar

return {}
