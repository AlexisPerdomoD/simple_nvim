return {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- priority = 1000,
    config = function()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
}
