local color_bg = require "lua.utils.bg_color_setuper"
-- Add any additional keymaps here
-- -- Set leader key
vim.g.mapleader = "."

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local silent_opts = { silent = true }
-- Normal mode mappings
map("n", "<leader>1", ":source ~/.config/nvim/init.lua<CR>", opts)
map("v", "$", "$<Left>", opts)
map("n", "<space>w", ":w<CR>", opts)
map("n", "<space>q", ":q<CR>", opts)
map("n", "<space>p", ":fold<CR>", silent_opts)
-- directions
map("n", "<Tab>", ":bnext<CR>", silent_opts)
map("n", "<S-Tab>", ":bprevious<CR>", silent_opts)
map("n", "<space><Left>", ":TmuxNavigateLeft<cr>", silent_opts)
map("n", "<space><Down>", ":TmuxNavigateDown<cr>", silent_opts)
map("n", "<space><Up>", ":TmuxNavigateUp<cr>", silent_opts)
map("n", "<space><Right>", ":TmuxNavigateRight<cr>", silent_opts)
map("n", "<leader><Up>", ":resize +5<CR>", silent_opts)
map("n", "<leader><Down>", ":resize -5<CR>", silent_opts)
map("n", "<leader><Left>", ":vertical resize +12<CR>", silent_opts)
map("n", "<leader><Right>", ":vertical resize -12<CR>", silent_opts)
map("n", "<leader>c", ":nohlsearch<CR>", silent_opts)

-- Insert mode mappings
map("i", "(", "()<Left>", opts)
map("i", "{", "{}<Left>", opts)
map("i", "[", "[]<Left>", opts)
-- map('i', '<', '<><Left>', opts)  -- Uncomment this line if needed
map("i", "'", "''<Left>", opts)
map("i", '"', '""<Left>', opts)
map("i", "`", "``<Left>", opts)

-- Paste shortcuts
map("n", "<C-c>", '"*y', opts)
map("v", "<C-c>", '"*yy', opts)
map("i", "<C-S>v", '"*p', opts)
map("n", "<C-c>v", '"*PP', opts)

-- Mapear `d` para no sobreescribir el portapapeles
map("n", "d", '"_d', { noremap = true, silent = true })
-- modo visual si quiero copiar al clipboard
-- map('v', 'd', '"_d', { noremap = true, silent = true })

-- Mapear `p` para pegar sin sobrescribir el portapapeles
map("n", "p", '"0p', { noremap = true, silent = true })
map("v", "p", '"0p', { noremap = true, silent = true })

-- folding
-- Define el keybinding y el resaltado de los pliegues en una línea
map("n", "za", ':execute "normal! za" | hi Folded guibg=#666666 guifg=#020202<CR>', opts)

-- remmove background color
vim.keymap.set("n", "<leader>t", color_bg.toggle_bg, opts)
