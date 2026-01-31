return {
    {
        'HiPhish/rainbow-delimiters.nvim',
        lazy = true,
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require 'rainbow-delimiters'

            ---@type rainbow_delimiters.config
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                priority = {
                    [''] = 110,
                    lua = 210,
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end,
    },

    -- {
    --     'nvim-treesitter/nvim-treesitter',
    --     lazy = false,
    --     build = ':TSUpdate',
    --     -- opts = {
    --     --     ensure_installed = {},
    --     --     auto_install = true,
    --     --     fold = {
    --     --         enable = true,
    --     --     },
    --     --     highlight = {
    --     --         enable = true,
    --     --     },
    --     --     indent = {
    --     --         enable = true,
    --     --     },
    --     --     -- textobjects = {
    --     --     --     enable = true,
    --     --     --     select = {
    --     --     --         enable = true,
    --     --     --         lookahead = true,
    --     --     --         keymaps = {
    --     --     --             ['tf'] = '@function.outer',
    --     --     --             ['taf'] = '@function.inner',
    --     --     --             ['tc'] = '@conditional.outer',
    --     --     --             ['tac'] = '@conditional.inner',
    --     --     --             ['tl'] = '@loop.outer',
    --     --     --             ['tal'] = '@loop.inner',
    --     --     --         },
    --     --     --     },
    --     --     -- },
    --     -- },
    -- },
    -- {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     dependencies = { 'nvim-treesitter/nvim-treesitter' }
    -- }


    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true },
                textobjects = {
                    select = { enable = true },
                },
            })
        end,
    },
}
