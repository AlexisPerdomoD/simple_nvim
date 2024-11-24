return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                --svelte = { "prettier" },
                css = { "prettierd" },
                html = { "prettierd" },
                json = { "prettierd" },
                yaml = { "yamlfmt" },
                markdown = { "prettierd" },
                --graphql = { "prettier" },
                lua = { "stylua" },
                bash = { "shfmt" },
                sh = { "shfmt" },
                zsh = { "shfmt" },
                cs = { "dotnet format" },
                nix = { "nixpkgs_fmt" },
                xml = { "xmlformat" },
            },
            shfmt = {
                options = { "-i", "2", "-ci" },
            },
            prettier = {
                -- command = vim.fn.stdpath("data") .. "/mason/bin/pretierd", -- Ruta a prettier instalado por Mason
                inherit = false,
                command = "prettierd",
                args = function()
                    local config_path = vim.fn.findfile(".prettierrc", ".;")
                        or vim.fn.findfile(".prettierrc.json", ".;")
                        or vim.fn.findfile(".prettierrc.js", ".;")
                        or vim.fn.findfile(".prettierrc.yaml", ".;")
                        or vim.fn.findfile(".prettierrc.yml", ".;")

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
                stdin = true,
            },
            stylua = {
                command = "stylua",
                args = {
                    "--search-parent-directories",
                    "--stdin-filepath",
                    "%:p",
                    "-",
                },
            },

            nixpkgs_fmt = {
                command = "nixpkgs-fmt",
                args = {
                    "--stdin-filepath",
                    "%:p",
                    "-",
                },
            },
            xmlformat = {
                command = "xmlformat",
                args = {
                    "--stdin-filepath",
                    "%:p",
                    "-",
                },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },

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
