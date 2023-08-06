-- /// FUNCTIONS.LUA | plugins responsible for adding functionality to neovim ///

-- /// TELESCOPE ///
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
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
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", color = "warning", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "info", alt = { "INFO" } },
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
    error = { "DiagnosticError", "ErrorMsg", "#E06C75" },
    warning = { "DiagnosticWarn", "WarningMsg", "#E5C07B" },
    info = { "DiagnosticInfo", "#56B6C2" },
    default = { "Identifier", "#ABB2BF" },
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

-- /// NVIM-TREE ///
-- disabling netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
  view = { width = 30, },         -- set width
  filters = { dotfiles = false, }, -- Showing dotfiles
}

vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree "}) -- opening the nvim-tree

-- /// INITIALIZED PLUGINS - NO CONFIG --- [AUTOCLOSE, COMMENT, WHICH-KEY] ///
require('autoclose').setup {}
require('Comment').setup {}
require('which-key').setup {}

-- vim: ts=2 sts=2 sw=2 et
