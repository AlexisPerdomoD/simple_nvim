local api = vim.api
local custom_group = vim.api.nvim_create_augroup('CustomGroup', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
--     pattern = '*.lua',
--     command = 'source <afile>',
--     group = myAutoCmd,
-- })
--
api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = custom_group,
    callback = function() vim.hl.on_yank() end,
})

api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.md',
    command = 'setlocal spell',
    group = custom_group,
    desc = 'set spell on markdown',
})

api.nvim_create_autocmd({ 'VimResized', 'BufEnter', 'WinEnter' }, {
    callback = function()
        local height = vim.api.nvim_win_get_height(0)
        vim.o.scrolloff = math.floor(height / 2)
    end,
    group = custom_group,
    desc = 'Keep centered cursor',
})

-- vim.cmd [[
--   augroup auto_read
--     autocmd!
--     autocmd FocusGained,BufEnter * checktime
--   augroup END
-- ]]
