local vim_fugitive = { 'tpope/vim-fugitive' }
vim_fugitive.event = 'VeryLazy'
vim_fugitive.cmd = { 'Git', 'G' }

local gitsigns = { 'lewis6991/gitsigns.nvim' }
gitsigns.event = 'VeryLazy'
gitsigns.config = function()
    require('gitsigns').setup()

    vim.keymap.set('n', '<space>gt', ':Gitsigns blame_line<CR>', { silent = true })
    vim.keymap.set('n', '<space>ph', ':Gitsigns preview_hunk<CR>', { silent = true })
end

return { vim_fugitive, gitsigns }
