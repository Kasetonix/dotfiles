-- /// KEYS.LUA | Custom keybinds (excluding plugins) /// 

-- Setting the leader to space
vim.g.mapleader = " "

-- Shortcut for opening lazy.lua and mason.nvim
vim.keymap.set('n', "<leader>l", vim.cmd.Lazy , { desc = "Open lazy.lua" })
vim.keymap.set('n', "<leader>L", vim.cmd.Mason, { desc = "Open mason.nvim" })

-- Navbuddy
vim.keymap.set('n', "<leader>n", vim.cmd.Navbuddy, { desc = "Open navbuddy" })

-- vim: ts=2 sts=2 sw=2 et
