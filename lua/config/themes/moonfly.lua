return {
    "bluz71/vim-moonfly-colors",
    dependencies = { 'hrsh7th/nvim-cmp' },
    name = "moonfly",
     lazy = true,
    --event = 'VeryLazy',
    --priority = 1000,
    config = function()
        -- cursor
        vim.g.moonflyCursorColor = true

        -- normal float window theme
        vim.g.moonflyNormalFloat = true

        -- terminal
        vim.g.moonflyTerminalColors = false
        vim.g.moonflyTransparent = true
        -- add borders to hover
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "single"
            }
        )
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signatureHelp, {
                border = "single"
            }
        )
        vim.diagnostic.config({ float = { border = "single" } })

        -- config/plugins/cmp.lua
        local winhighlight = {
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
        }
        require('cmp').setup({
            window = {
                completion = require('cmp').config.window.bordered(winhighlight),
                documentation = require('cmp').config.window.bordered(winhighlight),
            }
        })
    end
}
