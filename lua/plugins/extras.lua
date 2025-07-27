return {
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        -- priority = 1000,
        config = function() require('alpha').setup(require('alpha.themes.startify').config) end,
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                { path = '${3rd}/vim/library', word = 'vim%.fn' },
            },
        },
    },
    {
        'mustache/vim-mustache-handlebars',
        lazy = true,
        config = true,
    },
    {
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
        config = function()
            require('nvim-ts-autotag').setup {
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            }
        end,
    },
    {
        'christoomey/vim-tmux-navigator',
    },
}
