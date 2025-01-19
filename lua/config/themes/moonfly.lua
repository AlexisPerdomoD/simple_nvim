return {
    "bluz71/vim-moonfly-colors",
    dependencies = { "hrsh7th/nvim-cmp" },
    name = "moonfly",
    lazy = true,
    --event = 'VeryLazy',
    -- priority = 1000,
    config = function()
        -- cursor
        vim.g.moonflyCursorColor = true

        -- normal float window theme
        vim.g.moonflyNormalFloat = true

        -- terminal
        vim.g.moonflyTerminalColors = false
        vim.g.moonflyTransparent = true
        vim.cmd([[ colorscheme moonfly ]])
    end,
}
