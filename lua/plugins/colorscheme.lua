local colorschemes = {
    {
        'Mofiqul/vscode.nvim',
        lazy = true,
        name = 'vscode',
        config = function()
            vim.cmd 'colorscheme vscode'
        end,
    },
    {
        'kbraggins/duskhaven.nvim',
        lazy = true,
        name = 'duskhaven',
        opts = {
            italic = false,
            bold = false,
            transparent = true,
            palette = { orange = '#ff8c42' },
            highlight_overrides = {
                Comment = { fg = '#7a7f9e', italic = true },
            },
        },
        config = function(_, opts)
            local theme = require 'duskhaven'
            vim.g.__extra_colorscheme_bg_transparency = opts.transparency
            theme.setup(opts)

            vim.keymap.set('n', '<leader>t', function()
                vim.g.__extra_colorscheme_bg_transparency = not vim.g.__extra_colorscheme_bg_transparency
                opts.transparent = vim.g.__extra_colorscheme_bg_transparency
                theme.setup(opts)
            end, { desc = 'toggle background transparency' })

            vim.cmd 'colorscheme duskhaven'
        end,
    },
    {
        'Biscuit-Theme/nvim',
        name = 'biscuit',
        lazy = true,
        config = function()
            vim.cmd 'colorscheme biscuit'
        end,
    },
}

if vim.g.__extra_colorscheme_name then
    for _, c in ipairs(colorschemes) do
        if c.name == vim.g.__extra_colorscheme_name then
            c.lazy = false
            c.priority = 1000
            break
        end
    end
end

return colorschemes
