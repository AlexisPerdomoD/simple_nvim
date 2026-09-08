local M = { 'Aejkatappaja/sora' }
M.config = function()
    local t = require 'sora'
    t.setup {
        italic_comments = true,
    }

    vim.cmd 'colorscheme sora'
    local bg = require 'utils.bg_color_setuper'
    bg:start(false, true)
end
return M
