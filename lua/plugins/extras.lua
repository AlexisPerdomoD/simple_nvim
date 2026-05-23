return {
    -- themes
    require 'config.themes',
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
            local autotag = require 'nvim-ts-autotag'
            autotag.setup {
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
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },

    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        event = 'VeryLazy',
        version = 'v2.*',
        dependencies = { 'rafamadriz/friendly-snippets' },
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
        config = function()
            -- JAVA LSP AUTOCOMAND SPECIFIC CONFIGURATION
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function(args)
                    local jdtls = require 'jdtls'
                    local lang_setup = require 'config.plugin.jdtls'
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    local cfg = lang_setup:get_config(capabilities)
                    jdtls.start_or_attach(cfg)
                end,
            })
        end,
    },
}
