local M = { 'Aejkatappaja/sora' }
M.config = function()
    local t = require 'sora'
    t.setup {
        italic_comments = true,
    }

    vim.cmd 'colorscheme sora'
end
return M
