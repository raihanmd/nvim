-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymap helper
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- jj to escape insert mode
set("i", "jk", "<Esc>", opts)

-- Jumping
set({ "n", "o", "x" }, "<s-h>", "^", { desc = "Jump to beginning of line" })
set({ "n", "o", "x" }, "<s-l>", "g_", { desc = "Jump to end of line" })

-- Copy file paths
set("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })

-- file-explorer
set("n", "<leader>e", ":Neotree<CR>", { desc = "Neo tree" })

-- Code Snippets
set("v", "cx", ":CodeSnapSave<CR>", { desc = "Save with CodeSnap", silent = true })

-- Center the screen after scrolling up/down with Ctrl-u/d
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")
set("n", "n", "nzzzv", opts)
set("n", "N", "Nzzzv", opts)

-- Stay in indent mode
set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

-- Toggle line wrapping
set("n", "<leader>uw", "<cmd>set wrap!<CR>", opts)

-- save, quit
-- set("n", "<leader>w", "<cmd> w <cr>", opts)
-- set("n", "<leader>sn", ":<cmd>noautocmd w <cr>", opts)
-- set("n", "<leader>qq", "<cmd> q <cr>" ,opts)

-- move a blocks of text up/down with K/J in visual mode
set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Toggle Screenkey
set("n", "<leader>vk", "<cmd>Screenkey<CR>", opts)

-- Select all
set("n", "<C-a>", "gg<S-v>G")

-- delete single character without copying into register
set("n", "x", '"_x', opts)

-- search and replace the word under cursor in the file with <leader>s
set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- lazygit
set("n", "<leader>gg", ":LazyGit<CR>", opts)

-- Disable continuations
set("n", "<Leader>o", "o<Esc>^Da", opts)
set("n", "<Leader>O", "O<Esc>^Da", opts)

-- delete without yanking
set({ "n", "v" }, "<leader>d", [["_d]])

-- Paste in visual mode without yanking replaced text
set("x", "p", [["_dP]])

-- CopilotChat
set("n", "tc", ":CopilotChatSave ")
set("n", "tl", ":CopilotChatLoad ")
set("n", "tp", ":CopilotChatPrompts")

-- Resize window
set("n", "<leader><left>", ":vertical resize +20<cr>")
set("n", "<leader><right>", ":vertical resize -20<cr>")
set("n", "<leader><up>", ":resize +10<cr>")
set("n", "<leader><down>", ":resize -10<cr>")

-- Buffers
set("n", "<Tab>", ":bnext<cr>", opts)
set("n", "<S-Tab>", ":bprevious<cr>", opts)
set("n", "<leader>bd", ":bdelete!<cr>", opts) --close buffer
set("n", "<leader>bn", "<cmd> enew <cr>", opts) -- new buffer

-- Format buffer manually
set("n", "<leader>lf", function()
  vim.lsp.buf.format()
end, { desc = "Format current buffer" })

-- Toggle autoformat on save
set("n", "<leader>tf", ":ToggleAutoformat<CR>", { desc = "Toggle format on save" })

-- Markdown render
set("n", "<leader>pt", ":RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Render" })

set("n", "<leader>uC", function()
  require("telescope.builtin").colorscheme({
    enable_preview = true,
    attach_mappings = function(prompt_bufnr)
      local actions = require("telescope.actions")
      local state = require("telescope.actions.state")

      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = state.get_selected_entry()
        local theme = selection.value

        -- Apply theme
        vim.cmd.colorscheme(theme)

        -- Save ke file
        local file = vim.fn.stdpath("config") .. "/lua/config/colorscheme.lua"
        local f = io.open(file, "w")
        if f then
          f:write('vim.cmd.colorscheme("' .. theme .. '")')
          f:close()
        end
      end)

      return true
    end,
  })
end, { desc = "Colorscheme Picker" })
