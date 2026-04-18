local color_bg = require 'utils.bg_color_setuper'
local custom_spell_check = require 'utils.custom_spell_check'

vim.g.mapleader = '.'
vim.api.nvim_set_keymap(
    'n',
    '<leader>1',
    ':source ~/.config/nvim/init.lua<CR>',
    { noremap = true, desc = 'Reload config', silent = true }
)
vim.api.nvim_set_keymap('v', '$', '$<Left>', { noremap = true, desc = 'Jump to end of line' })
vim.api.nvim_set_keymap('n', '<space>w', ':w<CR>', { noremap = true, desc = 'Save file' })
vim.api.nvim_set_keymap('n', '<space>q', ':q<CR>', { noremap = true, desc = 'Quit file' })
vim.api.nvim_set_keymap('n', '<space>p', ':fold<CR>', { noremap = true, desc = 'Toggle fold' })
vim.api.nvim_set_keymap('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { noremap = true, desc = 'Move left' })
vim.api.nvim_set_keymap('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { noremap = true, desc = 'Move right' })
vim.api.nvim_set_keymap('n', '<Up>', '<cmd>echo "Use k to move!!"<CR>', { noremap = true, desc = 'Move up' })
vim.api.nvim_set_keymap('n', '<Down>', '<cmd>echo "Use j to move!!"<CR>', { noremap = true, desc = 'Move down' })
vim.api.nvim_set_keymap('n', '<Tab>', ':tabnext<CR>', { noremap = true, desc = 'Next tab', silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':tabprevious<CR>', { noremap = true, desc = 'Previous tab', silent = true })
vim.api.nvim_set_keymap('n', '<space><Tab>', ':tabnew<CR>', { noremap = true, desc = 'New tab', silent = true })
vim.api.nvim_set_keymap('n', '<space><Left>', ':TmuxNavigateLeft<cr>', { silent = true, desc = 'Tmux left' })
vim.api.nvim_set_keymap('n', '<A-h>', ':TmuxNavigateLeft<cr>', { silent = true, desc = 'Tmux left' })
vim.api.nvim_set_keymap('n', '<space><Down>', ':TmuxNavigateDown<cr>', { silent = true, desc = 'Tmux down' })
vim.api.nvim_set_keymap('n', '<A-j>', ':TmuxNavigateDown<cr>', { silent = true, desc = 'Tmux down' })
vim.api.nvim_set_keymap('n', '<space><Up>', ':TmuxNavigateUp<cr>', { silent = true, desc = 'Tmux up' })
vim.api.nvim_set_keymap('n', '<A-k>', ':TmuxNavigateUp<cr>', { silent = true, desc = 'Tmux up' })
vim.api.nvim_set_keymap('n', '<space><Right>', ':TmuxNavigateRight<cr>', { silent = true, desc = 'Tmux right' })
vim.api.nvim_set_keymap('n', '<A-l>', ':TmuxNavigateRight<cr>', { silent = true, desc = 'Tmux right' })
vim.api.nvim_set_keymap('n', '<leader><Up>', ':resize +5<CR>', { silent = true, desc = 'Resize up' })
vim.api.nvim_set_keymap('n', '<leader>k', ':resize +5<CR>', { silent = true, desc = 'Resize up' })
vim.api.nvim_set_keymap('n', '<leader><Down>', ':resize -5<CR>', { silent = true, desc = 'Resize down' })
vim.api.nvim_set_keymap('n', '<leader>j', 'resize -5<CR>', { silent = true, desc = 'Resize down' })
vim.api.nvim_set_keymap('n', '<leader><Left>', ':vertical resize +10<CR>', { silent = true, desc = 'Resize left' })
vim.api.nvim_set_keymap('n', '<leader>h', ':vertical resize +10<CR>', { silent = true, desc = 'Resize left' })
vim.api.nvim_set_keymap('n', '|', ':vertical resize +5<CR>', { silent = true, desc = 'Resize left' })
vim.api.nvim_set_keymap('n', '<leader><Right>', ':vertical resize -10<CR>', { silent = true, desc = 'Resize right' })
vim.api.nvim_set_keymap('n', '<leader>l', ':vertical resize -10<CR>', { silent = true, desc = 'Resize right' })
vim.api.nvim_set_keymap('n', '\\', ':vertical resize -5<CR>', { silent = true, desc = 'Resize right' })
vim.api.nvim_set_keymap('n', '<leader>c', ':nohlsearch<CR>', { silent = true, desc = 'Clear highlight' })
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, desc = 'Move left in insert mode' })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, desc = 'Move right in insert mode' })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, desc = 'Move down in insert mode' })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, desc = 'Move up in insert mode' })
vim.api.nvim_set_keymap('n', '<C-c>', '"*y', { noremap = true, desc = 'Copy to system clipboard' })
vim.api.nvim_set_keymap('v', '<C-c>', '"*yy', { noremap = true, desc = 'Copy to system clipboard' })
vim.api.nvim_set_keymap('i', '<C-S>v', '"*p', { noremap = true, desc = 'Paste from system clipboard' })
vim.api.nvim_set_keymap('n', '<C-c>v', '"*PP', { noremap = true, desc = 'Paste from system clipboard' })

vim.keymap.set('n', '<leader>t', function()
    color_bg:toggle_bg()
end, { noremap = true, desc = 'Toggle background color' })

vim.keymap.set(
    'n',
    'sp',
    custom_spell_check.custom_spell,
    { desc = 'Corrector ortográfico personalizado', noremap = true, silent = true }
)
