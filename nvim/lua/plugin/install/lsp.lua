-- /// LSP.LUA | plugins responsible for LSP support ///

return {
  -- Mason - package manager for LSPs
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  'neovim/nvim-lspconfig',    -- LSP Configuration & Plugins
  'folke/neodev.nvim',        -- support for init.lua and plugin development
  -- 'simrat39/rust-tools.nvim', -- LSP rust support made easier
  'onsails/lspkind.nvim',     -- Adds icons to completion

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
