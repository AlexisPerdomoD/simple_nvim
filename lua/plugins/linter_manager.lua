return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    lazy = true,
    config = function()
        local lint = require("lint")
        -- eslint_d global config
        -- local eslint_d = lint.linters.eslint_d
        -- eslint_d.cmd = vim.fn.expand("/home/sixela/.local/share/nvim/mason/bin/eslint_d")
        -- eslint_d.args = {
        --     "-c", vim.fn.expand("~/.config/nvim/.eslintrc.json"),
        --     "--stdin",
        --     "--stdin-filename",
        --     "%filepath",
        --     "--format",
        --     "json"
        -- }

        lint.linters.htmlhint = {
            cmd = 'htmlhint',       -- comando para ejecutar htmlhint
            stdin = false,          -- htmlhint no usa entrada estándar
            args = {},              -- argumentos opcionales para el comando
            stream = 'both',        -- salida estándar y error estándar
            ignore_exitcode = true, -- ignora el código de salida para evitar errores en Neovim
            parser = require('lint.parser').from_pattern(
                '[^:]+:(\\d+):(\\d+): (.+)',
                { 'lnum', 'col', 'message' },
                { ['source'] = 'htmlhint' }
            ),
        }
        lint.linters.vale = {
            cmd = 'vale',                -- comando para ejecutar Vale
            stdin = true,                -- Vale puede usar entrada estándar
            args = { '--no-exit', '-' }, -- --no-exit para continuar en caso de errores y - para usar stdin
            stream = 'both',             -- salida estándar y error estándar
            ignore_exitcode = true,      -- ignora el código de salida para evitar errores en Neovim
            parser = require('lint.parser').from_pattern(
                '^stdin:%(\\d+):(\\d+): (.+)',
                { 'lnum', 'col', 'message' },
                { ['source'] = 'vale' }
            ),
        }
        -- complementar mason instalation
        -- npm install -g @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier eslint-config-prettier eslint-plugin-prettier
        --set linters
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            --svelte = { "eslint_d" },
            --python = { "pylint" },
            html = { "htmlhint" },
            markdown = { "vale" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
