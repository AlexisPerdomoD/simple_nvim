local T = { 'tx3stn/nightjungle.nvim' }
T.name = 'nightjungle'
T.config = function()
    local t = require 'nightjungle'
    local bg = require 'utils.bg_color_setuper'
    t.setup {}
    vim.cmd 'colorscheme nightjungle'
    bg:start(false, true)
end

return T
