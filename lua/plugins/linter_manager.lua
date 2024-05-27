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
        local eslint_d = require("lint.linters.eslint_d")
        eslint_d.args = {
            "-c", vim.fn.expand("~/.config/nvim/.eslintrc.json"),
            "--stdin",
            "--stdin-filename",
            "%filepath",
            "--format",
            "json"
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
            html = { "htmlhint" }
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
