-- /// CONF.LUA | lua options ///

vim.o.hlsearch = false -- Set highlight on search
vim.o.sh = "fish" -- set default vim shell to fish
vim.wo.number = true -- setting line numbers
vim.o.mouse = 'a' -- enabling mouse
vim.o.clipboard = 'unnamedplus' -- using os clipboard
vim.o.breakindent = true -- enabling break indent
vim.o.undofile = true -- saving undo history
vim.wo.signcolumn = 'yes' -- turning on the signcolumn
vim.o.completeopt = 'menuone,noselect' -- Better autocompletion
vim.o.termguicolors = true -- Using terminal colors
vim.loader.enable() -- optimizes loading plugins

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Tab length and behavior
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlighting when yanking
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- vim: ts=2 sts=2 sw=2 et
