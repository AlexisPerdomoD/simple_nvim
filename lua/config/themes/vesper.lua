local M = { 'datsfilipe/vesper.nvim' }
M.lazy = true

M.config = function()
    local t = require 'vesper'
    t.setup {
        transparent = false, -- Boolean: Sets the background to transparent
        italics = {
            comments = true, -- Boolean: Italicizes comments
            strings = false, -- Boolean: Italicizes strings
            keywords = false, -- Boolean: Italicizes keywords
            functions = false, -- Boolean: Italicizes functions
            variables = false, -- Boolean: Italicizes variables
        },
        overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
        palette_overrides = {},
    }
    vim.cmd 'colorscheme vesper'
end

return M
