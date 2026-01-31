local M = { 'nvim-lualine/lualine.nvim' }
M.dependencies = { 'nvim-tree/nvim-web-devicons' }
M.config = function()
    local lualine = require 'lualine'
    lualine.setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = true,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            },
        },
        sections = {
            lualine_a = { 'branch' },
            lualine_b = { 'diff' },
            lualine_c = {},
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'lsp_status', 'location' },
        },

        inactive_sections = {},
        tabline = {
            lualine_a = { 'mode' },
            lualine_b = { { 'filename', path = 1, shorting_target = 120 } },
            lualine_c = { 'diagnostics' },
            lualine_x = {},
            lualine_y = {
                {
                    'datetime',
                    -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
                    style = 'default',
                },
            },
            lualine_z = { 'tabs' },
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    }
end

return M
