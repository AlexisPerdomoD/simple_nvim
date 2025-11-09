local T = { 'projekt0n/github-nvim-theme' }
T.name = 'github-theme'
T.lazy = false
T.priority = 1000
T.config = function(opts)
    opts = opts or {}
    require('github-theme').setup(opts)
    vim.cmd 'colorscheme github_dark_default'
    local bg_utils = require 'utils.bg_color_setuper'
    bg_utils.bg_setuper(false, true)
end

return T
