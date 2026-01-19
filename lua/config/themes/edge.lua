local M = { 'sainnhe/edge' }
M.config = function()
    -- vim.g.edge_style = 'default'
    vim.g.edge_style = 'neon'
    vim.g.edge_enable_italic = true
    vim.g.edge_better_performance = true
    -- 0 no transparency
    -- 1 full transparency
    -- 2 components only transparency
    vim.g.edge_transparent_background = 2
    -- dim
    -- bright --default
    -- blend
    vim.g.edge_float_style = 'dim'
    vim.cmd 'colorscheme edge'
end
return M
