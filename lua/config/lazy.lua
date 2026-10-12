-- Ensure lazy.nvim is installed
local install_path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        install_path,
    }
end

vim.opt.rtp:prepend(install_path)

local lazy = require 'lazy'

lazy.setup {
    opts = {
        rocks = { enable = false },
    },

    import = 'plugins',
}
