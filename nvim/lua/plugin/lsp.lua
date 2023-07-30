-- /// LSP.LUA | plugins responsible for LSP support ///

-- /// MASON ///
require('mason').setup {}
require('mason-lspconfig').setup {}

local lspconfig = require 'lspconfig' -- makes writeing the config easier

-- /// ON_ATTACH ///
local on_attach = function(_, bufnr)
  -- Creating a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local lspmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  lspmap('<leader>r', vim.lsp.buf.rename, 'Rename')
  lspmap('gd', vim.lsp.buf.definition, 'Go to definition')
  lspmap('gr', require('telescope.builtin').lsp_references, 'Go to references')
  lspmap('gI', vim.lsp.buf.implementation, 'Go to implementation')
  lspmap('<leader>s', require('telescope.builtin').lsp_document_symbols, 'Symbols')

  -- See `:help K` for why this keymap
  lspmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- /// CAPABILITIES ///
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- /// LUA ///
lspconfig.lua_ls.setup { -- Lua
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },

      telemetry = { enable = false, },
    },
  },
}

-- /// C/C++ ///
lspconfig.clangd.setup { -- C/C++
  on_attach = on_attach,
  capabilities = capabilities,
}

-- /// RUST ///
lspconfig.rust_analyzer.setup { -- rust
  on_attach = on_attach,
  capabilities = capabilities,
}

-- /// NVIM-CMP | LUASNIP ///
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

luasnip.config.setup {}

-- vim: ts=2 sts=2 sw=2 et
