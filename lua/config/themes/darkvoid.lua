T = { 'aliqyan-21/darkvoid.nvim' }
T.lazy = true
T.config = function()
    require('darkvoid').setup {
        transparent = true,
        glow = true,
        show_end_of_buffer = true,
        colors = {
            fg = '#c0c0c0',
            bg = '#101015',
            cursor = '#c084f5',
            line_nr = '#2a2a2f',
            visual = '#3a204a', -- más contraste modo visual
            comment = '#7a5f7a', -- más claro y legible
            func = '#d06fa0',
            kw = '#9d7aa7',
            string = '#6b8e85',
            identifier = '#b1b1b1',
            type = '#267f6a',
            type_builtin = '#8cf8f7',
            search_highlight = '#1bfd9c',
            operator = '#1bfd9c',
            bracket = '#e6e6e6',
            preprocessor = '#4b8902',
            bool = '#66b2b2',
            constant = '#b2d8d8',
            bufferline_selection = '#c084f5',
            plugins = {
                gitsigns = true,
                nvim_cmp = true,
                treesitter = true,
                nvimtree = true,
                telescope = true,
                lualine = false,
                bufferline = true,
                oil = true,
                whichkey = true,
                nvim_notify = true,
            },
        },
    }
end

return T
