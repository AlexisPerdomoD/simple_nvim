return {
    -- themes
    require 'config.themes',
    -- add mapping navigation support
    { 'christoomey/vim-tmux-navigator' },
    -- adds better java support for jdtls
    { 'mfussenegger/nvim-jdtls', ft = 'java' },
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
        'numToStr/Comment.nvim',
        lazy = true,
        config = function()
            local c = require 'Comment'
            c.setup {
                ---Add a space b/w comment and the line
                padding = true,
                ---Whether the cursor should stay at its position
                sticky = true,
                ---Lines to be ignored while (un)comment
                ignore = nil,
                ---LHS of toggle mappings in NORMAL mode
                toggler = {
                    ---Line-comment toggle keymap
                    line = 'cl',
                    ---Block-comment toggle keymap
                    block = 'gbc',
                },
                ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                opleader = {
                    ---Line-comment keymap
                    line = '/gc',
                    ---Block-comment keymap
                    block = '/gb',
                },
                ---LHS of extra mappings
                extra = {
                    ---Add comment on the line above
                    above = 'gk',
                    ---Add comment on the line below
                    below = 'gj',
                    ---Add comment at the end of line
                    eol = 'gl',
                },
                ---Enable keybindings
                ---NOTE: If given `false` then the plugin won't create any mappings
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = true,
                },
                ---Function to call before (un)comment
                pre_hook = nil,
                ---Function to call after (un)comment
                post_hook = nil,
            }
        end,
    },
}
