-- /// LSP.LUA | plugins responsible for LSP support ///

-- /// MASON ///
require("mason").setup {
  ui = {
    border = "rounded";
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  };
}

require('mason-lspconfig').setup {}
require('lazydev').setup {}

local lspconfig = require("lspconfig") -- makes writing the config easier
local navic = require("nvim-navic")
local navbuddy = require("nvim-navbuddy")
local nb_actions = require("nvim-navbuddy.actions")

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

  -- navic/navbuddy setup
  if _.server_capabilities.documentSymbolProvider then
    navic.attach(_, bufnr)
    navbuddy.attach(_, bufnr)
    vim.keymap.set('n', "<leader>n", vim.cmd.Navbuddy, { desc = "Open navbuddy" })
  end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- /// CAPABILITIES ///
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- /// General ///
vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = capabilities
})

-- /// Lua ///
vim.lsp.enable('lua_ls')
vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      telemetry = { enable = false, },
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}

-- /// C/C++ ///
vim.lsp.config['clangd'] = {
  on_attach = on_attach,
  capabilities = capabilities
}

-- /// Rust ///
vim.lsp.config['rust_analyzer'] = {
  on_attach = on_attach,
  capabilities = capabilities
}

-- /// Python ///
vim.lsp.config['pyright'] = {
  on_attach = on_attach,
  capabilities = capabilities
}

vim.lsp.config['tinymist'] = {
  on_attach = on_attach,
  capabilities = capabilities
}

-- General diagnostics handler
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.diagnostic.on_publish_diagnostics

-- Removing underlines
vim.diagnostic.config({virtual_text = true, underline = false})

-- /// NVIM-CMP | LUASNIP ///
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

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

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

luasnip.config.setup {}

-- /// navic ///
navic.setup {
  lsp = { auto_attach = true, },
  separator = " → ",
  click = true,
}

navbuddy.setup {
  window = {
    border = "rounded",
    sections = {
      left = { size = "20%", border = nil, },
      mid = { size = "40%", border = nil, },
      right = { border = nil, preview = "leaf", }
    },
  },

  node_markers = {
    icons = {
      leaf = " →",
      leaf_selected = " →",
      branch = " ",
    },
  },

  use_default_mappings = false,
  mappings = {
    ["<esc>"] = nb_actions.close(),
    ["q"] = nb_actions.close(),
    ["<enter>"] = nb_actions.select(),

    -- Movement
    ["<Down>"] = nb_actions.next_sibling(),
    ["<Up>"] = nb_actions.previous_sibling(),
    ["<Left>"] = nb_actions.parent(),
    ["<Right>"] = nb_actions.children(),
    ["0"] = nb_actions.root(),

    ["p"] = nb_actions.toggle_preview(),

    -- Actions
    ["y"] = nb_actions.yank_name(),  -- Yank the name to system clipboard "+
    ["Y"] = nb_actions.yank_scope(), -- Yank the scope to system clipboard "+
    ["r"] = nb_actions.rename(),     -- Rename currently focused symbol
    ["d"] = nb_actions.delete(),     -- Delete scope
    ["gc"] = nb_actions.comment(),   -- Comment out current scope
    ["t"] = nb_actions.telescope(),  -- Fuzzy finder at current level.

    ["?"] = nb_actions.help(),       -- Open mappings help window
  },
  icons = {
    File          = "󰈙 ",
    Module        = " ",
    Namespace     = "󰌗 ",
    Package       = " ",
    Class         = "󰌗 ",
    Method        = "󰆧 ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "󰕘 ",
    Interface     = "󰕘 ",
    Function      = "󰊕 ",
    Variable      = "󰆧 ",
    Constant      = "󰏿 ",
    String        = "ℓ ",
    Number        = "󰎠 ",
    Boolean       = "◩ ",
    Array         = "󰅪 ",
    Object        = "󰅩 ",
    Key           = "󰌋 ",
    Null          = "󰟢 ",
    EnumMember    = " ",
    Struct        = "󰌗 ",
    Event         = " ",
    Operator      = "󰆕 ",
    TypeParameter = "󰊄 ",
  },

  source_buffer = {
    follow_node = true,    -- Keep the current node in focus on the source buffer
    highlight = true,      -- Highlight the currently focused node
  },
}

-- vim: ts=2 sts=2 sw=2 et
