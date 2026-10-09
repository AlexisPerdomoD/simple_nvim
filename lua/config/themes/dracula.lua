local M = { 'Mofiqul/dracula.nvim' }
M.lazy = true
M.config = function()
    local t = require 'dracula'
    t.setup { italic_comments = true }
    vim.cmd 'colorscheme dracula'
end
return M
