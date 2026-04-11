local color_bg = require 'utils.bg_color_setuper'
local custom_spell_check = require 'utils.custom_spell_check'

-- -- Set leader key
vim.g.mapleader = '.'

local map = vim.api.nvim_set_keymap
-- Normal mode mappings
map('n', '<leader>1', ':source ~/.config/nvim/init.lua<CR>', { noremap = true, desc = 'Reload config', silent = true })
map('v', '$', '$<Left>', { noremap = true, desc = 'Jump to end of line' })
map('n', '<space>w', ':w<CR>', { noremap = true, desc = 'Save file' })
map('n', '<space>q', ':q<CR>', { noremap = true, desc = 'Quit file' })
map('n', '<space>p', ':fold<CR>', { noremap = true, desc = 'Toggle fold' })
-- directions
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { noremap = true, desc = 'Move left' })
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { noremap = true, desc = 'Move right' })
map('n', '<Up>', '<cmd>echo "Use k to move!!"<CR>', { noremap = true, desc = 'Move up' })
map('n', '<Down>', '<cmd>echo "Use j to move!!"<CR>', { noremap = true, desc = 'Move down' })

map('n', '<Tab>', ':tabnext<CR>', { noremap = true, desc = 'Next tab', silent = true })
map('n', '<S-Tab>', ':tabprevious<CR>', { noremap = true, desc = 'Previous tab', silent = true })
map('n', '<space><Tab>', ':tabnew<CR>', { noremap = true, desc = 'New tab', silent = true })

map('n', '<space><Left>', ':TmuxNavigateLeft<cr>', { silent = true, desc = 'Tmux left' })
map('n', '<A-h>', ':TmuxNavigateLeft<cr>', { silent = true, desc = 'Tmux left' })
map('n', '<space><Down>', ':TmuxNavigateDown<cr>', { silent = true, desc = 'Tmux down' })
map('n', '<A-j>', ':TmuxNavigateDown<cr>', { silent = true, desc = 'Tmux down' })
map('n', '<space><Up>', ':TmuxNavigateUp<cr>', { silent = true, desc = 'Tmux up' })
map('n', '<A-k>', ':TmuxNavigateUp<cr>', { silent = true, desc = 'Tmux up' })
map('n', '<space><Right>', ':TmuxNavigateRight<cr>', { silent = true, desc = 'Tmux right' })
map('n', '<A-l>', ':TmuxNavigateRight<cr>', { silent = true, desc = 'Tmux right' })

map('n', '<leader><Up>', ':resize +5<CR>', { silent = true, desc = 'Resize up' })
map('n', '<leader>k', ':resize +5<CR>', { silent = true, desc = 'Resize up' })
map('n', '<leader><Down>', ':resize -5<CR>', { silent = true, desc = 'Resize down' })
map('n', '<leader>j', 'resize -5<CR>', { silent = true, desc = 'Resize down' })
map('n', '<leader><Left>', ':vertical resize +10<CR>', { silent = true, desc = 'Resize left' })
map('n', '<leader>h', ':vertical resize +10<CR>', { silent = true, desc = 'Resize left' })
map('n', '|', ':vertical resize +5<CR>', { silent = true, desc = 'Resize left' })
map('n', '<leader><Right>', ':vertical resize -10<CR>', { silent = true, desc = 'Resize right' })
map('n', '<leader>l', ':vertical resize -10<CR>', { silent = true, desc = 'Resize right' })
map('n', '\\', ':vertical resize -5<CR>', { silent = true, desc = 'Resize right' })

map('n', '<leader>c', ':nohlsearch<CR>', { silent = true, desc = 'Clear highlight' })

--Insert mode keybinding
map('i', '<C-h>', '<Left>', { noremap = true, desc = 'Move left in insert mode' })
map('i', '<C-l>', '<Right>', { noremap = true, desc = 'Move right in insert mode' })
map('i', '<C-j>', '<Down>', { noremap = true, desc = 'Move down in insert mode' })
map('i', '<C-k>', '<Up>', { noremap = true, desc = 'Move up in insert mode' })

-- Paste shortcuts
map('n', '<C-c>', '"*y', { noremap = true, desc = 'Copy to system clipboard' })
map('v', '<C-c>', '"*yy', { noremap = true, desc = 'Copy to system clipboard' })
map('i', '<C-S>v', '"*p', { noremap = true, desc = 'Paste from system clipboard' })
map('n', '<C-c>v', '"*PP', { noremap = true, desc = 'Paste from system clipboard' })

-- remmove background color
vim.keymap.set(
    'n',
    '<leader>t',
    function() color_bg:toggle_bg() end,
    { noremap = true, desc = 'Toggle background color' }
)

-- Crear el mapeo para invocar el corrector personalizado
vim.keymap.set(
    'n',
    'sp',
    custom_spell_check.custom_spell,
    { desc = 'Corrector ortográfico personalizado', noremap = true, silent = true }
)
