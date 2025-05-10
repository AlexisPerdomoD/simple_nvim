return {
    'echasnovski/mini.animate',
    version = '*',
    lazy = vim.g.neovide ~= nil,
    config = function()
        require('mini.animate').setup({
            -- Cursor path
            cursor = {
                -- Whether to enable this animation
                enable = true,

                -- Timing of animation (how steps will progress in time)
                timing = function() return 6 end --<function: implements linear total 250ms animation duration>,

                -- Path generator for visualized cursor movement
            },

            -- Vertical scroll
            scroll = {
                -- Whether to enable this animation
                enable = true,

                -- Timing of animation (how steps will progress in time)
                timing = function() return 6 end --<function: implements linear total 250ms animation duration>,

                -- Subscroll generator based on total scroll
                --subscroll = --<function: implements equal scroll with at most 60 steps>,
            },

            -- Window resize
            resize = {
                -- Whether to enable this animation
                enable = true,

                -- Timing of animation (how steps will progress in time)
                timing = function() return 1 end --<function: implements linear total 250ms animation duration>,

                -- Subresize generator for all steps of resize animations
                -- subresize = --<function: implements equal linear steps>,
            },

            -- Window open
            open = {
                -- Whether to enable this animation
                enable = false,

                -- Timing of animation (how steps will progress in time)
                timing = function() return 10 end --<function: implements linear total 250ms animation duration>,

                -- Floating window config generator visualizing specific window
                -- winconfig = --<function: implements static window for 25 steps>,

                -- 'winblend' (window transparency) generator for floating window
                --winblend = --<function: implements equal linear steps from 80 to 100>,
            },

            -- Window close
            close = {
                -- Whether to enable this animation
                enable = false,

                -- Timing of animation (how steps will progress in time)
                timing = function() return 10 end --<function: implements linear total 250ms animation duration>,

                -- Floating window config generator visualizing specific window
                --   winconfig = --<function: implements static window for 25 steps>,

                -- 'winblend' (window transparency) generator for floating window
                -- winblend = --<function: implements equal linear steps from 80 to 100>,
            }
        })
    end
}
