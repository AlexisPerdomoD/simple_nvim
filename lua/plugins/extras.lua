return {
    -- add mapping navigation support
    {
        'christoomey/vim-tmux-navigator',
    },

    -- adds support to lua into nvim
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
    -- adds support to close tags in html
    {
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
        config = function()
            --- @diagnostic disable-next-line
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
    -- This add animates the cursor
    {
        enabled = vim.g.neovide == nil,
        'sphamba/smear-cursor.nvim',
        opts = {
            cursor_color = '#ff8800',
            stiffness = 0.3,
            trailing_stiffness = 0.1,
            damping = 0.5,
            trailing_exponent = 5,
            never_draw_over_target = true,
            hide_target_hack = true,
            gamma = 1,
            time_interval = 10, -- milliseconds

            -- Smear cursor when switching buffers or windows.
            smear_between_buffers = true,

            -- Smear cursor when moving within line or to neighbor lines.
            -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
            smear_between_neighbor_lines = true,

            -- Draw the smear in buffer space instead of screen space when scrolling
            scroll_buffer_space = true,

            -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
            -- Smears will blend better on all backgrounds.
            -- legacy_computing_symbols_support = false,

            -- Smear cursor in insert mode.
            -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
            smear_insert_mode = true,
        },
    },
}
