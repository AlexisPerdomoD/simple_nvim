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
                vue = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { 'yamlfmt' },
                markdown = { "prettier" },
                xml = { "xmlformater" },
                --graphql = { "prettier" },
                luaa = { "stylua" },
                bash = { "shfmt" },
                sh = { "shfmt" },
                zsh = { "shfmt" },
                cs = { "csharpier" },
            },
            shfmt = {
                options = { "-i", "2", "-ci" },

            },
            prettier = {
                -- command = vim.fn.stdpath("data") .. "/mason/bin/pretierd", -- Ruta a prettier instalado por Mason
                inherit = false,
                command = "prettierd",
                args = function()
                    local config_path = vim.fn.findfile(".prettierrc", ".;") or
                        vim.fn.findfile(".prettierrc.json", ".;") or
                        vim.fn.findfile(".prettierrc.js", ".;") or
                        vim.fn.findfile(".prettierrc.yaml", ".;") or
                        vim.fn.findfile(".prettierrc.yml", ".;")

                    if config_path == nil then
                        config_path = vim.fn.expand("~/.config/nvim/.prettierrc.json")
                    end
                    print(config_path)
                    return {
                        "--config",
                        config_path,
                        "--config",
                        "--stdin-filepath",
                        vim.api.nvim_buf_get_name(0),
                    }
                end,
                stdin = true
            },
            stylua = {
                command = 'stylua',
                args = {
                    '--search-parent-directories', '--stdin-filepath', '%:p', '-'
                },
            },
            format_after_save = {
                lsp_fallback = true,
                async = true,
                timeout_ms = 1500,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                lsp_fallback = true,
                async = true,
                timeout_ms = 1500,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
