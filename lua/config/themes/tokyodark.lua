return {
    "tiagovla/tokyodark.nvim",
    -- priority = 1000,
    lazy = true,
    opts = {
        -- custom options here
        transparent_background = false, -- set background to transparent
        gamma = 0.9, -- adjust the brightness of the theme
        styles = {
            comments = { italic = true }, -- style for comments
            keywords = { italic = true, bold = true }, -- style for keywords
            identifiers = { italic = false, bold = true }, -- style for identifiers
            functions = { bold = true }, -- style for functions
            variables = {}, -- style for variables
        },
        -- custom_highlights = {} or function(highlights, palette) return {} end, -- extend highlights
        -- custom_palette = {} or function(palette) return {} end,            -- extend palette
        terminal_colors = true, -- enable terminal colors
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd([[colorscheme tokyodark]])
    end,
}
