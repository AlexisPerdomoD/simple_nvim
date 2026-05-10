local M = { 'Mofiqul/dracula.nvim' }
M.lazy = true
M.config = function()
    local t = require 'dracula'
    local bg = require 'utils.bg_color_setuper'
    t.setup {
        italic_comments = true,
    }

    vim.cmd 'colorscheme dracula'
    bg:start(false, true)
end
return M
