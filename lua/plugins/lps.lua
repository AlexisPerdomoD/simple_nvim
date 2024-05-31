return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        local on_attach = function(_, bufnr)
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- algo de autocompletadito
            local opts = { buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader><leader>', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            --vim.keymap.set('n', '<leader>f', function()
            --  vim.lsp.buf.format { async = true }
            --end, opts)
        end

        require("neodev").setup()
        require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT', -- Puede ser 'Lua 5.1' o 'Lua 5.3' dependiendo de tu entorno
                        path = vim.split(package.path, ';')
                    },
                    diagnostic = {
                        globals = { 'vim' }
                    },
                    telemetry = { enable = false },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.stdpath('config') .. '/lua'] = true,
                            [vim.fn.expand('$HOME/.config/wezterm')] = true, -- Asegúrate de que incluye la ruta de wezterm
                        },
                        maxPreload = 2000,
                        preLoadFileSize = 1000,
                    },
                }
            }
        })
        require('lspconfig').tsserver.setup({
            on_attach = on_attach
        })
        --Enable (broadcasting) snippet capability for completion
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        -- Neovim does not currently include built-in snippets. vscode-html-language-server only provides completions when snippet support is enabled. To enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.

        -- The code-formatting feature of the lsp can be controlled with the provideFormatter option.
        require('lspconfig').html.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            options = {
                filetype = { 'html', 'templ', 'handlebars' }
            }
        })
        require('lspconfig').jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach
        })
        require('lspconfig').markdown_oxide.setup({
            on_attach = on_attach
        })
        require 'lspconfig'.css_variables.setup {
            on_attach = on_attach
        }
        require 'lspconfig'.cssls.setup {
            capabilities = capabilities,
            on_attach = on_attach
        }
        require 'lspconfig'.yamlls.setup {
            capabilities = capabilities,
            on_attach = on_attach
        }
        -- defaults to gopls
        require 'lspconfig'.gopls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
            root_dir = require 'lspconfig'.util.root_pattern("go.work", "go.mod", ".git"),
            cmd = { "gopls", "serve" },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        }
        --defaults to golangci-lint
        require 'lspconfig'.golangci_lint_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "golangci-lint-langserver" },
            filetypes = { 'go', 'gomod' },
            root_dir = require 'lspconfig'.util.root_pattern('.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', "go.work", "go.mod", ".git"),
        }
    end
}
