-- example lazy.nvim install setup
return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local lackluster = require("lackluster")

        local color = lackluster.color -- blue, green, red, orange, black, lack, luster, gray1-9

        -- setup before set colorscheme
        lackluster.setup({
            -- You can overwrite the following syntax colors by setting them to one of...
            --   1) a hexcode like "#a1b2c3" for a custom color
            --   2) "default" or nil will just use whatever lackluster's default is.
            tweak_syntax = {
                string = "default",
                -- string = "#a1b2c3", -- custom hexcode
                -- string = color.green, -- lackluster color
                string_escape = "default",
                comment = "default",
                builtin = "default", -- builtin modules and functions
                type = "default",
                keyword = "default",
                keyword_return = "default",
                keyword_exception = "default",
            },
            -- You can overwrite the following background colors by setting them to one of...
            --   1) a hexcode like "#a1b2c3" for a custom color
            --   2) "none" for transparency
            --   3) "default" or nil will just use whatever lackluster's default is.
            tweak_background = {
                normal = 'none', -- main background
                -- normal = 'none',    -- transparent
                -- normal = '#a1b2c3',    -- hexcode
                -- normal = color.green,    -- lackluster color
                telescope = 'default', -- telescope
                menu = 'default', -- nvim_cmp, wildmenu ... (bad idea to transparent)
                popup = 'default', -- lazy, mason, whichkey ... (bad idea to transparent)
            },
        })

        -- colorscheme must be set after after setup()!
        vim.cmd.colorscheme("lackluster-mint")
    end,
    -- init = function()
    --     vim.cmd.colorscheme("lackluster")
    --     -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
    --     -- vim.cmd.colorscheme("lackluster-mint")
    -- end,
}
