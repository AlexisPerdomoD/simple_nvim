---@diagnostic disable: undefined-global
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",

        "Hoffs/omnisharp-extended-lsp.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvimdev/lspsaga.nvim",
    },
    event = "VeryLazy",
    config = function()
        -- snippets

        require("neodev").setup()
        require("lspsaga").setup({
            -- "󰅂 ",
            ui = {
                border = "rounded",
                code_action = "⚡",
            },
            diagnostic = {
                on_insert = false,
                --  show_code_action = true, -- Muestra una acción rápida al diagnosticar.
                border_follow = true, -- Sigue el contorno para diagnósticos flotantes.
            },
            lightbulb = {
                enable = true,
                virtual_text = false,
            },
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local on_attach = function(_, bufnr)
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" -- algo de autocompletadito
            local opts = { buffer = bufnr, noremap = true, silent = true }

            -- vim.keymap.set("n", ".e", vim.diagnostic.open_float)
            -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", ".e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
            vim.keymap.set("n", ".E", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
            vim.keymap.set("n", ".L", vim.diagnostic.setloclist)

            vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
            vim.keymap.set("n", "DE", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "..", "<cmd>Lspsaga hover_doc<CR>", opts)

            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set("n", "td", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
            -- vim.keymap.set("n", "rn", "<cmd>Lspsaga rename<CR>", opts)
            -- vim.keymap.set({ "n", "v" }, "ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "ca", "<cmd>Lspsaga code_action<CR>", opts)
            -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

            -- vim.keymap.set("n", "gr", "<cmd>Lspsaga finder def+ref<CR>", opts)
            vim.keymap.set("n", "gr", "<cmd>Lspsaga finder ref<CR>", opts)
        end
        -- -- defaults to omnisharp (dotnet)

        require("lspconfig").bashls.setup({
            filetypes = { "sh", "bash", "zsh" }, -- Incluye Bash y Zsh
            cmd = { "bash-language-server", "start" },
            on_attach = on_attach,
        })
        require("lspconfig").lua_ls.setup({
            comand = "lua-language-server",
            on_attach = on_attach,
            capabilities = capabilities,
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        version = "LuaJIT",
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                        },
                    },
                })
            end,
            settings = {
                Lua = {
                    runtime = {
                        version = "Lua 5.2", -- Puede ser 'Lua 5.1' o 'Lua 5.3' dependiendo de tu entorno
                        path = vim.split(package.path, ";"),
                    },
                    diagnostic = {
                        globals = { "vim" },
                    },
                    telemetry = { enable = false },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                        maxPreload = 2000,
                        preLoadFileSize = 1000,
                    },
                },
            },
        })
        require("lspconfig").ts_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
                "javascript",
                ".js",
                ".ts",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
        })
        require("lspconfig").html.setup({
            capabilities = capabilities,
            options = {
                filetype = { "html", "templ", "handlebars", ".handlebars" },
            },
        })

        require("lspconfig").markdown_oxide.setup({})
        -- require("lspconfig").marksman.setup({})
        require("lspconfig").jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        require("lspconfig").css_variables.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        require("lspconfig").cssls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        require("lspconfig").tailwindcss.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        require("lspconfig").sqls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                sqls = {
                    connections = {
                        {
                            driver = "postgresql",
                            dataSourceName = "host=localhost port=5432 user=postgres password=password dbname=base sslmode=disable",
                        },
                    },
                },
            },
        })
        require("lspconfig").yamlls.setup({
            capabilities = capabilities,
        })
        -- defaults to gopls
        require("lspconfig").gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = require("lspconfig").util.root_pattern("go.work", "go.mod", ".git"),
            cmd = { "gopls", "serve" },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        })
        --defaults to golangci-lint
        require("lspconfig").golangci_lint_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "golangci-lint-langserver" },
            filetypes = { "go", "gomod" },
            root_dir = require("lspconfig").util.root_pattern(
                ".golangci.yml",
                ".golangci.yaml",
                ".golangci.toml",
                ".golangci.json",
                "go.work",
                "go.mod",
                ".git"
            ),
        })

        require("lspconfig").omnisharp.setup({
            cmd = { "OmniSharp" },

            filetypes = { "cs", "vb" },
            handlers = { ["textDocument/definition"] = require("omnisharp_extended").handler },
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = require("lspconfig").util.root_pattern("*.csproj", ".git", "*.sln"),
            settings = {
                FormattingOptions = {
                    EnableEditorConfigSupport = true,
                    OrganizeImports = true,
                },
                MsBuild = {
                    LoadProjectsOnDemand = nil,
                },
                RoslynExtensionsOptions = {
                    EnableDecompilationSupport = true,
                    EnableAnalyzersSupport = true,
                    EnableImportCompletion = true,
                    AnalyzeOpenDocumentsOnly = nil,
                    enableDecompilationSupport = false,
                },
                Sdk = {
                    IncludePrereleases = true,
                },
            },
            -- enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            enable_import_completion = true,
        })
        require("lspconfig").nixd.setup({
            on_attach = on_attach,
            cmd = { "nixd" },
            settings = {
                nixd = {
                    nixpkgs = {
                        expr = "import <nixpkgs> { }",
                    },
                    formatting = {
                        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
                    },
                    filetypes = { "nix" },
                    -- options = {
                    --   nixos = {
                    --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
                    --   },
                    --   home_manager = {
                    --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
                    --   },
                    -- },
                },
            },
        })

        require("lspconfig").hyprls.setup({})
    end,
}
