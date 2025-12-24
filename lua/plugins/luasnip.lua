return {
  "L3MON4D3/LuaSnip",
  lazy = false,
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("luasnip").config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    -- load vscode-style snippets
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
