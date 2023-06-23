-- Core configuration
require("core.conf")        -- main config
require("core.conf-legacy") -- legacy vimscript config
require("core.keys")        -- keymaps 

-- Plugin-related configuration
require("plugin.lazy")      -- package manager init
require("plugin.themes")    -- themes + ui elements
require("plugin.functions") -- added functionality 
require("plugin.lsp")       -- lsp configuration

-- modeline - see ':help modeline'
-- vim: ts=2 sts=2 sw=2 et
