return {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
        require("dracula").setup({
            italic_comment = true,
            transparent_bg = vim.g.neovide == nil,
        })

        vim.cmd("colorscheme dracula-soft")
    end,
}
