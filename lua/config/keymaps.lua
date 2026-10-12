-- Set leader key
vim.g.mapleader = '.'

-- Normal and visual mode
vim.keymap.set('v', '$', '$<Left>', { desc = 'Jump to end of line' })
vim.keymap.set('n', '<space>p', '<cmd>fold<CR>', { desc = 'Toggle fold' })
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>', { desc = 'Move left' })
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>', { desc = 'Move right' })
vim.keymap.set('n', '<Up>', '<cmd>echo "Use k to move!!"<CR>', { desc = 'Move up' })
vim.keymap.set('n', '<Down>', '<cmd>echo "Use j to move!!"<CR>', { desc = 'Move down' })

vim.keymap.set('n', '<Tab>', '<cmd>tabnext<CR>', { desc = 'Next tab', silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>tabprevious<CR>', { desc = 'Previous tab', silent = true })
vim.keymap.set('n', '<space><Tab>', '<cmd>tabnew<CR>', { desc = 'New tab', silent = true })

-- Split navigation
vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = 'Split left', silent = true })
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = 'Split down', silent = true })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = 'Split up', silent = true })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = 'Split right', silent = true })

-- Window resizing
vim.keymap.set('n', '<leader><Up>', '<cmd>resize +5<CR>', { desc = 'Resize up', silent = true })
vim.keymap.set('n', '<leader>k', '<cmd>resize +5<CR>', { desc = 'Resize up', silent = true })
vim.keymap.set('n', '<leader><Down>', '<cmd>resize -5<CR>', { desc = 'Resize down', silent = true })
vim.keymap.set('n', '<leader>j', '<cmd>resize -5<CR>', { desc = 'Resize down', silent = true })
vim.keymap.set('n', '<leader><Left>', '<cmd>vertical resize +10<CR>', { desc = 'Resize left', silent = true })
vim.keymap.set('n', '<leader>h', '<cmd>vertical resize +10<CR>', { desc = 'Resize left', silent = true })
vim.keymap.set('n', '|', '<cmd>vertical resize +5<CR>', { desc = 'Resize left', silent = true })
vim.keymap.set('n', '<leader><Right>', '<cmd>vertical resize -10<CR>', { desc = 'Resize right', silent = true })
vim.keymap.set('n', '<leader>l', '<cmd>vertical resize -10<CR>', { desc = 'Resize right', silent = true })
vim.keymap.set('n', '\\', '<cmd>vertical resize -5<CR>', { desc = 'Resize right', silent = true })
vim.keymap.set('n', '<leader>c', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight', silent = true })

-- Terminal navigation
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h', { desc = 'Split left', silent = true })
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j', { desc = 'Split down', silent = true })
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k', { desc = 'Split up', silent = true })
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l', { desc = 'Split right', silent = true })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal', silent = true })

-- Insert mode movement
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left in insert mode' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right in insert mode' })

local function snippet_jump_or_move(direction, fallback)
    return function()
        if vim.snippet.active { direction = direction } then
            vim.snippet.jump(direction)
            return ''
        end
        return fallback
    end
end

vim.keymap.set({ 'i', 's' }, '<C-j>', snippet_jump_or_move(1, '<Down>'), {
    expr = true,
    desc = 'Next snippet placeholder / move down',
})
vim.keymap.set({ 'i', 's' }, '<C-k>', snippet_jump_or_move(-1, '<Up>'), {
    expr = true,
    desc = 'Previous snippet placeholder / move up',
})

-- Native snippet smoke test
vim.keymap.set('i', '<M-s>', function()
    vim.snippet.expand 'local ${1:name} = ${2:value}\nprint(${1})\n$0'
end, { desc = 'Insert native snippet test' })

-- Clipboard
vim.keymap.set('n', '<C-c>', '"*y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<C-c>', '"*yy', { desc = 'Copy line to system clipboard' })
vim.keymap.set('i', '<C-S>v', '"*p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<C-c>v', '"*PP', { desc = 'Paste from system clipboard' })

-- Utilities
vim.keymap.set('n', 'sp', require('utils.custom_spell_check').custom_spell, {
    desc = 'Corrector ortográfico personalizado',
    silent = true,
})
vim.keymap.set('n', '<space>oc', require('utils.opencode').toggle, { desc = 'Opencode toggle' })
vim.keymap.set('n', '<space>of', require('utils.opencode').focus, { desc = 'Opencode focus' })

-- QUICKLIST
vim.keymap.set('n', '<space>qo', '<cmd>copen<CR>', { desc = 'Quickfix open', silent = true })
vim.keymap.set('n', '<space>qc', '<cmd>cclose<CR>', { desc = 'Quickfix close', silent = true })
vim.keymap.set('n', '<space>qn', '<cmd>cnext<CR>', { desc = 'Quickfix next item', silent = true })
vim.keymap.set('n', '<space>qp', '<cmd>cprev<CR>', { desc = 'Quickfix previous item', silent = true })
vim.keymap.set('n', '<space>qf', '<cmd>cfirst<CR>', { desc = 'Quickfix first item', silent = true })
vim.keymap.set('n', '<space>ql', '<cmd>clast<CR>', { desc = 'Quickfix last item', silent = true })
vim.keymap.set('n', '<space>qq', '<cmd>copen<CR>', { desc = 'Quickfix list', silent = true })
