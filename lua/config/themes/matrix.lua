local T = { 'iruzo/matrix-nvim' }
T.name = 'matrix'
T.config = function()
    -- Example config in lua
    -- vim.g.matrix_contrast = true
    vim.g.matrix_borders = true
    -- vim.g.matrix_disable_background = true
    vim.g.matrix_italic = false

    -- Load the colorscheme
    require('matrix').set()
end

return T
