local color_bg = require 'utils.bg_color_setuper'
local custom_spell_check = require 'utils.custom_spell_check'
-- -- Set leader key
vim.g.mapleader = '.'

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local silent_opts = { silent = true }

-- Normal mode mappings
map('n', '<leader>1', ':source ~/.config/nvim/init.lua<CR>', opts)
map('v', '$', '$<Left>', opts)
map('n', '<space>w', ':w<CR>', opts)
map('n', '<space>q', ':q<CR>', opts)
map('n', '<space>p', ':fold<CR>', silent_opts)
-- directions
-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', opts)
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', opts)
map('n', '<Up>', '<cmd>echo "Use k to move!!"<CR>', opts)
map('n', '<Down>', '<cmd>echo "Use j to move!!"<CR>', opts)
map('n', '<Tab>', ':tabnext<CR>', silent_opts)
map('n', '<S-Tab>', ':tabprevious<CR>', silent_opts)
map('n', '<space><Tab>', ':tabnew<CR>', silent_opts)

map('n', '<space><Left>', ':TmuxNavigateLeft<cr>', silent_opts)
map('n', '<A-h>', ':TmuxNavigateLeft<cr>', silent_opts)
map('n', '<space><Down>', ':TmuxNavigateDown<cr>', silent_opts)
map('n', '<A-j>', ':TmuxNavigateDown<cr>', silent_opts)
map('n', '<space><Up>', ':TmuxNavigateUp<cr>', silent_opts)
map('n', '<A-k>', ':TmuxNavigateUp<cr>', silent_opts)
map('n', '<space><Right>', ':TmuxNavigateRight<cr>', silent_opts)
map('n', '<A-l>', ':TmuxNavigateRight<cr>', silent_opts)

map('n', '<leader><Up>', ':resize +5<CR>', silent_opts)
map('n', '<leader>k', ':resize +5<CR>', silent_opts)
map('n', '<leader><Down>', ':resize -5<CR>', silent_opts)
map('n', '<leader>j', 'resize -5<CR>', silent_opts)
map('n', '<leader><Left>', ':vertical resize +10<CR>', silent_opts)
map('n', '|', ':vertical resize +5<CR>', silent_opts)
map('n', '<leader><Right>', ':vertical resize -10<CR>', silent_opts)
map('n', '\\', ':vertical resize -5<CR>', silent_opts)

map('n', '<leader>c', ':nohlsearch<CR>', silent_opts)
map('n', '<leader>s', ':w<CR>', silent_opts)

--Insert mode keybinding
map('i', '<C-h>', '<Left>', opts)
map('i', '<C-l>', '<Right>', opts)
map('i', '<C-j>', '<Down>', opts)
map('i', '<C-k>', '<Up>', opts)

-- Paste shortcuts
map('n', '<C-c>', '"*y', opts)
map('v', '<C-c>', '"*yy', opts)
map('i', '<C-S>v', '"*p', opts)
map('n', '<C-c>v', '"*PP', opts)

-- remmove background color
vim.keymap.set('n', '<leader>t', color_bg.toggle_bg, opts)

-- Crear el mapeo para invocar el corrector personalizado
vim.keymap.set(
    'n',
    'sp',
    custom_spell_check.custom_spell,
    { desc = 'Corrector ortográfico personalizado', noremap = true, silent = true }
)
