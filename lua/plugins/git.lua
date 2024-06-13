return {
    {
        'tpope/vim-fugitive',
        cmd = { 'Git', 'G' }
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()

            vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', { silent = true })
            vim.keymap.set('n', '<leader>gt', ':Gitsigns blame_line<CR>', { silent = true })
        end
    }

}
