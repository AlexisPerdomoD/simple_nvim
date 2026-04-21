local TS = { 'nvim-treesitter/nvim-treesitter' }
TS.lazy = false
TS.branch = 'main'
TS.build = ':TSUpdate'

local TSObj = { 'nvim-treesitter/nvim-treesitter-textobjects' }
TSObj.dependencies = { 'nvim-treesitter/nvim-treesitter' }
TSObj.branch = 'main'
TSObj.lazy = false
TSObj.init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
end

TSObj.config = function()
    local tsobj = require 'nvim-treesitter-textobjects'
    tsobj.setup { select = { lookahead = true } }
end

return { TS, TSObj }
