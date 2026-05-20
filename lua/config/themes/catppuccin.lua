local T = { 'catppuccin/nvim' }
T.name = 'catppuccin'
T.config = function()
    local theme = require 'catppuccin'
    local bg = require 'utils.bg_color_setuper'

    theme.setup {
        float = { solid = true, transparent = true },
        auto_integrations = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { 'italic' },
                hints = { 'italic' },
                warnings = { 'italic' },
                information = { 'italic' },
                ok = { 'italic' },
            },
            underlines = {
                errors = { 'underline' },
                hints = { 'underline' },
                warnings = { 'underline' },
                information = { 'underline' },
                ok = { 'underline' },
            },
            inlay_hints = {
                background = true,
            },
        },
        treesitter = true,
    }
    vim.cmd 'colorscheme catppuccin-macchiato'
    bg:start(false, true)
end

return T
