-- /// KEYS.LUA | Custom keybinds (excluding plugins) /// 

-- Setting the leader to space
vim.g.mapleader = " "
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Shortcut for opening lazy.lua and mason.nvim
vim.keymap.set('n', "<leader>l", vim.cmd.Lazy , { desc = "Open lazy.lua" })
vim.keymap.set('n', "<leader>L", vim.cmd.Mason, { desc = "Open mason.nvim" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim: ts=2 sts=2 sw=2 et
