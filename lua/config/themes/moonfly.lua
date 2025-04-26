return {
    "bluz71/vim-moonfly-colors",
    dependencies = { "hrsh7th/nvim-cmp" },
    name = "moonfly",
    lazy = true,
    config = function()
        -- cursor
        vim.g.moonflyCursorColor = true

        -- normal float window theme
        vim.g.moonflyNormalFloat = true

        -- terminal
        vim.g.moonflyTerminalColors = true
        vim.g.moonflyTransparent = false
        vim.cmd([[ colorscheme moonfly ]])
        require 'utils.bg_color_setuper'.bg_setuper(false, true)
    end,
}
