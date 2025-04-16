return {
    "rafamadriz/neon",
    lazy = true,
    --priority = 1000,
    config = function()
        vim.g.neon_style = "dark" -- dark, light, default, doom
        -- vim.g.neon_italic_comment = false
        vim.g.neon_italic_keyword = true
        vim.g.neon_italic_boolean = true
        vim.g.neon_bold = true
        -- vim.g.neon_italic_function = true
        vim.g.neon_transparent = false
        -- vim.cmd.colorscheme "neon"
        require('utils.bg_color_setuper').bg_setuper(false, true)
    end
}
