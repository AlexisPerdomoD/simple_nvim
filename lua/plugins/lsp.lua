return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
    },
    event = 'VeryLazy',
    config = function()
        vim.keymap.set('n', '.e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '.q', vim.diagnostic.setloclist)

        local on_attach = function(_, bufnr)
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- algo de autocompletadito
            local opts = { buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '..', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', 'td', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, 'ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            -- code actions
            -- vim.keymap.set({ 'n', 'v' }, '.ca', vim.lsp.buf.code_action, opts)
            --vim.keymap.set('n', '<leader>f', function()
            --  vim.lsp.buf.format { async = true }
            --end, opts)
        end

        require("neodev").setup()
        require("lspconfig").bashls.setup({
            filetypes = { "sh", "bash", "zsh" }, -- Incluye Bash y Zsh
            cmd = { "bash-language-server", "start" },
            on_attach = on_attach
        })
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
        require('lspconfig').ts_ls.setup({
            on_attach = on_attach,
        })
        --Enable (broadcasting) snippet capability for completion
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        -- Neovim does not currently include built-in snippets. vscode-html-language-server only provides completions when snippet support is enabled. To enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.

        -- The code-formatting feature of the lsp can be controlled with the provideFormatter option.
        require 'lspconfig'.html.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            options = {
                filetype = { 'html', 'templ', 'handlebars', '.handlebars' }
            }
        }
        require 'lspconfig'.jsonls.setup {
            capabilities = capabilities,
            on_attach = on_attach
        }

        -- An example nvim-lspconfig capabilities setting

        -- require("lspconfig").markdown_oxide.setup({
        --     -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
        --     -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
        --     capabilities = vim.tbl_deep_extend(
        --         'force',
        --         capabilities,
        --         {
        --             workspace = {
        --                 didChangeWatchedFiles = {
        --                     dynamicRegistration = true,
        --                 },
        --             },
        --         }
        --     ),
        --     on_attach = on_attach -- configure your on attach config
        -- })
        require 'lspconfig'.markdown_oxide.setup {
            on_attach = on_attach
        }
        require 'lspconfig'.css_variables.setup {
            on_attach = on_attach
        }
        require 'lspconfig'.cssls.setup {
            capabilities = capabilities,
            on_attach = on_attach
        }
        require 'lspconfig'.tailwindcss.setup {
            on_attach = on_attach
        }
        require 'lspconfig'.sqls.setup {
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
        -- defaults to omnisharp (dotnet)
        require 'lspconfig'.omnisharp.setup {
            cmd = { "omnisharp" },
            filetypes = { "cs", "vb" },
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = require('lspconfig').util.root_pattern('*.csproj', '.git', '*.sln'),
            settings = {
                FormattingOptions = {
                    -- Enables support for reading code style, naming convention and analyzer
                    -- settings from .editorconfig.
                    EnableEditorConfigSupport = true,
                    -- Specifies whether 'using' directives should be grouped and sorted during
                    -- document formatting.
                    OrganizeImports = nil,
                },
                MsBuild = {
                    -- If true, MSBuild project system will only load projects for files that
                    -- were opened in the editor. This setting is useful for big C# codebases
                    -- and allows for faster initialization of code navigation features only
                    -- for projects that are relevant to code that is being edited. With this
                    -- setting enabled OmniSharp may load fewer projects and may thus display
                    -- incomplete reference lists for symbols.
                    LoadProjectsOnDemand = nil,
                },
                RoslynExtensionsOptions = {
                    -- Enables support for roslyn analyzers, code fixes and rulesets.
                    EnableAnalyzersSupport = nil,
                    -- Enables support for showing unimported types and unimported extension
                    -- methods in completion lists. When committed, the appropriate using
                    -- directive will be added at the top of the current file. This option can
                    -- have a negative impact on initial completion responsiveness,
                    -- particularly for the first few completion sessions after opening a
                    -- solution.
                    EnableImportCompletion = nil,
                    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                    -- true
                    AnalyzeOpenDocumentsOnly = nil,
                },
                Sdk = {
                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    IncludePrereleases = true,
                },
            },
        }

        -- csharp alternative lighttier
        --     require 'lspconfig'.csharp_ls.setup {
        --         capabilities = capabilities,
        --         on_attach = on_attach,
        --         cmd = { "csharp-ls" },
        --         filetypes = { 'cs', 'csx', 'cake' },
        --         -- root_dir = require 'lspconfig'.util.root_pattern('global.json', '.git'),
        --     }
    end
}
