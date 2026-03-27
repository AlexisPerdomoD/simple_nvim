return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require 'conform'

        conform.setup {
            format_after_save = false,
            notify_on_error = false,
            notify_no_formatters = true,

            formatters_by_ft = {
                javascript = { 'prettier' },
                typescript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescriptreact = { 'prettier' },
                jsx = { 'prettier' },
                vue = { 'prettier' },
                css = { 'prettier' },
                html = { 'prettier' },
                json = { 'prettier' },
                yaml = { 'yamlfmt' },
                markdown = { 'prettier' },
                xml = { 'xmlformat' },
                lua = { 'stylua' },
                bash = { 'shfmt' },
                sh = { 'shfmt' },
                zsh = { 'shfmt' },
                cs = { 'csharpier' },
                python = { 'ruff_format' },
                go = { 'gofumpt' },
                cpp = { 'clang_format' },
                c = { 'clang_format' },
                java = { lsp_format = 'first' },
            },

            shfmt = {
                options = { '-i', '2', '-ci' },
            },

            prettier = {
                inherit = false,
                command = 'prettier',
                args = function()
                    local config_path = vim.fn.findfile('.prettierrc', '.;')
                        or vim.fn.findfile('.prettierrc.json', '.;')
                        or vim.fn.findfile('.prettierrc.js', '.;')
                        or vim.fn.findfile('.prettierrc.yaml', '.;')
                        or vim.fn.findfile('.prettierrc.yml', '.;')

                    if config_path == nil then
                        config_path = os.getenv 'HOME' .. '/.config/nvim/default_dev_config/.prettierrc.json'
                    end
                    return {
                        '--config',
                        config_path,
                        '--stdin-filepath',
                        vim.api.nvim_buf_get_name(0),
                    }
                end,
                stdin = true,
            },

            stylua = {
                command = 'stylua',
                args = {
                    '--search-parent-directories',
                    '--stdin-filepath',
                    '%:p',
                    '-',
                },
            },
            format_on_save = nil,
        }

        vim.keymap.set({ 'n', 'v' }, '<leader>s', function()
            conform.format({
                lsp_fallback = false,
                async = false,
                timeout_ms = 500,
            }, function(err)
                if err ~= nil then
                    -- NOTIFY ERROR
                    vim.notify(err, vim.log.levels.WARN)
                    return
                end

                vim.notify('Formatted properly!', vim.log.levels.INFO)
            end)
        end, { desc = 'Format=format file or range (in visual, normal mode)', noremap = true })
    end,
}
