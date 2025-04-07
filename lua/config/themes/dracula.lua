return {
    "Mofiqul/dracula.nvim",
    lazy = true,
    config = function()
        require("dracula").setup({
            italic_comment = true,
            transparent_bg = false,
        })

        -- vim.cmd("colorscheme dracula")
    end,
}
