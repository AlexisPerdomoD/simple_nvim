-- Ensure lazy.nvim is installed
local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/lazy/lazy.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        install_path,
    }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(install_path)

require('lazy').setup {
    opts = {
        rocks = { enable = false },
    },

    import = 'plugins',
}
