-- lua/plugins/rose-pine.lua
local T = { 'rose-pine/neovim' }

T.lazy = true
T.name = 'rose-pine'
T.config = function()
    vim.cmd 'colorscheme rose-pine'
    require('utils.bg_color_setuper').bg_setuper(false, true)
end

return T
