-- Ensure lazy.nvim is installed
local ensure_lazy = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/lazy/lazy.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
            install_path })
    end
    vim.opt.rtp:prepend(install_path)
end
ensure_lazy()
-- Load config
require 'config'
-- Load plugins
require 'lazy'.setup 'plugins'
-- color-scheme is set into the selected theme on "config/themes/"
