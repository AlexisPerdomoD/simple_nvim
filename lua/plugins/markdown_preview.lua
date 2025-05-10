return {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    event = 'VeryLazy',
    -- lazy = true,
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },       -- if you use the mini.nvim suite
        { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },      -- if you use standalone mini plugins
        { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    }
}
