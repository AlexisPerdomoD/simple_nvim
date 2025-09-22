local T = { 'neko-night/nvim' }
T.lazy = false
T.priority = 1000

T.config = function(opts)
    local bg_utils = require 'utils.bg_color_setuper'
    local theme = require 'nekonight'
    opts = opts or {}

    theme.setup(opts)
    bg_utils.bg_setuper(false, true)
end

return T
