local M = { 'zenbones-theme/zenbones.nvim' }
M.dependencies = { 'rktjmp/lush.nvim' }
M.config = function()
    vim.cmd 'colorscheme randombones_dark'
end

return M
