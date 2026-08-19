local M = { 'zenbones-theme/zenbones.nvim' }
M.dependencies = { 'rktjmp/lush.nvim' }
M.config = function()
    vim.cmd 'colorscheme randombones_dark'
    local bg = require 'utils.bg_color_setuper'
    bg:start(false, true)
end

return M
