local M = { 'ayu-theme/ayu-vim' }

M.lazy = true

M.config = function()
    vim.g.ayucolor = 'mirage'
    -- vim.g.ayucolor="light"
    -- vim.g.ayucolor = 'dark'
    vim.cmd 'colorscheme ayu'
    local bg = require 'utils.bg_color_setuper'
    bg:start(false, true)
end

return M
