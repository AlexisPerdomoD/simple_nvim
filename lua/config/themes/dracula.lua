return {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
        require("dracula").setup({
            italic_comment = true,
            transparent_bg = false,
        })

        vim.cmd("colorscheme dracula")
        require('utils.bg_color_setuper').bg_setuper(false, true)
    end,
}
