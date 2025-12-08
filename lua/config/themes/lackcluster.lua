local M = { 'slugbyte/lackluster.nvim' }
M.lazy = false
M.priority = 1000
M.custom_palette = {
    azure = '#37478a',
    cyan = '#22d3ee',
    slate = '#64748b',
    teal = '#5eead4',
    blue = '#2d3b42',
    red = '#ef4444',
    red_soft = '#f87171',
    rose = '#fb7185',
}

M.config = function()
    local theme = require 'lackluster'
    local palette = M.custom_palette
    palette.teal = theme.color.green

    theme.setup {
        disable_plugin = {},
        tweak_syntax = {
            string = palette.blue,
            string_escape = palette.cyan,
            comment = palette.slate,
            builtin = palette.rose,
            type = theme.color.green,
            keyword = palette.red,
            keyword_return = palette.red_soft,
            keyword_exception = palette.rose,
        },

        tweak_background = {
            normal = 'default',
            telescope = 'default',
            menu = 'default',
            popup = 'default',
        },

        tweak_highlight = {
            -- ===== VARIABLES ====
            ['@variable'] = {
                overwrite = true,
                fg = theme.color.luster,
            },

            ['@lsp.type.parameter'] = {
                overwrite = true,
                fg = theme.color.lack,
            },

            ['@type.builtin'] = {
                overwrite = true,
                fg = theme.color.lack,
            },

            -- ===== STRINGS =====
            ['@string'] = {
                overwrite = true,
                fg = palette.cyan,
            },

            ['@string.escape'] = {
                overwrite = true,
                fg = palette.cyan,
            },

            -- ===== COMMENTS =====
            ['@comment'] = {
                overwrite = true,
                fg = palette.slate,
                italic = true,
            },

            -- ===== KEYWORDS =====
            ['@keyword'] = {
                overwrite = true,
                fg = palette.red_soft,
                italic = true,
            },

            ['@keyword.return'] = {
                overwrite = true,
                fg = palette.red,
            },

            ['@keyword.exception'] = {
                overwrite = true,
                fg = palette.red,
            },

            ['@keyword.modifier'] = {
                overwrite = true,
                fg = palette.red_soft,
            },

            ['@keyword.import'] = {
                overwrite = true,
                fg = palette.red_soft,
            },

            ['@keyword.conditional'] = {
                overwrite = true,
                fg = theme.color.blue,
                italic = true,
            },

            ['@keyword.operator'] = {
                overwrite = true,
                fg = theme.color.blue,
                italic = true,
            },

            -- ===== CLASSES / TYPES =====
            ['@type'] = {
                overwrite = true,
                fg = palette.azure,
            },

            ['@type.definition'] = {
                overwrite = true,
                fg = palette.azure,
            },

            ['@lsp.type.class'] = {
                overwrite = true,
                fg = palette.blue,
            },

            ['@lsp.type.interface'] = {
                overwrite = true,
                fg = palette.azure,
                italic = true,
            },

            -- ===== FUNCTIONS / METHODS =====
            ['@function'] = {
                overwrite = true,
                fg = palette.teal,
            },

            ['@function.method'] = {
                overwrite = true,
                fg = palette.teal,
            },

            ['@lsp.type.method'] = {
                overwrite = true,
                fg = palette.teal,
            },

            -- JAVA SPECIFIC
            ['@lsp.type.modifier.java'] = {
                overwrite = true,
                fg = theme.color.blue,
                italic = true,
            },

            ['@lsp.type.namespace.java'] = {
                overwrite = true,
                fg = palette.slate,
                italic = true,
            },

            ['@lsp.variable.java'] = {
                overwrite = true,
                fg = theme.color.luster,
            },

            ['@keyword.conditional.java'] = {
                overwrite = true,
                fg = theme.color.blue,
                italic = true,
            },

            ['@keyword.operator.java'] = {
                overwrite = true,
                fg = theme.color.blue,
                italic = true,
            },

            ['@keyword.repeat.java'] = {
                overwrite = true,
                fg = theme.color.blue,
                italic = true,
            },

            ['@lsp.type.parameter.java'] = {
                overwrite = true,
                fg = theme.color.lack,
            },

            ['@type.builtin.java'] = {
                overwrite = true,
                fg = theme.color.lack,
            },
        },
    }

    vim.cmd.colorscheme 'lackluster'
end

return M
