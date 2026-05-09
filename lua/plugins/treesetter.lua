local M = { 'nvim-treesitter/nvim-treesitter' }
M.event = 'BufReadPost'
M.build = ':TSUpdate'
M.dependencies = { { 'nvim-treesitter/nvim-treesitter-textobjects' } }
M.main = 'nvim-treesitter.config'
M.opts = {}

return M
