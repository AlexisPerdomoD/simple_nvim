local M = { 'Mofiqul/dracula.nvim' }
M.lazy = true
M.config = function()
    local t = require 'dracula'
    t.setup { italic_comments = true }
    vim.cmd 'colorscheme dracula'

    local bg = require 'utils.bg_color_setuper'
    bg:start(false, true)
end
return M
