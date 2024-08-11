return {
    {
        'tpope/vim-fugitive',
        cmd = { 'Git', 'G' },
        event = 'VeryLazy'
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            require('gitsigns').setup()

            vim.keymap.set('n', '.gp', ':Gitsigns preview_hunk<CR>', { silent = true })
            vim.keymap.set('n', '.gt', ':Gitsigns blame_line<CR>', { silent = true })
        end
    }

}
