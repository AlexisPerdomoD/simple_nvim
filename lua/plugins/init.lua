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

require('lazy').setup({
    -- Load all plugin configurations
    -- require('plugins.fzf'),
    -- themes
    require('config.themes.moonfly'),
    require('plugins.nerdtree'),
    require('plugins.tmux_navigator'),
    require('plugins.telescope2'),
    require('plugins.mason'),
    require('plugins.lps'),
    require('plugins.cmp'),
    require('plugins.tree_setter'),
    require('plugins.luasnip'),
    require('plugins.formater_manager'),
    -- require('plugins.linter_manager'),
    require('plugins.commenter'),
    require('plugins.icons'),
    require('plugins.status_bar'),
    require('plugins.codeium'),

})
