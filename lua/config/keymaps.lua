-- Set leader key
vim.g.mapleader = '.'

local map = vim.keymap.set

-- Normal and visual mode
map('v', '$', '$<Left>', { desc = 'Jump to end of line' })
map('n', '<space>p', '<cmd>fold<CR>', { desc = 'Toggle fold' })
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { desc = 'Move left' })
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { desc = 'Move right' })
map('n', '<Up>', '<cmd>echo "Use k to move!!"<CR>', { desc = 'Move up' })
map('n', '<Down>', '<cmd>echo "Use j to move!!"<CR>', { desc = 'Move down' })

map('n', '<Tab>', '<cmd>tabnext<CR>', { desc = 'Next tab', silent = true })
map('n', '<S-Tab>', '<cmd>tabprevious<CR>', { desc = 'Previous tab', silent = true })
map('n', '<space><Tab>', '<cmd>tabnew<CR>', { desc = 'New tab', silent = true })

-- Split navigation
map('n', '<A-h>', '<C-w>h', { desc = 'Split left', silent = true })
map('n', '<A-j>', '<C-w>j', { desc = 'Split down', silent = true })
map('n', '<A-k>', '<C-w>k', { desc = 'Split up', silent = true })
map('n', '<A-l>', '<C-w>l', { desc = 'Split right', silent = true })

-- Window resizing
map('n', '<leader><Up>', '<cmd>resize +5<CR>', { desc = 'Resize up', silent = true })
map('n', '<leader>k', '<cmd>resize +5<CR>', { desc = 'Resize up', silent = true })
map('n', '<leader><Down>', '<cmd>resize -5<CR>', { desc = 'Resize down', silent = true })
map('n', '<leader>j', '<cmd>resize -5<CR>', { desc = 'Resize down', silent = true })
map('n', '<leader><Left>', '<cmd>vertical resize +10<CR>', { desc = 'Resize left', silent = true })
map('n', '<leader>h', '<cmd>vertical resize +10<CR>', { desc = 'Resize left', silent = true })
map('n', '|', '<cmd>vertical resize +5<CR>', { desc = 'Resize left', silent = true })
map('n', '<leader><Right>', '<cmd>vertical resize -10<CR>', { desc = 'Resize right', silent = true })
map('n', '<leader>l', '<cmd>vertical resize -10<CR>', { desc = 'Resize right', silent = true })
map('n', '\\', '<cmd>vertical resize -5<CR>', { desc = 'Resize right', silent = true })
map('n', '<leader>c', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight', silent = true })

-- Terminal navigation
map('t', '<A-h>', '<C-\\><C-n><C-w>h', { desc = 'Split left', silent = true })
map('t', '<A-j>', '<C-\\><C-n><C-w>j', { desc = 'Split down', silent = true })
map('t', '<A-k>', '<C-\\><C-n><C-w>k', { desc = 'Split up', silent = true })
map('t', '<A-l>', '<C-\\><C-n><C-w>l', { desc = 'Split right', silent = true })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal', silent = true })

-- Insert mode movement
map('i', '<C-h>', '<Left>', { desc = 'Move left in insert mode' })
map('i', '<C-l>', '<Right>', { desc = 'Move right in insert mode' })

local function snippet_jump_or_move(direction, fallback)
    return function()
        if vim.snippet.active { direction = direction } then
            vim.snippet.jump(direction)
            return ''
        end
        return fallback
    end
end

map({ 'i', 's' }, '<C-j>', snippet_jump_or_move(1, '<Down>'), {
    expr = true,
    desc = 'Next snippet placeholder / move down',
})
map({ 'i', 's' }, '<C-k>', snippet_jump_or_move(-1, '<Up>'), {
    expr = true,
    desc = 'Previous snippet placeholder / move up',
})

-- Native snippet smoke test
map('i', '<M-s>', function()
    vim.snippet.expand 'local ${1:name} = ${2:value}\nprint(${1})\n$0'
end, { desc = 'Insert native snippet test' })

-- Clipboard
map('n', '<C-c>', '"*y', { desc = 'Copy to system clipboard' })
map('v', '<C-c>', '"*yy', { desc = 'Copy line to system clipboard' })
map('i', '<C-S>v', '"*p', { desc = 'Paste from system clipboard' })
map('n', '<C-c>v', '"*PP', { desc = 'Paste from system clipboard' })

-- Utilities
map('n', 'sp', require('utils.custom_spell_check').custom_spell, {
    desc = 'Corrector ortográfico personalizado',
    silent = true,
})
map('n', '<space>oc', require('utils.opencode').toggle, { desc = 'Opencode toggle' })
map('n', '<space>of', require('utils.opencode').focus, { desc = 'Opencode focus' })
