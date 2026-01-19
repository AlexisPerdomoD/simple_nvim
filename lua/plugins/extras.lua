return {
    -- themes
    require 'config.themes',
    -- add mapping navigation support
    { 'christoomey/vim-tmux-navigator' },
    -- adds better java support for jdtls
    { 'mfussenegger/nvim-jdtls',       ft = 'java' },
    -- adds support to lua into nvim
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        -- lazy = true,
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                -- { path = '${3rd}/vim/library', word = 'vim%.fn' },
            },
        },
    },
    -- adds support to close tags in html
    {
        'windwp/nvim-ts-autotag',
        ft = { 'html', 'jsx', 'tsx' },
        config = function()
            --- @diagnostic disable-next-line
            require('nvim-ts-autotag').setup {
                opts = {
                    -- Defaults
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            }
        end,
    },
}
