return {
    'nvimtools/none-ls.nvim',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    config = function()
        local nullls = require("null-ls")
        nullls.setup({
            source = {
                -- formaters
                nullls.builtins.formatting.stylua.with({
                    extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/.stylua.toml") }
                }),
                -- nullls.builtins.formatting.prettier.with({
                --     extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/.prettierrc.json") }
                -- }),
                nullls.builtins.formatting.prettierd.with({
                    -- extra_args = function()
                    --     return {
                    --         "--trailing-comma", "none",
                    --         "--tab-width", "8",
                    --         "--semi", "false",
                    --         "--single-quote", "true",
                    --         "--print-width", "120"
                    --     }
                    -- end,
                    env = {
                        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/.prettierrc.json")
                    }
                }),
                nullls.builtins.formatting.shfmt,
                nullls.builtins.formatting.yamlfmt,

                -- diagnostics
                -- nullls.builtins.diagnostics.shellcheck.with({
                --     diagnostic_config = {
                --         -- see :help vim.diagnostic.config()
                --         underline = true,
                --         virtual_text = false,
                --         signs = true,
                --         update_in_insert = false,
                --         severity_sort = true,
                --     },
                --     filetypes = { "markdown" },
                -- }),
                --nullls.builtins.diagnostics.eslint_d.with
                -- nullls.builtins.diagnostics.eslint.with({
                --     env = {
                --         ESLINT_D_CONFIG = vim.fn.expand("~/.config/nvim/.eslintrc.json")
                --     },
                --     condition = function(utils)
                --         return utils.root_has_file({ ".eslintrc.json" })
                --     end,
                --     diagnostics_format = "#{m} (#{s})",
                --     comand = "/home/sixela/.nvm/versions/node/v20.13.1/bin/eslint_d"
                -- })
                --,
                -- nullls.builtins.diagnostics.htmlhint,
            }
        })
        -- set formating from null-ls in lsp
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end)
    end


}

-- REFERENCES
-- -- local defaults = {
--     border = nil,
--     cmd = { "nvim" },
--     debounce = 250,
--     debug = false,
--     default_timeout = 5000,
--     diagnostic_config = {},
--     diagnostics_format = "#{m}",
--     fallback_severity = vim.diagnostic.severity.ERROR,
--     log_level = "warn",
--     notify_format = "[null-ls] %s",
--     on_attach = nil,
--     on_init = nil,
--     on_exit = nil,
--     root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
--     root_dir_async = nil,
--     should_attach = nil,
--     sources = nil,
--     temp_dir = nil,
--     update_in_insert = false,
-- }
