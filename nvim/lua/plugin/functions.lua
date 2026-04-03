-- /// FUNCTIONS.LUA | plugins responsible for adding functionality to neovim ///

-- /// TELESCOPE ///
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-d>'] = false,
        ['<C-u>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = false, -- disabling hidden files
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope shortcuts
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { previewer = false })
end, { desc = 'Fuzzily search in current buffer' })

-- /// TODO-COMMENTS ///
require("todo-comments").setup {
  signs = true, -- icons in leftmost column
  sign_priority = 8,

  keywords = { -- keywords to recognise and color
    FIX  = { icon = " ", color = "error", alt = { "BUG", "ERR", "ERROR" }, },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", color = "warning", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "info", alt = { "INFO" } },
  },

  gui_style = { fg = "NONE", bg = "BOLD", }, -- style for highlighting
  merge_keywords = true,
  highlight = { -- highlighting of the line containing the todo comment
    multiline = true,
    multiline_pattern = "^.", -- lua pattern to match the next line
    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    -- defining how highlighting should work before, on the keyword and after it
    before = "",
    keyword = "wide",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern for highlighting
  },

  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#F7768E" },
    warning = { "DiagnosticWarn", "WarningMsg", "#E0AF68" },
    info = { "DiagnosticInfo", "#2AC3DE" },
    default = { "Identifier", "#C0CAF5" },
  },

  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
  },
}

vim.keymap.set("n", "<leader>T", vim.cmd.TodoTelescope, { desc = "Open TodoTelescope" })

-- /// NVIM-TREE ///
-- disabling netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
  view = { width = 30, },         -- set width
  filters = { dotfiles = false, }, -- Showing dotfiles
}

vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree "}) -- opening the nvim-tree

-- /// AUTOCLOSE ///
require('autoclose').setup {
  options = {
    disabled_filetypes = { "text", "markdown", "" },
  },
}

--- /// NVIM-SPIDER ///
require('spider').setup {
  customPatterns = {
    patterns = { "%(", "%)", "%>", "%<", "%[", "%]" },
    overrideDefault = false,
  },
}

vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>")

--- /// MULTIPLE CURSORS ///
-- require('multiple-cursors').setup {
--   opts = {
--     pre_hook = function()
--       require('nvim-autopairs').disable()
--     end,
--     post_hook = function()
--       require('nvim-autopairs').enable()
--     end,
--   }
-- }
-- vim.keymap.set({'n', 'i', 'v'}, "<S-Up>", "<CMD>MultipleCursorsAddUp<CR>")
-- vim.keymap.set({'n', 'i', 'v'}, "<S-Down>", "<CMD>MultipleCursorsAddDown<CR>")
-- vim.keymap.set({'n', 'i', 'v'}, "<leader>m", "<CMD>MultipleCursorsAddVisualArea<CR>")
-- vim.keymap.set({'n', 'i', 'v'}, "<leader>k", "<CMD>MultipleCursorsLock<CR>")
-- vim.keymap.set({'n', 'i', 'v'}, "<leader>|", function() require('multiple-cursors').align() end)

-- /// INITIALIZED PLUGINS - NO CONFIG --- [COMMENT, WHICH-KEY] ///
require('Comment').setup {}
require('which-key').setup {}
require('stay-in-place').setup {}

-- vim: ts=2 sts=2 sw=2 et
