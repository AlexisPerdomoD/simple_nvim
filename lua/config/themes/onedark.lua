local T = { "navarasu/onedark.nvim" }
T.name = 'onedark'
T.config = function()
    local onedark = require 'onedark'
    local bg_color_setuper = require 'utils.bg_color_setuper'
    onedark.setup {
        style = 'darker'
    }

    onedark.load()
    bg_color_setuper:bg_setuper(false, true)
end
return T
