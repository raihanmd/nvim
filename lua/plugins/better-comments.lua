-- ~/.config/nvim/lua/plugins/better-comments.lua
--
-- Better Comments  : // !  // ?  // *  // TODO
-- NatSpec Solidity : @notice @title @dev @author @param @return @inheritdoc @custom:*
--
-- Support patterns:
--   /// @notice ...              (triple-slash)
--   /** \n * @notice ... \n **/  (block comment)
--     * @notice ...              (inside block dengan leading spaces)
--
-- NatSpec color groups:
--   User-facing  : @notice, @title        → mint    #3DCFB5  bold
--   Developer    : @dev, @author          → lavender #B48EF7
--   Code/API     : @param, @return,
--                  @returns, @inheritdoc  → amber   #F0A500
--   Custom       : @custom:*             → rose    #F76E8A  italic

return {
  {
    "nvim-lua/plenary.nvim", -- sudah ada di LazyVim, tidak install ulang
    lazy = false,
    config = function()

      -- ── 1. Define semua highlight groups ──────────────────────────────────

      local function define_hl()
        -- Better Comments
        vim.api.nvim_set_hl(0, "BCAlert",     { fg = "#FF2D00", bold = true })  -- // !
        vim.api.nvim_set_hl(0, "BCQuery",     { fg = "#1F98FF" })               -- // ?
        vim.api.nvim_set_hl(0, "BCHighlight", { fg = "#98C379" })               -- // *
        vim.api.nvim_set_hl(0, "BCTodo",      { fg = "#FF8C00", bold = true })  -- // TODO

        -- NatSpec
        vim.api.nvim_set_hl(0, "NatspecUser",      { fg = "#3DCFB5", bold = true })   -- @notice @title
        vim.api.nvim_set_hl(0, "NatspecDev",       { fg = "#B48EF7" })                -- @dev @author
        vim.api.nvim_set_hl(0, "NatspecCode",      { fg = "#F0A500" })                -- @param @return @inheritdoc
        vim.api.nvim_set_hl(0, "NatspecParamName", { fg = "#F0A500", italic = true }) -- nama var setelah @param/@return
        vim.api.nvim_set_hl(0, "NatspecCustom",    { fg = "#F76E8A", italic = true }) -- @custom:xxx
      end

      define_hl()

      -- Re-apply setelah colorscheme berubah (agar hotreload theme tetap work)
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = define_hl,
      })

      -- ── 2. Apply matchadd patterns ────────────────────────────────────────
      --
      -- Catatan:
      --   - matchadd berlaku per-window, bukan per-buffer
      --   - harus dipanggil ulang tiap window/buffer baru
      --   - priority lebih tinggi menang jika overlap
      --   - Vim regex: \(\) untuk group, \| untuk OR, \> untuk word boundary

      local function apply_matches()
        -- ── Better Comments ──────────────────────────────────────────────────

        -- // !  /* !  # !  -- !
        vim.fn.matchadd("BCAlert",
          [[\(\/\/\|\/\*\|#\|--\)\s*!.*]], 19)

        -- // ?  /* ?  # ?  -- ?
        vim.fn.matchadd("BCQuery",
          [[\(\/\/\|\/\*\|#\|--\)\s*?.*]], 19)

        -- // *  # *  -- *  (exclude penutup block comment */)
        vim.fn.matchadd("BCHighlight",
          [[\(\/\/\|#\|--\)\s*\*.*]], 19)

        -- Baris " * text" di dalam block comment tanpa @ (deskripsi biasa)
        -- Priority 17 agar kalah dari NatSpec (priority 22)
        vim.fn.matchadd("BCHighlight",
          [[^\s*\*\s\+[^@/*].*]], 17)

        -- // TODO  /* TODO  # TODO  (case sensitive)
        vim.fn.matchadd("BCTodo",
          [[\(\/\/\|\/\*\|#\|--\).*\<TODO\>.*]], 19)

        -- ── NatSpec ──────────────────────────────────────────────────────────
        --
        -- Prefix pattern match dua format:
        --   "/// "    → triple-slash (\/\/\/\s*)
        --   "   * "   → block comment (^\s*\*\s*)
        --
        -- \> = word boundary (agar @params tidak match @param)
        -- .* = highlight sampai akhir baris
        -- Priority 22 agar menang atas BCHighlight (17-19)

        local p = [[\(\/\/\/\s*\|^\s*\*\s*\)]]

        -- @notice @title  →  mint bold
        vim.fn.matchadd("NatspecUser",
          p .. [[@\(notice\|title\)\>.*]], 22)

        -- @dev @author  →  lavender
        vim.fn.matchadd("NatspecDev",
          p .. [[@\(dev\|author\)\>.*]], 22)

        -- @param @return @returns @inheritdoc  →  amber
        vim.fn.matchadd("NatspecCode",
          p .. [[@\(param\|return\|returns\|inheritdoc\)\>.*]], 22)

        -- Nama var pertama setelah @param/@return  →  amber italic
        -- \zs \ze = start/end of match (hanya highlight bagian ini)
        -- Priority 23 agar menang atas NatspecCode di baris yang sama
        vim.fn.matchadd("NatspecParamName",
          p .. [[@\(param\|return\|returns\)\s\+\zs\S\+\ze]], 23)

        -- @custom:anything  →  rose italic
        vim.fn.matchadd("NatspecCustom",
          p .. [[@custom:[a-zA-Z0-9_:-]\+.*]], 22)
      end

      -- ── 3. Trigger ────────────────────────────────────────────────────────

      vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
        callback = function()
          -- Skip buffer spesial: telescope, lazy, terminal, dll
          local bt = vim.bo.buftype
          if bt == "nofile" or bt == "prompt" or bt == "terminal" then
            return
          end
          apply_matches()
        end,
      })

      -- Apply untuk buffer yang sudah terbuka saat startup
      apply_matches()

    end,
  },
}
