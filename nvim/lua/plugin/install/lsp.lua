-- /// LSP.LUA | plugins responsible for LSP support ///

return {
  -- Mason - package manager for LSPs
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  'neovim/nvim-lspconfig',    -- LSP Configuration & Plugins
  'folke/lazydev.nvim',       -- LuaLS and nvim config support
  'onsails/lspkind.nvim',     -- Adds icons to completion
  'SmiteshP/nvim-navic',      -- show code context in statusline
  'SmiteshP/nvim-navbuddy',   -- symbol navigation popup

  { 'hrsh7th/nvim-cmp',       -- Autocompletion
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
