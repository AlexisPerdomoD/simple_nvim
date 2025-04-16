function Toggle_nord_background()
    if vim.g.nord_disable_background then
        vim.g.nord_disable_background = false
    else
        vim.g.nord_disable_background = true
    end
    vim.cmd('colorscheme nord') -- Reapplies the colorscheme
end

return {
    'shaunsingh/nord.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- priority = 1000,
    -- event = "VeryLazy",
    lazy = true,
    config = function()
        --Lua:
        -- Example config in lua
        vim.g.nord_contrast = false
        vim.g.nord_borders = false
        vim.g.nord_disable_background = false
        --vim.g.nord_italic = false
        --vim.g.nord_uniform_diff_background = true
        vim.g.nord_enable_sidebar_background = true
        vim.g.nord_bold = true
        -- Key mapping to toggle background
        -- vim.api.nvim_set_keymap('n', '<leader>tb', ':lua Toggle_nord_background()<CR>', { noremap = true, silent = true })
        -- vim.cmd [[colorscheme nord]]
        require('utils.bg_color_setuper').bg_setuper(false, true)
    end
}
