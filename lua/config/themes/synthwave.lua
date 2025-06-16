return {
    "samharju/synthweave.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000,
    config = function()
        vim.cmd.colorscheme("synthweave-transparent")
        -- require("utils.bg_color_setuper").bg_setuper(false, true)
    end,
}

--     {
--     "samharju/synthweave.nvim",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000,
--     config = function()
--         local synthweave = require("synthweave")
--         synthweave.setup({
--             transparent = true,
--             overrides = {
--                 -- override any group
--                 Identifier = { fg = "#f22f52" },
--             },
--             palette = {
--                 -- override palette colors, take a peek at synthweave/palette.lua
--                 bg0 = "#040404",
--             },
--         })
--         synthweave.load()
--     end,
-- }
