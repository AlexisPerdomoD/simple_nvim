local M = {
    "neanias/everforest-nvim",
    lazy = true,
    --  event = "VeryLazy",
    -- priority = 1000, -- make sure to load this before all the other start plugins
    --priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
    local everforest = require("everforest")
    everforest.setup({
        background = "hard",
        transparent_background_level = 0,
        float_style = "dim",
        inlay_hints_background = "dimmed",
        italics = true,
        disable_italic_comments = false,
        on_highlights = function(hl, _)
            hl["@string.special.symbol.ruby"] = { link = "@field" }
        end,
    })
    require('utils.bg_color_setuper').bg_setuper(false, true)
end

return M
