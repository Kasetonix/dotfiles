-- /// THEMES.LUA | plugins responsible for theming ///

-- Colorscheme
vim.cmd.colorscheme 'onedark'

-- lualine - status line
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,

    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },

  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
}

-- transparent - added transparency
require("transparent").setup {
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
    'NvimTreeNormal', 'NvimTreeNormalNC', 'NvimTreeEndOfBuffer', 'NvimTreeVertSplit',
  },
  -- exclude_groups = {}, -- table: groups you don't want to clear
}

require('ibl').setup {
  indent = { char = "│" },
  -- indent = { char = "┊" },
}

-- vim: ts=2 sts=2 sw=2 et
