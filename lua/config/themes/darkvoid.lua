return {
    "aliqyan-21/darkvoid.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("darkvoid").setup({
            transparent = true,
            glow = true,
            show_end_of_buffer = true,
            colors = {
                fg = "#c0c0c0",
                bg = "#4c4c4c",
                cursor = "#101015",
                line_nr = "#1c1c1c",
                visual = "#101015",
                comment = "#585858",
                func = "#9d7aa7",
                kw = "#7085a0",
                --string = "#2d735d",
                string = "#6b8e85",
                identifier = "#b1b1b1",
                type = "#267f6a",
                type_builtin = "#2d735d", -- current
                -- type_builtin = "#8cf8f7", -- glowy blue old (was present by default before type_builtin was introduced added here for people who may like it)
                search_highlight = "#1bfd9c",
                operator = "#1bfd9c",
                bracket = "#e6e6e6",
                preprocessor = "#4b8902",
                bool = "#66b2b2",
                constant = "#b2d8d8",
                bufferline_selection = "#1bfd9c",
                -- enable or disable specific plugin highlights
                plugins = {
                    gitsigns = true,
                    nvim_cmp = false,
                    treesitter = true,
                    nvimtree = true,
                    telescope = true,
                    lualine = false,
                    bufferline = true,
                    oil = true,
                    whichkey = true,
                    nvim_notify = true,
                },
            },
        })
    end,
}
