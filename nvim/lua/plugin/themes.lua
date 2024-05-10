-- /// THEMES.LUA | plugins responsible for theming ///

-- Colorscheme
vim.cmd.colorscheme 'onedark'


-- lualine - status line
require('lualine').setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  extensions = {'nvim-tree'},

  sections = {
    lualine_a = {'mode'},
    lualine_b = {{
      'filename',
      icon = "󰈙",
      symbols = {
        modified = "",
        readonly = "",
        unnamed = "󰟢",
      },
    }},
    lualine_c = {'navic'},
    lualine_x = {''},
    lualine_y = {'filetype'},
    lualine_z = {'location'}
  },

  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {{
      'filename',
      icon = "󰈙",
      symbols = {
        modified = "",
        readonly = "",
        unnamed = "󰟢",
      },
    }},
    lualine_c = {'navic'},
    lualine_x = {''},
    lualine_y = {'filetype'},
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
