local custom_group = vim.api.nvim_create_augroup('CustomGroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = custom_group,
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.md',
    command = 'setlocal spell',
    group = custom_group,
    desc = 'set spell on markdown',
})

vim.api.nvim_create_autocmd({ 'VimResized', 'BufEnter', 'WinEnter' }, {
    callback = function()
        local height = vim.api.nvim_win_get_height(0)
        vim.o.scrolloff = math.floor(height / 2)
    end,
    group = custom_group,
    desc = 'Keep centered cursor',
})
