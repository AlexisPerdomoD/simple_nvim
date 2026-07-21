-- TODO : evaluar este plugin para crear temas personalizados usando solo este plugin

local M = { 'roobert/palette.nvim' }
M.config = function()
    local t = require 'palette'
    t.setup {
        palettes = {
            main = 'dark',
            -- pastel, bright or dark
            accent = 'dark',
            state = 'bright',
        },

        italics = true,
        transparent_background = false,
    }

    vim.cmd [[colorscheme palette]]
end

return M
