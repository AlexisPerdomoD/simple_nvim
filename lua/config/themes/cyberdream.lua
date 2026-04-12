local M = { 'scottmckendry/cyberdream.nvim' }

M.config = function()
    local theme = require 'cyberdream'
    theme.setup { italic_comments = true, transparent = true, variant = 'auto' }
    vim.cmd 'colorscheme cyberdream'
end

return M
