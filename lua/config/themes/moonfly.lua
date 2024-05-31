function Toggle_transparency()
    -- reload theme after transparency
    if Transparency then
        Transparency = false
    else
        Transparency = true
    end
    vim.cmd('colorscheme moonfly')
    --print("Transparency: " .. tostring(vim.g.moonflyTransparent))
end


local function get_transparency()
    if Transparency then
        return false
    else
        return true
    end
end
return {
    "bluz71/vim-moonfly-colors",
    dependencies = { 'hrsh7th/nvim-cmp' },
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
        -- cursor
        vim.g.moonflyCursorColor = true

        -- normal float window theme
        vim.g.moonflyNormalFloat = true

        -- terminal
        vim.g.moonflyTerminalColors = true
        print("Transparency: " .. tostring(vim.g.moonflyTransparent) .. tostring(Transparency))
        -- transparency
        vim.g.moonflyTransparent = get_transparency()
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
        -- moonfly transparency toggle keymap
        vim.api.nvim_set_keymap('n', '<leader>tb', ':lua Toggle_transparency()<CR>', { noremap = true, silent = true })

        --Lua:
        vim.cmd [[colorscheme moonfly]] -- Reapplies the colorscheme -- colorscheme = 'colorscheme moonfly'
    end
}
