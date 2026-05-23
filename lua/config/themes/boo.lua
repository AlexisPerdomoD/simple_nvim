local M = { 'rockerBOO/boo-colorscheme-nvim' }
M.name = 'boo'
M.config = function()
    local t = require 'boo-colorscheme'

    t.use { italics = true, theme = 'boo' }

    local bg = require 'utils.bg_color_setuper'
    bg:start(false, true)
end

return M
