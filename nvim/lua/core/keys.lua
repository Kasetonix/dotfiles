-- /// KEYS.LUA | Custom keybinds (excluding plugins) /// 

-- Setting the leader to space
vim.g.mapleader = " "

-- Shortcut for opening lazy.lua
vim.keymap.set('n', "<leader>l", vim.cmd.Lazy , { desc = "Open lazy.lua" })

-- vim: ts=2 sts=2 sw=2 et
