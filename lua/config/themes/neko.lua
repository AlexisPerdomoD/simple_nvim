local T = { 'neko-night/nvim' }
T.lazy = false
T.priority = 1000

T.config = function(opts)
    local bg_utils = require 'utils.bg_color_setuper'
    opts = opts or {}
    opts.style = 'fire-obsidian'
    require('nekonight').setup(opts)
    vim.cmd 'colorscheme nekonight-synthwave'
    bg_utils.bg_setuper(false, true)
end

return T
