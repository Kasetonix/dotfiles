-- /// LSP.LUA | plugins responsible for LSP support ///

return {
  -- Mason - package manager for LSPs
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  'neovim/nvim-lspconfig', -- LSP Configuration & Plugins
  'folke/neodev.nvim',     -- Support for init.lua and plugin dev
  { 'hrsh7th/nvim-cmp',    -- Autocompletion
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
