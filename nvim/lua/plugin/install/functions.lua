-- /// FUNCTIONS.LUA | plugins responsible for adding functionality to neovim ///

return {
  'chiel92/vim-autoformat',   -- autoformatting
  'ap/vim-css-color',         -- Color codes coloring in vim
  'nvim-tree/nvim-tree.lua',  -- file manager
  'm4xshen/autoclose.nvim',   -- automatically closing brackets
  'folke/trouble.nvim',       -- list of warnings / errors
  'folke/todo-comments.nvim', -- highlight TODO, FIX, etc. commments
  'numToStr/Comment.nvim',    -- comment plugin (gc/gb)
  'folke/which-key.nvim',     -- showing keybinds

  -- Telescope
  { 'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
