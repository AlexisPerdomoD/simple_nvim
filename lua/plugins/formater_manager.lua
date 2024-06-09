return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                --svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { 'yamlfmt' },
                markdown = { "prettier" },
                --graphql = { "prettier" },
                luaa = { "stylua" },
                bash = { "shfmt" },
                sh = { "shfmt" },
                zsh = { "shfmt" },
            },
            shfmt = {
                options = { "-i", "2", "-ci" },

            },
            prettier = {
                command = vim.fn.stdpath("data") .. "/mason/bin/prettier", -- Ruta a prettier instalado por Mason
                args = function()
                    return {
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                        "--config",
                        vim.fn.expand("~/.config/nvim/.prettierrc.json")
                    }
                end,
                stdin = true
            },
            stylua = {
                command = 'stylua',
                args = {
                    '--search-parent-directories', '--stdin-filepath', '%:p', '-'
                },
            }
            --format_on_save = {
            --    lsp_fallback = true,
            --    async = false,
            --    timeout_ms = 500,
            --},
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
