return {
    'mfussenegger/nvim-lint',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    enabled = false,
    config = function()
        local lint = require 'lint'

        lint.linters.htmlhint = {
            name = 'htmlhint',
            cmd = 'htmlhint', -- comando para ejecutar htmlhint
            stdin = false, -- htmlhint no usa entrada estándar
            args = {}, -- argumentos opcionales para el comando
            stream = 'both', -- salida estándar y error estándar
            ignore_exitcode = true, -- ignora el código de salida para evitar errores en Neovim
            parser = require('lint.parser').from_pattern('[^:]+:(\\d+):(\\d+): (.+)', { 'lnum', 'col', 'message' }),
        }
        lint.linters_by_ft = {
            javascript = { 'eslint' },
            typescript = { 'eslint' },
            javascriptreact = { 'eslint' },
            typescriptreact = { 'eslint' },
            html = { 'htmlhint' },
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function() lint.try_lint() end,
        })

        vim.keymap.set('n', '.l', function() lint.try_lint() end, { desc = 'Trigger linting for current file' })
    end,
}
