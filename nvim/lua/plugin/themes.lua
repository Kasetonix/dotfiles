-- /// THEMES.LUA | plugins responsible for theming ///

-- Colorscheme
vim.cmd.colorscheme 'tokyonight-storm'

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

-- ibl -- adds indent lines
require('ibl').setup {
  indent = { char = "│" },
  -- indent = { char = "┊" },
  scope = { show_start = false, show_end = false },
}

-- dressing - changes the look of subwindows
require("dressing").setup({
  input = {
    default_prompt = "➜ ",
    trim_prompt = true,

    title_pos = "center",
    border = "rounded",
    relative = "cursor",

    prefer_width = 0.3,
    max_width = { 80, 0.6 },
    min_width = { 20, 0.15 },
  },
})

-- vim: ts=2 sts=2 sw=2 et
