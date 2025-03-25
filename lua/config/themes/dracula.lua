return {
    "Mofiqul/dracula.nvim",
    -- priority = 1000,
    lazy = true,
    config = function()
        require("dracula").setup({
            italic_comment = true,
            transparent_bg = false,
        })

        -- vim.cmd("colorscheme dracula")
    end,
}
