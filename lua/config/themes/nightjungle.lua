local T = { 'tx3stn/nightjungle.nvim' }
T.name = 'nightjungle'
T.config = function()
    local t = require 'nightjungle'
    t.setup {}
    vim.cmd.colorscheme 'nightjungle'
    local bg = require 'utils.bg_color_setuper'
    bg:bg_setuper(false, true)
end

return T
