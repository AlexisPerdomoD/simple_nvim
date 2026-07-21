local M = { 'Everblush/everblush.nvim', name = 'everblush' }
M.config = function()
    local t = require 'everblush'
    t.setup {

        -- Default options
        override = {},
        transparent_background = false,

        -- Configuration examples

        -- -- Override the default highlights using Everblush or other colors
        -- override = {
        --     Normal = { fg = '#ffffff', bg = 'comment' },
        -- },

        -- Set transparent background
        -- transparent_background = true,

        -- Set contrast for nvim-tree highlights
        -- nvim_tree = {
        --     contrast = true,
        -- },
    }

    vim.cmd [[colorscheme everblush]]
end
return M
