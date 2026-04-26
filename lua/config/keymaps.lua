local color_bg = require 'utils.bg_color_setuper'
local custom_spell_check = require 'utils.custom_spell_check'

-- -- Set leader key
vim.g.mapleader = '.'

local m = vim.api.nvim_set_keymap
-- Normal mode mappings
m('n', '<leader>1', ':source ~/.config/nvim/init.lua<CR>', { noremap = true, desc = 'Reload config', silent = true })
m('v', '$', '$<Left>', { noremap = true, desc = 'Jump to end of line' })
m('n', '<space>w', ':w<CR>', { noremap = true, desc = 'Save file' })
m('n', '<space>q', ':q<CR>', { noremap = true, desc = 'Quit file' })
m('n', '<space>p', ':fold<CR>', { noremap = true, desc = 'Toggle fold' })
-- directions
m('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { noremap = true, desc = 'Move left' })
m('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { noremap = true, desc = 'Move right' })
m('n', '<Up>', '<cmd>echo "Use k to move!!"<CR>', { noremap = true, desc = 'Move up' })
m('n', '<Down>', '<cmd>echo "Use j to move!!"<CR>', { noremap = true, desc = 'Move down' })

m('n', '<Tab>', ':tabnext<CR>', { noremap = true, desc = 'Next tab', silent = true })
m('n', '<S-Tab>', ':tabprevious<CR>', { noremap = true, desc = 'Previous tab', silent = true })
m('n', '<space><Tab>', ':tabnew<CR>', { noremap = true, desc = 'New tab', silent = true })

m('n', '<space><Left>', ':TmuxNavigateLeft<cr>', { silent = true, desc = 'Tmux left' })
m('n', '<A-h>', ':TmuxNavigateLeft<cr>', { silent = true, desc = 'Tmux left' })
m('n', '<space><Down>', ':TmuxNavigateDown<cr>', { silent = true, desc = 'Tmux down' })
m('n', '<A-j>', ':TmuxNavigateDown<cr>', { silent = true, desc = 'Tmux down' })
m('n', '<space><Up>', ':TmuxNavigateUp<cr>', { silent = true, desc = 'Tmux up' })
m('n', '<A-k>', ':TmuxNavigateUp<cr>', { silent = true, desc = 'Tmux up' })
m('n', '<space><Right>', ':TmuxNavigateRight<cr>', { silent = true, desc = 'Tmux right' })
m('n', '<A-l>', ':TmuxNavigateRight<cr>', { silent = true, desc = 'Tmux right' })

m('n', '<leader><Up>', ':resize +5<CR>', { silent = true, desc = 'Resize up' })
m('n', '<leader>k', ':resize +5<CR>', { silent = true, desc = 'Resize up' })
m('n', '<leader><Down>', ':resize -5<CR>', { silent = true, desc = 'Resize down' })
m('n', '<leader>j', 'resize -5<CR>', { silent = true, desc = 'Resize down' })
m('n', '<leader><Left>', ':vertical resize +10<CR>', { silent = true, desc = 'Resize left' })
m('n', '<leader>h', ':vertical resize +10<CR>', { silent = true, desc = 'Resize left' })
m('n', '|', ':vertical resize +5<CR>', { silent = true, desc = 'Resize left' })
m('n', '<leader><Right>', ':vertical resize -10<CR>', { silent = true, desc = 'Resize right' })
m('n', '<leader>l', ':vertical resize -10<CR>', { silent = true, desc = 'Resize right' })
m('n', '\\', ':vertical resize -5<CR>', { silent = true, desc = 'Resize right' })

m('n', '<leader>c', ':nohlsearch<CR>', { silent = true, desc = 'Clear highlight' })

--Insert mode keybinding
m('i', '<C-h>', '<Left>', { noremap = true, desc = 'Move left in insert mode' })
m('i', '<C-l>', '<Right>', { noremap = true, desc = 'Move right in insert mode' })
m('i', '<C-j>', '<Down>', { noremap = true, desc = 'Move down in insert mode' })
m('i', '<C-k>', '<Up>', { noremap = true, desc = 'Move up in insert mode' })

-- Paste shortcuts
m('n', '<C-c>', '"*y', { noremap = true, desc = 'Copy to system clipboard' })
m('v', '<C-c>', '"*yy', { noremap = true, desc = 'Copy to system clipboard' })
m('i', '<C-S>v', '"*p', { noremap = true, desc = 'Paste from system clipboard' })
m('n', '<C-c>v', '"*PP', { noremap = true, desc = 'Paste from system clipboard' })

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
