local T = { 'ribru17/bamboo.nvim' }
T.name = 'bamboo'
T.config = function()
    local bamboo = require 'bamboo'
    local bg_color_setuper = require 'utils.bg_color_setuper'
    bamboo.setup {}
    bamboo.load()
    bg_color_setuper:bg_setuper(false, true)
end
return T
