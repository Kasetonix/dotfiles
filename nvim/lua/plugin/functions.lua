-- /// FUNCTIONS.LUA | plugins responsible for adding functionality to neovim ///

-- /// TODO-COMMENTS ///
require("todo-comments").setup {
  signs = true,
  sign_priority = 8,

  keywords = {
    FIX  = { icon = " ", color = "error", alt = { "BUG", "ERR", "ERROR" }, },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", color = "warning", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "info", alt = { "INFO" } },
  },

  gui_style = { fg = "NONE", bg = "BOLD", },
  merge_keywords = true,
  highlight = {
    multiline = true,
    multiline_pattern = "^.",
    multiline_context = 10,
    before = "",
    keyword = "wide",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*:]],
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
    pattern = [[\b(KEYWORDS):]],
  },
}

-- /// NVIM-TREE ///
-- disabling netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup {
  view = { width = 30, },
  filters = { dotfiles = false, },
}
vim.keymap.set("n", "<leader>f", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree "})

-- /// AUTOCLOSE ///
require('autoclose').setup {
  options = {
    disabled_filetypes = { "text", "markdown", "" },
  },
}

-- /// INITIALIZED PLUGINS - NO CONFIG --- [WHICH-KEY, STAY-IN-PLACE] ///
require('which-key').setup {}
require('stay-in-place').setup {}

-- vim: ts=2 sts=2 sw=2 et
