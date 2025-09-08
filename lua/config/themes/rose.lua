-- lua/plugins/rose-pine.lua
return {
    -- priority = 1000,
    lazy = true,
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
        vim.cmd 'colorscheme rose-pine'
        require('utils.bg_color_setuper').bg_setuper(false, true)
    end,
}
